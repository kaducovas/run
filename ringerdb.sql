--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4 (Ubuntu 11.4-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.4 (Ubuntu 11.4-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: pymax(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pymax(a integer, b integer) RETURNS integer
    LANGUAGE plpython3u
    AS $$
             if a > b:
                 return a
             return b
          $$;


ALTER FUNCTION public.pymax(a integer, b integer) OWNER TO postgres;

--
-- Name: pymax222(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.pymax222(a integer, b integer) RETURNS integer
    LANGUAGE plpython3u
    AS $$
		  if a > b:
		  	return a
		  print(str(b))
		  return b
		$$;


ALTER FUNCTION public.pymax222(a integer, b integer) OWNER TO postgres;

--
-- Name: reconretrievemodelencodingdim(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reconretrievemodelencodingdim(x text) RETURNS integer
    LANGUAGE plpython3u
    AS $$    
    model_list = x.split('_')
    if 'NLPCA' in x:
        encodingDim = int(x.split('_')[-1].split('-')[1])
    elif 'FT' in x:
        encodingDim = int(x.split('_')[-1].split('-')[0])
    else:
        encodingDim = int(x.split('_')[-1])
		
    return encodingDim
	
	$$;


ALTER FUNCTION public.reconretrievemodelencodingdim(x text) OWNER TO postgres;

--
-- Name: reconretrievemodelname(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reconretrievemodelname(x text) RETURNS text
    LANGUAGE plpython3u
    AS $$
    
    model_list = x.split('_')
    #print x, len(model_list)
    if len(model_list) == 2:
        model_name = model_list[0]
    elif len(model_list) == 3:
        model_name = model_list[0]+'-'+'2Layers'
    elif len(model_list) == 4:
        model_name = model_list[0]+'-'+'3Layers'
    elif len(model_list) == 6:
        model_name = model_list[0]+'-'+'5Layers'
    elif len(model_list) == 9:
        model_name = model_list[0]+'-'+'8Layers'
    if 'FT' in x:
        model_name=model_name+'-FT'
    return model_name
	$$;


ALTER FUNCTION public.reconretrievemodelname(x text) OWNER TO postgres;

--
-- Name: retrievemodelencodingdim(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.retrievemodelencodingdim(x text) RETURNS integer
    LANGUAGE plpython3u
    AS $$
    
    model_list = x.split('_')
    if 'NLPCA' in x:
        encodingDim = int(x.split('_')[-2].split('-')[1])
    elif 'FT' in x:
        encodingDim = int(x.split('_')[-2].split('-')[0])
    elif x == 'N1_':
        encodingDim = 100
    else:
        encodingDim = int(x.split('_')[-2])
    return encodingDim
	
	$$;


ALTER FUNCTION public.retrievemodelencodingdim(x text) OWNER TO postgres;

--
-- Name: retrievemodelname(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.retrievemodelname(x text) RETURNS text
    LANGUAGE plpython3u
    AS $$
    
    model_list = x.split('_')
    #print x, len(model_list)
    if len(model_list) == 3:
        model_name = model_list[0]
    elif len(model_list) == 4:
        model_name = model_list[0]+'-'+'2Layers'
    elif len(model_list) == 5:
        model_name = model_list[0]+'-'+'3Layers'
    elif len(model_list) == 7:
        model_name = model_list[0]+'-'+'5Layers'
    elif len(model_list) == 10:
        model_name = model_list[0]+'-'+'8Layers'
    elif len(model_list) == 2:
        model_name = 'Ringer'
    if 'FT' in x:
        model_name=model_name+'-FT'
    return model_name
	$$;


ALTER FUNCTION public.retrievemodelname(x text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: classifiers; Type: TABLE; Schema: public; Owner: ringer
--

CREATE TABLE public.classifiers (
    id integer NOT NULL,
    point text,
    model text,
    hl_neuron integer,
    "time" text,
    sort integer,
    etbinidx integer,
    etabinidx integer,
    phase text,
    elapsed text,
    fine_tuning text,
    signal_samples integer,
    bkg_samples integer,
    signal_pred_samples integer,
    bkg_pred_samples integer,
    threshold double precision,
    sp double precision,
    pd double precision,
    pf double precision,
    accuracy double precision,
    mse double precision,
    f1 double precision,
    auc double precision,
    "precision" double precision,
    recall double precision
);


ALTER TABLE public.classifiers OWNER TO ringer;

--
-- Name: classifier_top; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.classifier_top AS
 SELECT concat('et_', t.etbinidx, '_eta_', t.etabinidx) AS bin,
    public.retrievemodelencodingdim(t.model) AS encoding,
    public.retrievemodelname(t.model) AS model_name,
    t.point,
    t.model,
    t."time",
    t.sort,
    t.etbinidx,
    t.etabinidx,
    t.phase,
    t.pd,
    t.pf,
    t.mse,
    t."precision",
    t.f1,
    t.auc,
    t.recall,
    t.sp,
    t.rank
   FROM ( SELECT classifiers.point,
            classifiers.model,
            classifiers."time",
            classifiers.sort,
            classifiers.etbinidx,
            classifiers.etabinidx,
            classifiers.phase,
            classifiers.pd,
            classifiers.pf,
            classifiers.mse,
            classifiers."precision",
            classifiers.f1,
            classifiers.auc,
            classifiers.recall,
            classifiers.sp,
            rank() OVER (PARTITION BY classifiers.point, classifiers.model, classifiers."time", classifiers.sort, classifiers.etbinidx, classifiers.etabinidx, classifiers.phase ORDER BY classifiers.sp DESC, classifiers.id) AS rank
           FROM public.classifiers) t
  WHERE (t.rank = 1);


ALTER TABLE public.classifier_top OWNER TO postgres;

--
-- Name: reconstruction_metrics; Type: TABLE; Schema: public; Owner: ringer
--

CREATE TABLE public.reconstruction_metrics (
    id integer NOT NULL,
    class text,
    model text,
    layer text,
    "time" text,
    measure text,
    normed text,
    sort integer,
    etbinidx integer,
    etabinidx integer,
    phase text,
    "1" double precision,
    "2" double precision,
    "3" double precision,
    "4" double precision,
    "5" double precision,
    "6" double precision,
    "7" double precision,
    "8" double precision,
    "9" double precision,
    "10" double precision,
    "11" double precision,
    "12" double precision,
    "13" double precision,
    "14" double precision,
    "15" double precision,
    "16" double precision,
    "17" double precision,
    "18" double precision,
    "19" double precision,
    "20" double precision,
    "21" double precision,
    "22" double precision,
    "23" double precision,
    "24" double precision,
    "25" double precision,
    "26" double precision,
    "27" double precision,
    "28" double precision,
    "29" double precision,
    "30" double precision,
    "31" double precision,
    "32" double precision,
    "33" double precision,
    "34" double precision,
    "35" double precision,
    "36" double precision,
    "37" double precision,
    "38" double precision,
    "39" double precision,
    "40" double precision,
    "41" double precision,
    "42" double precision,
    "43" double precision,
    "44" double precision,
    "45" double precision,
    "46" double precision,
    "47" double precision,
    "48" double precision,
    "49" double precision,
    "50" double precision,
    "51" double precision,
    "52" double precision,
    "53" double precision,
    "54" double precision,
    "55" double precision,
    "56" double precision,
    "57" double precision,
    "58" double precision,
    "59" double precision,
    "60" double precision,
    "61" double precision,
    "62" double precision,
    "63" double precision,
    "64" double precision,
    "65" double precision,
    "66" double precision,
    "67" double precision,
    "68" double precision,
    "69" double precision,
    "70" double precision,
    "71" double precision,
    "72" double precision,
    "73" double precision,
    "74" double precision,
    "75" double precision,
    "76" double precision,
    "77" double precision,
    "78" double precision,
    "79" double precision,
    "80" double precision,
    "81" double precision,
    "82" double precision,
    "83" double precision,
    "84" double precision,
    "85" double precision,
    "86" double precision,
    "87" double precision,
    "88" double precision,
    "89" double precision,
    "90" double precision,
    "91" double precision,
    "92" double precision,
    "93" double precision,
    "94" double precision,
    "95" double precision,
    "96" double precision,
    "97" double precision,
    "98" double precision,
    "99" double precision,
    "100" double precision,
    etotal double precision,
    ps double precision,
    em1 double precision,
    em2 double precision,
    em3 double precision,
    em double precision,
    had1 double precision,
    had2 double precision,
    had3 double precision,
    had double precision
);


ALTER TABLE public.reconstruction_metrics OWNER TO ringer;

--
-- Name: reconstruction; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.reconstruction AS
 SELECT reconstruction_metrics.id,
    concat('et_', reconstruction_metrics.etbinidx, '_eta_', reconstruction_metrics.etabinidx) AS bin,
    public.reconretrievemodelname(reconstruction_metrics.model) AS model_name,
    public.reconretrievemodelencodingdim(reconstruction_metrics.model) AS encoding,
    reconstruction_metrics.class,
    reconstruction_metrics.model,
    reconstruction_metrics.layer,
    reconstruction_metrics."time",
    reconstruction_metrics.measure,
    reconstruction_metrics.normed,
    reconstruction_metrics.sort,
    reconstruction_metrics.etbinidx,
    reconstruction_metrics.etabinidx,
    reconstruction_metrics.phase,
    reconstruction_metrics."1",
    reconstruction_metrics."2",
    reconstruction_metrics."3",
    reconstruction_metrics."4",
    reconstruction_metrics."5",
    reconstruction_metrics."6",
    reconstruction_metrics."7",
    reconstruction_metrics."8",
    reconstruction_metrics."9",
    reconstruction_metrics."10",
    reconstruction_metrics."11",
    reconstruction_metrics."12",
    reconstruction_metrics."13",
    reconstruction_metrics."14",
    reconstruction_metrics."15",
    reconstruction_metrics."16",
    reconstruction_metrics."17",
    reconstruction_metrics."18",
    reconstruction_metrics."19",
    reconstruction_metrics."20",
    reconstruction_metrics."21",
    reconstruction_metrics."22",
    reconstruction_metrics."23",
    reconstruction_metrics."24",
    reconstruction_metrics."25",
    reconstruction_metrics."26",
    reconstruction_metrics."27",
    reconstruction_metrics."28",
    reconstruction_metrics."29",
    reconstruction_metrics."30",
    reconstruction_metrics."31",
    reconstruction_metrics."32",
    reconstruction_metrics."33",
    reconstruction_metrics."34",
    reconstruction_metrics."35",
    reconstruction_metrics."36",
    reconstruction_metrics."37",
    reconstruction_metrics."38",
    reconstruction_metrics."39",
    reconstruction_metrics."40",
    reconstruction_metrics."41",
    reconstruction_metrics."42",
    reconstruction_metrics."43",
    reconstruction_metrics."44",
    reconstruction_metrics."45",
    reconstruction_metrics."46",
    reconstruction_metrics."47",
    reconstruction_metrics."48",
    reconstruction_metrics."49",
    reconstruction_metrics."50",
    reconstruction_metrics."51",
    reconstruction_metrics."52",
    reconstruction_metrics."53",
    reconstruction_metrics."54",
    reconstruction_metrics."55",
    reconstruction_metrics."56",
    reconstruction_metrics."57",
    reconstruction_metrics."58",
    reconstruction_metrics."59",
    reconstruction_metrics."60",
    reconstruction_metrics."61",
    reconstruction_metrics."62",
    reconstruction_metrics."63",
    reconstruction_metrics."64",
    reconstruction_metrics."65",
    reconstruction_metrics."66",
    reconstruction_metrics."67",
    reconstruction_metrics."68",
    reconstruction_metrics."69",
    reconstruction_metrics."70",
    reconstruction_metrics."71",
    reconstruction_metrics."72",
    reconstruction_metrics."73",
    reconstruction_metrics."74",
    reconstruction_metrics."75",
    reconstruction_metrics."76",
    reconstruction_metrics."77",
    reconstruction_metrics."78",
    reconstruction_metrics."79",
    reconstruction_metrics."80",
    reconstruction_metrics."81",
    reconstruction_metrics."82",
    reconstruction_metrics."83",
    reconstruction_metrics."84",
    reconstruction_metrics."85",
    reconstruction_metrics."86",
    reconstruction_metrics."87",
    reconstruction_metrics."88",
    reconstruction_metrics."89",
    reconstruction_metrics."90",
    reconstruction_metrics."91",
    reconstruction_metrics."92",
    reconstruction_metrics."93",
    reconstruction_metrics."94",
    reconstruction_metrics."95",
    reconstruction_metrics."96",
    reconstruction_metrics."97",
    reconstruction_metrics."98",
    reconstruction_metrics."99",
    reconstruction_metrics."100",
    reconstruction_metrics.etotal,
    reconstruction_metrics.ps,
    reconstruction_metrics.em1,
    reconstruction_metrics.em2,
    reconstruction_metrics.em3,
    reconstruction_metrics.em,
    reconstruction_metrics.had1,
    reconstruction_metrics.had2,
    reconstruction_metrics.had3,
    reconstruction_metrics.had,
    ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((reconstruction_metrics."1" + reconstruction_metrics."2") + reconstruction_metrics."3") + reconstruction_metrics."4") + reconstruction_metrics."5") + reconstruction_metrics."6") + reconstruction_metrics."7") + reconstruction_metrics."8") + reconstruction_metrics."9") + reconstruction_metrics."10") + reconstruction_metrics."11") + reconstruction_metrics."12") + reconstruction_metrics."13") + reconstruction_metrics."14") + reconstruction_metrics."15") + reconstruction_metrics."16") + reconstruction_metrics."17") + reconstruction_metrics."18") + reconstruction_metrics."19") + reconstruction_metrics."20") + reconstruction_metrics."21") + reconstruction_metrics."22") + reconstruction_metrics."23") + reconstruction_metrics."24") + reconstruction_metrics."25") + reconstruction_metrics."26") + reconstruction_metrics."27") + reconstruction_metrics."28") + reconstruction_metrics."29") + reconstruction_metrics."30") + reconstruction_metrics."31") + reconstruction_metrics."32") + reconstruction_metrics."33") + reconstruction_metrics."34") + reconstruction_metrics."35") + reconstruction_metrics."36") + reconstruction_metrics."37") + reconstruction_metrics."38") + reconstruction_metrics."39") + reconstruction_metrics."40") + reconstruction_metrics."41") + reconstruction_metrics."42") + reconstruction_metrics."43") + reconstruction_metrics."44") + reconstruction_metrics."45") + reconstruction_metrics."46") + reconstruction_metrics."47") + reconstruction_metrics."48") + reconstruction_metrics."49") + reconstruction_metrics."50") + reconstruction_metrics."51") + reconstruction_metrics."52") + reconstruction_metrics."53") + reconstruction_metrics."54") + reconstruction_metrics."55") + reconstruction_metrics."56") + reconstruction_metrics."57") + reconstruction_metrics."58") + reconstruction_metrics."59") + reconstruction_metrics."60") + reconstruction_metrics."61") + reconstruction_metrics."62") + reconstruction_metrics."63") + reconstruction_metrics."64") + reconstruction_metrics."65") + reconstruction_metrics."66") + reconstruction_metrics."67") + reconstruction_metrics."68") + reconstruction_metrics."69") + reconstruction_metrics."70") + reconstruction_metrics."71") + reconstruction_metrics."72") + reconstruction_metrics."73") + reconstruction_metrics."74") + reconstruction_metrics."75") + reconstruction_metrics."76") + reconstruction_metrics."77") + reconstruction_metrics."78") + reconstruction_metrics."79") + reconstruction_metrics."80") + reconstruction_metrics."81") + reconstruction_metrics."82") + reconstruction_metrics."83") + reconstruction_metrics."84") + reconstruction_metrics."85") + reconstruction_metrics."86") + reconstruction_metrics."87") + reconstruction_metrics."88") + reconstruction_metrics."89") + reconstruction_metrics."90") + reconstruction_metrics."91") + reconstruction_metrics."93") + reconstruction_metrics."94") + reconstruction_metrics."95") + reconstruction_metrics."97") + reconstruction_metrics."98") + reconstruction_metrics."99"))::real / (97)::real) AS rings_metrics_avg,
    ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((reconstruction_metrics."1" + reconstruction_metrics."2") + reconstruction_metrics."3") + reconstruction_metrics."4") + reconstruction_metrics."5") + reconstruction_metrics."6") + reconstruction_metrics."7") + reconstruction_metrics."8") + reconstruction_metrics."9") + reconstruction_metrics."10") + reconstruction_metrics."11") + reconstruction_metrics."12") + reconstruction_metrics."13") + reconstruction_metrics."14") + reconstruction_metrics."15") + reconstruction_metrics."16") + reconstruction_metrics."17") + reconstruction_metrics."18") + reconstruction_metrics."19") + reconstruction_metrics."20") + reconstruction_metrics."21") + reconstruction_metrics."22") + reconstruction_metrics."23") + reconstruction_metrics."24") + reconstruction_metrics."25") + reconstruction_metrics."26") + reconstruction_metrics."27") + reconstruction_metrics."28") + reconstruction_metrics."29") + reconstruction_metrics."30") + reconstruction_metrics."31") + reconstruction_metrics."32") + reconstruction_metrics."33") + reconstruction_metrics."34") + reconstruction_metrics."35") + reconstruction_metrics."36") + reconstruction_metrics."37") + reconstruction_metrics."38") + reconstruction_metrics."39") + reconstruction_metrics."40") + reconstruction_metrics."41") + reconstruction_metrics."42") + reconstruction_metrics."43") + reconstruction_metrics."44") + reconstruction_metrics."45") + reconstruction_metrics."46") + reconstruction_metrics."47") + reconstruction_metrics."48") + reconstruction_metrics."49") + reconstruction_metrics."50") + reconstruction_metrics."51") + reconstruction_metrics."52") + reconstruction_metrics."53") + reconstruction_metrics."54") + reconstruction_metrics."55") + reconstruction_metrics."56") + reconstruction_metrics."57") + reconstruction_metrics."58") + reconstruction_metrics."59") + reconstruction_metrics."60") + reconstruction_metrics."61") + reconstruction_metrics."62") + reconstruction_metrics."63") + reconstruction_metrics."64") + reconstruction_metrics."65") + reconstruction_metrics."66") + reconstruction_metrics."67") + reconstruction_metrics."68") + reconstruction_metrics."69") + reconstruction_metrics."70") + reconstruction_metrics."71") + reconstruction_metrics."72") + reconstruction_metrics."73") + reconstruction_metrics."74") + reconstruction_metrics."75") + reconstruction_metrics."76") + reconstruction_metrics."77") + reconstruction_metrics."78") + reconstruction_metrics."79") + reconstruction_metrics."80") + reconstruction_metrics."81") + reconstruction_metrics."82") + reconstruction_metrics."83") + reconstruction_metrics."84") + reconstruction_metrics."85") + reconstruction_metrics."86") + reconstruction_metrics."87") + reconstruction_metrics."88") + reconstruction_metrics."89") + reconstruction_metrics."90") + reconstruction_metrics."91") + reconstruction_metrics."93") + reconstruction_metrics."94") + reconstruction_metrics."95") + reconstruction_metrics."97") + reconstruction_metrics."98") + reconstruction_metrics."99") AS rings_metrics_sum
   FROM public.reconstruction_metrics
  WHERE (((reconstruction_metrics.layer)::integer, reconstruction_metrics."time") IN ( SELECT min((reconstruction_metrics_1.layer)::integer) AS layer,
            reconstruction_metrics_1."time"
           FROM public.reconstruction_metrics reconstruction_metrics_1
          GROUP BY reconstruction_metrics_1."time"));


ALTER TABLE public.reconstruction OWNER TO postgres;

--
-- Name: all_metrics; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.all_metrics AS
 SELECT r.bin,
    r.model_name,
    r.encoding,
    r.model,
    r.layer,
    r."time",
    r.sort,
    r.etbinidx,
    r.etabinidx,
    c.phase,
    c.point,
    c.pd,
    c.pf,
    c.mse,
    c."precision",
    c.f1,
    c.auc,
    c.recall,
    c.sp,
    r.class,
    r.measure,
    r.normed,
    r.etotal,
    r.ps,
    r.em1,
    r.em2,
    r.em3,
    r.em,
    r.had1,
    r.had2,
    r.had3,
    r.had,
    r.rings_metrics_avg,
    r.rings_metrics_sum,
    r."1",
    r."2",
    r."3",
    r."4",
    r."5",
    r."6",
    r."7",
    r."8",
    r."9",
    r."10",
    r."11",
    r."12",
    r."13",
    r."14",
    r."15",
    r."16",
    r."17",
    r."18",
    r."19",
    r."20",
    r."21",
    r."22",
    r."23",
    r."24",
    r."25",
    r."26",
    r."27",
    r."28",
    r."29",
    r."30",
    r."31",
    r."32",
    r."33",
    r."34",
    r."35",
    r."36",
    r."37",
    r."38",
    r."39",
    r."40",
    r."41",
    r."42",
    r."43",
    r."44",
    r."45",
    r."46",
    r."47",
    r."48",
    r."49",
    r."50",
    r."51",
    r."52",
    r."53",
    r."54",
    r."55",
    r."56",
    r."57",
    r."58",
    r."59",
    r."60",
    r."61",
    r."62",
    r."63",
    r."64",
    r."65",
    r."66",
    r."67",
    r."68",
    r."69",
    r."70",
    r."71",
    r."72",
    r."73",
    r."74",
    r."75",
    r."76",
    r."77",
    r."78",
    r."79",
    r."80",
    r."81",
    r."82",
    r."83",
    r."84",
    r."85",
    r."86",
    r."87",
    r."88",
    r."89",
    r."90",
    r."91",
    r."92",
    r."93",
    r."94",
    r."95",
    r."96",
    r."97",
    r."98",
    r."99",
    r."100"
   FROM (public.reconstruction r
     JOIN public.classifier_top c ON (((r."time" = c."time") AND (r.sort = c.sort))));


ALTER TABLE public.all_metrics OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: ringer
--

CREATE SEQUENCE public.task_id_seq
    START WITH 180
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.task_id_seq OWNER TO ringer;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: ringer
--

CREATE TABLE public.tasks (
    id integer DEFAULT nextval('public.task_id_seq'::regclass) NOT NULL,
    context text NOT NULL,
    datetime timestamp without time zone,
    "time" text NOT NULL,
    model text NOT NULL,
    hl_neuron integer,
    inits integer,
    sort integer,
    etbinidx integer,
    etabinidx integer,
    preproc text,
    conf jsonb,
    operationpoint text,
    dimension integer NOT NULL,
    fine_tuning text,
    owner text,
    status text,
    elapsed time without time zone,
    endtime timestamp without time zone,
    attempts integer DEFAULT 0,
    trigger text,
    dataset text,
    priority integer
);


ALTER TABLE public.tasks OWNER TO ringer;

--
-- Name: check_models_by_bin; Type: VIEW; Schema: public; Owner: ringer
--

CREATE VIEW public.check_models_by_bin AS
 SELECT concat('et_', classifiers.etbinidx, '_eta_', classifiers.etabinidx) AS bin,
    public.retrievemodelname(classifiers.model) AS modelname,
    count(*) AS count
   FROM public.classifiers
  WHERE ((classifiers.sort, classifiers."time") IN ( SELECT tasks.sort,
            tasks."time"
           FROM public.tasks
          WHERE ((tasks.status = 'finished'::text) AND (tasks.context = 'official'::text))))
  GROUP BY (concat('et_', classifiers.etbinidx, '_eta_', classifiers.etabinidx)), (public.retrievemodelname(classifiers.model))
  ORDER BY (concat('et_', classifiers.etbinidx, '_eta_', classifiers.etabinidx)), (public.retrievemodelname(classifiers.model));


ALTER TABLE public.check_models_by_bin OWNER TO ringer;

--
-- Name: classifier_avg_sorts; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.classifier_avg_sorts AS
 SELECT classifier_top.bin,
    classifier_top.model_name,
    classifier_top.encoding,
    classifier_top.point,
    classifier_top.phase,
    ((100)::numeric * round((avg(classifier_top.sp))::numeric, 4)) AS sp
   FROM public.classifier_top
  GROUP BY classifier_top.bin, classifier_top.model_name, classifier_top.encoding, classifier_top.point, classifier_top.phase;


ALTER TABLE public.classifier_avg_sorts OWNER TO postgres;

--
-- Name: classifier_avg_std; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.classifier_avg_std AS
 SELECT classifier_top.bin,
    classifier_top.model_name,
    classifier_top.encoding,
    classifier_top.point,
    classifier_top.phase,
    concat(((100)::numeric * round((avg(classifier_top.sp))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top.sp))::numeric, 4))) AS sp,
    concat(((100)::numeric * round((avg(classifier_top.pd))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top.pd))::numeric, 4))) AS pd,
    concat(((100)::numeric * round((avg(classifier_top.pf))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top.pf))::numeric, 4))) AS pf,
    concat(round((avg(classifier_top.mse))::numeric, 4), ' +_ ', ((100)::numeric * round((stddev(classifier_top.mse))::numeric, 4))) AS mse,
    concat(((100)::numeric * round((avg(classifier_top.f1))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top.f1))::numeric, 4))) AS f1,
    concat(((100)::numeric * round((avg(classifier_top.auc))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top.auc))::numeric, 4))) AS auc,
    concat(((100)::numeric * round((avg(classifier_top."precision"))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top."precision"))::numeric, 4))) AS "precision",
    concat(((100)::numeric * round((avg(classifier_top.recall))::numeric, 4)), ' +- ', ((100)::numeric * round((stddev(classifier_top.recall))::numeric, 4))) AS recall
   FROM public.classifier_top
  GROUP BY classifier_top.bin, classifier_top.model_name, classifier_top.encoding, classifier_top.point, classifier_top.phase;


ALTER TABLE public.classifier_avg_std OWNER TO postgres;

--
-- Name: classifier_stddev_sorts; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.classifier_stddev_sorts AS
 SELECT classifier_top.bin,
    classifier_top.model_name,
    classifier_top.encoding,
    classifier_top.point,
    classifier_top.phase,
    ((100)::numeric * round((stddev(classifier_top.sp))::numeric, 4)) AS sp
   FROM public.classifier_top
  GROUP BY classifier_top.bin, classifier_top.model_name, classifier_top.encoding, classifier_top.point, classifier_top.phase;


ALTER TABLE public.classifier_stddev_sorts OWNER TO postgres;

--
-- Name: classifiers2latex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.classifiers2latex AS
 SELECT classifier_top.bin,
    classifier_top.model_name,
    classifier_top.encoding,
    classifier_top.point,
    classifier_top.phase,
    concat('$', replace(replace(replace(classifier_top.model_name, 'N1-'::text, ''::text), '-'::text, ' '::text), 'Layers'::text, ' Camadas'::text), '$', ' & ', round(((100)::numeric * (avg(classifier_top.sp))::numeric), 2), '$\pm$', round(((100)::numeric * (stddev(classifier_top.sp))::numeric), 2), ' & ', round(((100)::numeric * (avg(classifier_top.pd))::numeric), 2), '$\pm$', round(((100)::numeric * (stddev(classifier_top.pd))::numeric), 2), ' & ', round(((100)::numeric * (avg(classifier_top.pf))::numeric), 2), '$\pm$', round(((100)::numeric * (stddev(classifier_top.pf))::numeric), 2), ' & ', round(((100)::numeric * (avg(classifier_top.auc))::numeric), 2), '$\pm$', round(((100)::numeric * (stddev(classifier_top.auc))::numeric), 2), ' \\') AS concat
   FROM public.classifier_top
  GROUP BY classifier_top.bin, classifier_top.model_name, classifier_top.encoding, classifier_top.point, classifier_top.phase;


ALTER TABLE public.classifiers2latex OWNER TO postgres;

--
-- Name: classifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: ringer
--

CREATE SEQUENCE public.classifiers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classifiers_id_seq OWNER TO ringer;

--
-- Name: classifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ringer
--

ALTER SEQUENCE public.classifiers_id_seq OWNED BY public.classifiers.id;


--
-- Name: count_tasks_by_day; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.count_tasks_by_day AS
 SELECT to_char(tasks.endtime, 'YYYY-MM-DD'::text) AS dia,
    count(*) AS total,
    count(*) FILTER (WHERE (tasks.owner = 'cessy.lps.ufrj.br'::text)) AS cessy,
    count(*) FILTER (WHERE (tasks.owner = 'marselha.lps.ufrj.br'::text)) AS marselha,
    count(*) FILTER (WHERE (tasks.owner = 'verdun.lps.ufrj.br'::text)) AS verdun,
    count(*) FILTER (WHERE (tasks.owner = 'caducovas-MLlab'::text)) AS "cadu-lab",
    count(*) FILTER (WHERE (tasks.owner = 'techlab-x86-xeonphi-01.cern.ch'::text)) AS "techlab-cern",
    count(*) FILTER (WHERE (tasks.owner = 'caducovas-GPU'::text)) AS "caducovas-GPU",
    count(*) FILTER (WHERE (tasks.owner = 'cadu'::text)) AS cadu
   FROM public.tasks
  WHERE (tasks.status = 'finished'::text)
  GROUP BY (to_char(tasks.endtime, 'YYYY-MM-DD'::text))
  ORDER BY (to_char(tasks.endtime, 'YYYY-MM-DD'::text));


ALTER TABLE public.count_tasks_by_day OWNER TO postgres;

--
-- Name: count_tasks_by_dia; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.count_tasks_by_dia AS
 SELECT to_char(tasks.endtime, 'YYYY-MM-DD'::text) AS dia,
    count(*) AS total,
    count(*) FILTER (WHERE (tasks.owner = 'cessy.lps.ufrj.br'::text)) AS cessy,
    count(*) FILTER (WHERE (tasks.owner = 'marselha.lps.ufrj.br'::text)) AS marselha,
    count(*) FILTER (WHERE (tasks.owner = 'verdun.lps.ufrj.br'::text)) AS verdun,
    count(*) FILTER (WHERE (tasks.owner = 'caducovas-MLlab'::text)) AS "cadu-lab",
    count(*) FILTER (WHERE (tasks.owner = 'techlab-x86-xeonphi-01.cern.ch'::text)) AS "techlab-cern",
    count(*) FILTER (WHERE (tasks.owner = 'caducovas-GPU'::text)) AS "caducovas-GPU",
    count(*) FILTER (WHERE (tasks.owner = 'cadu'::text)) AS cadu
   FROM public.tasks
  WHERE (tasks.status = 'finished'::text)
  GROUP BY (to_char(tasks.endtime, 'YYYY-MM-DD'::text))
  ORDER BY (to_char(tasks.endtime, 'YYYY-MM-DD'::text));


ALTER TABLE public.count_tasks_by_dia OWNER TO postgres;

--
-- Name: count_tasks_by_hour; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.count_tasks_by_hour AS
 SELECT to_char(tasks.endtime, 'YYYY-MM-DD HH24:00'::text) AS hora,
    count(*) AS total,
    count(*) FILTER (WHERE (tasks.owner = 'cessy.lps.ufrj.br'::text)) AS cessy,
    count(*) FILTER (WHERE (tasks.owner = 'marselha.lps.ufrj.br'::text)) AS marselha,
    count(*) FILTER (WHERE (tasks.owner = 'verdun.lps.ufrj.br'::text)) AS verdun,
    count(*) FILTER (WHERE (tasks.owner = 'caducovas-MLlab'::text)) AS "cadu-lab",
    count(*) FILTER (WHERE (tasks.owner = 'techlab-x86-xeonphi-01.cern.ch'::text)) AS "techlab-cern",
    count(*) FILTER (WHERE (tasks.owner = 'caducovas-GPU'::text)) AS "caducovas-GPU",
    count(*) FILTER (WHERE (tasks.owner = 'cadu'::text)) AS cadu,
    count(*) FILTER (WHERE (tasks.owner = 'ringer'::text)) AS lpsgrid
   FROM public.tasks
  WHERE (tasks.status = 'finished'::text)
  GROUP BY (to_char(tasks.endtime, 'YYYY-MM-DD HH24:00'::text))
  ORDER BY (to_char(tasks.endtime, 'YYYY-MM-DD HH24:00'::text));


ALTER TABLE public.count_tasks_by_hour OWNER TO postgres;

--
-- Name: pgbench_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pgbench_accounts (
    aid integer NOT NULL,
    bid integer,
    abalance integer,
    filler character(84)
)
WITH (fillfactor='100');


ALTER TABLE public.pgbench_accounts OWNER TO postgres;

--
-- Name: pgbench_branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pgbench_branches (
    bid integer NOT NULL,
    bbalance integer,
    filler character(88)
)
WITH (fillfactor='100');


ALTER TABLE public.pgbench_branches OWNER TO postgres;

--
-- Name: pgbench_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pgbench_history (
    tid integer,
    bid integer,
    aid integer,
    delta integer,
    mtime timestamp without time zone,
    filler character(22)
);


ALTER TABLE public.pgbench_history OWNER TO postgres;

--
-- Name: pgbench_tellers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pgbench_tellers (
    tid integer NOT NULL,
    bid integer,
    tbalance integer,
    filler character(84)
)
WITH (fillfactor='100');


ALTER TABLE public.pgbench_tellers OWNER TO postgres;

--
-- Name: reconstruction_avg_sorts; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.reconstruction_avg_sorts AS
 SELECT reconstruction.model,
    reconstruction.bin,
    reconstruction.etbinidx,
    reconstruction.etabinidx,
    reconstruction.measure,
    reconstruction.class,
    reconstruction.layer,
    reconstruction.normed,
    reconstruction.phase,
    reconstruction.model_name,
    reconstruction.encoding,
    avg(reconstruction.etotal) AS etotal,
    avg(reconstruction.ps) AS ps,
    avg(reconstruction.em1) AS em1,
    avg(reconstruction.em2) AS em2,
    avg(reconstruction.em3) AS em3,
    avg(reconstruction.em) AS em,
    avg(reconstruction.had1) AS had1,
    avg(reconstruction.had2) AS had2,
    avg(reconstruction.had3) AS had3,
    avg(reconstruction.had) AS had,
    avg(reconstruction.rings_metrics_sum) AS rings_metrics_sum,
    avg(reconstruction.rings_metrics_avg) AS rings_metrics_avg,
    avg(reconstruction."1") AS "1",
    avg(reconstruction."2") AS "2",
    avg(reconstruction."3") AS "3",
    avg(reconstruction."4") AS "4",
    avg(reconstruction."5") AS "5",
    avg(reconstruction."6") AS "6",
    avg(reconstruction."7") AS "7",
    avg(reconstruction."8") AS "8",
    avg(reconstruction."9") AS "9",
    avg(reconstruction."10") AS "10",
    avg(reconstruction."11") AS "11",
    avg(reconstruction."12") AS "12",
    avg(reconstruction."13") AS "13",
    avg(reconstruction."14") AS "14",
    avg(reconstruction."15") AS "15",
    avg(reconstruction."16") AS "16",
    avg(reconstruction."17") AS "17",
    avg(reconstruction."18") AS "18",
    avg(reconstruction."19") AS "19",
    avg(reconstruction."20") AS "20",
    avg(reconstruction."21") AS "21",
    avg(reconstruction."22") AS "22",
    avg(reconstruction."23") AS "23",
    avg(reconstruction."24") AS "24",
    avg(reconstruction."25") AS "25",
    avg(reconstruction."26") AS "26",
    avg(reconstruction."27") AS "27",
    avg(reconstruction."28") AS "28",
    avg(reconstruction."29") AS "29",
    avg(reconstruction."30") AS "30",
    avg(reconstruction."31") AS "31",
    avg(reconstruction."32") AS "32",
    avg(reconstruction."33") AS "33",
    avg(reconstruction."34") AS "34",
    avg(reconstruction."35") AS "35",
    avg(reconstruction."36") AS "36",
    avg(reconstruction."37") AS "37",
    avg(reconstruction."38") AS "38",
    avg(reconstruction."39") AS "39",
    avg(reconstruction."40") AS "40",
    avg(reconstruction."41") AS "41",
    avg(reconstruction."42") AS "42",
    avg(reconstruction."43") AS "43",
    avg(reconstruction."44") AS "44",
    avg(reconstruction."45") AS "45",
    avg(reconstruction."46") AS "46",
    avg(reconstruction."47") AS "47",
    avg(reconstruction."48") AS "48",
    avg(reconstruction."49") AS "49",
    avg(reconstruction."50") AS "50",
    avg(reconstruction."51") AS "51",
    avg(reconstruction."52") AS "52",
    avg(reconstruction."53") AS "53",
    avg(reconstruction."54") AS "54",
    avg(reconstruction."55") AS "55",
    avg(reconstruction."56") AS "56",
    avg(reconstruction."57") AS "57",
    avg(reconstruction."58") AS "58",
    avg(reconstruction."59") AS "59",
    avg(reconstruction."60") AS "60",
    avg(reconstruction."61") AS "61",
    avg(reconstruction."62") AS "62",
    avg(reconstruction."63") AS "63",
    avg(reconstruction."64") AS "64",
    avg(reconstruction."65") AS "65",
    avg(reconstruction."66") AS "66",
    avg(reconstruction."67") AS "67",
    avg(reconstruction."68") AS "68",
    avg(reconstruction."69") AS "69",
    avg(reconstruction."70") AS "70",
    avg(reconstruction."71") AS "71",
    avg(reconstruction."72") AS "72",
    avg(reconstruction."73") AS "73",
    avg(reconstruction."74") AS "74",
    avg(reconstruction."75") AS "75",
    avg(reconstruction."76") AS "76",
    avg(reconstruction."77") AS "77",
    avg(reconstruction."78") AS "78",
    avg(reconstruction."79") AS "79",
    avg(reconstruction."80") AS "80",
    avg(reconstruction."81") AS "81",
    avg(reconstruction."82") AS "82",
    avg(reconstruction."83") AS "83",
    avg(reconstruction."84") AS "84",
    avg(reconstruction."85") AS "85",
    avg(reconstruction."86") AS "86",
    avg(reconstruction."87") AS "87",
    avg(reconstruction."88") AS "88",
    avg(reconstruction."89") AS "89",
    avg(reconstruction."90") AS "90",
    avg(reconstruction."91") AS "91",
    avg(reconstruction."92") AS "92",
    avg(reconstruction."93") AS "93",
    avg(reconstruction."94") AS "94",
    avg(reconstruction."95") AS "95",
    avg(reconstruction."96") AS "96",
    avg(reconstruction."97") AS "97",
    avg(reconstruction."98") AS "98",
    avg(reconstruction."99") AS "99",
    avg(reconstruction."100") AS "100"
   FROM public.reconstruction
  GROUP BY reconstruction.model, reconstruction.etbinidx, reconstruction.etabinidx, reconstruction.measure, reconstruction.class, reconstruction.layer, reconstruction.normed, reconstruction.phase, reconstruction.model_name, reconstruction.encoding, reconstruction.bin;


ALTER TABLE public.reconstruction_avg_sorts OWNER TO postgres;

--
-- Name: reconstruction_metrics_id_seq; Type: SEQUENCE; Schema: public; Owner: ringer
--

CREATE SEQUENCE public.reconstruction_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reconstruction_metrics_id_seq OWNER TO ringer;

--
-- Name: reconstruction_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ringer
--

ALTER SEQUENCE public.reconstruction_metrics_id_seq OWNED BY public.reconstruction_metrics.id;


--
-- Name: reconstruction_stddev_sorts; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.reconstruction_stddev_sorts AS
 SELECT reconstruction.model,
    reconstruction.bin,
    reconstruction.etbinidx,
    reconstruction.etabinidx,
    reconstruction.measure,
    reconstruction.class,
    reconstruction.layer,
    reconstruction.normed,
    reconstruction.phase,
    reconstruction.model_name,
    reconstruction.encoding,
    stddev(reconstruction.etotal) AS etotal,
    stddev(reconstruction.ps) AS ps,
    stddev(reconstruction.em1) AS em1,
    stddev(reconstruction.em2) AS em2,
    stddev(reconstruction.em3) AS em3,
    stddev(reconstruction.em) AS em,
    stddev(reconstruction.had1) AS had1,
    stddev(reconstruction.had2) AS had2,
    stddev(reconstruction.had3) AS had3,
    stddev(reconstruction.had) AS had,
    stddev(reconstruction.rings_metrics_sum) AS rings_metrics_sum,
    stddev(reconstruction.rings_metrics_avg) AS rings_metrics_avg,
    stddev(reconstruction."1") AS "1",
    stddev(reconstruction."2") AS "2",
    stddev(reconstruction."3") AS "3",
    stddev(reconstruction."4") AS "4",
    stddev(reconstruction."5") AS "5",
    stddev(reconstruction."6") AS "6",
    stddev(reconstruction."7") AS "7",
    stddev(reconstruction."8") AS "8",
    stddev(reconstruction."9") AS "9",
    stddev(reconstruction."10") AS "10",
    stddev(reconstruction."11") AS "11",
    stddev(reconstruction."12") AS "12",
    stddev(reconstruction."13") AS "13",
    stddev(reconstruction."14") AS "14",
    stddev(reconstruction."15") AS "15",
    stddev(reconstruction."16") AS "16",
    stddev(reconstruction."17") AS "17",
    stddev(reconstruction."18") AS "18",
    stddev(reconstruction."19") AS "19",
    stddev(reconstruction."20") AS "20",
    stddev(reconstruction."21") AS "21",
    stddev(reconstruction."22") AS "22",
    stddev(reconstruction."23") AS "23",
    stddev(reconstruction."24") AS "24",
    stddev(reconstruction."25") AS "25",
    stddev(reconstruction."26") AS "26",
    stddev(reconstruction."27") AS "27",
    stddev(reconstruction."28") AS "28",
    stddev(reconstruction."29") AS "29",
    stddev(reconstruction."30") AS "30",
    stddev(reconstruction."31") AS "31",
    stddev(reconstruction."32") AS "32",
    stddev(reconstruction."33") AS "33",
    stddev(reconstruction."34") AS "34",
    stddev(reconstruction."35") AS "35",
    stddev(reconstruction."36") AS "36",
    stddev(reconstruction."37") AS "37",
    stddev(reconstruction."38") AS "38",
    stddev(reconstruction."39") AS "39",
    stddev(reconstruction."40") AS "40",
    stddev(reconstruction."41") AS "41",
    stddev(reconstruction."42") AS "42",
    stddev(reconstruction."43") AS "43",
    stddev(reconstruction."44") AS "44",
    stddev(reconstruction."45") AS "45",
    stddev(reconstruction."46") AS "46",
    stddev(reconstruction."47") AS "47",
    stddev(reconstruction."48") AS "48",
    stddev(reconstruction."49") AS "49",
    stddev(reconstruction."50") AS "50",
    stddev(reconstruction."51") AS "51",
    stddev(reconstruction."52") AS "52",
    stddev(reconstruction."53") AS "53",
    stddev(reconstruction."54") AS "54",
    stddev(reconstruction."55") AS "55",
    stddev(reconstruction."56") AS "56",
    stddev(reconstruction."57") AS "57",
    stddev(reconstruction."58") AS "58",
    stddev(reconstruction."59") AS "59",
    stddev(reconstruction."60") AS "60",
    stddev(reconstruction."61") AS "61",
    stddev(reconstruction."62") AS "62",
    stddev(reconstruction."63") AS "63",
    stddev(reconstruction."64") AS "64",
    stddev(reconstruction."65") AS "65",
    stddev(reconstruction."66") AS "66",
    stddev(reconstruction."67") AS "67",
    stddev(reconstruction."68") AS "68",
    stddev(reconstruction."69") AS "69",
    stddev(reconstruction."70") AS "70",
    stddev(reconstruction."71") AS "71",
    stddev(reconstruction."72") AS "72",
    stddev(reconstruction."73") AS "73",
    stddev(reconstruction."74") AS "74",
    stddev(reconstruction."75") AS "75",
    stddev(reconstruction."76") AS "76",
    stddev(reconstruction."77") AS "77",
    stddev(reconstruction."78") AS "78",
    stddev(reconstruction."79") AS "79",
    stddev(reconstruction."80") AS "80",
    stddev(reconstruction."81") AS "81",
    stddev(reconstruction."82") AS "82",
    stddev(reconstruction."83") AS "83",
    stddev(reconstruction."84") AS "84",
    stddev(reconstruction."85") AS "85",
    stddev(reconstruction."86") AS "86",
    stddev(reconstruction."87") AS "87",
    stddev(reconstruction."88") AS "88",
    stddev(reconstruction."89") AS "89",
    stddev(reconstruction."90") AS "90",
    stddev(reconstruction."91") AS "91",
    stddev(reconstruction."92") AS "92",
    stddev(reconstruction."93") AS "93",
    stddev(reconstruction."94") AS "94",
    stddev(reconstruction."95") AS "95",
    stddev(reconstruction."96") AS "96",
    stddev(reconstruction."97") AS "97",
    stddev(reconstruction."98") AS "98",
    stddev(reconstruction."99") AS "99",
    stddev(reconstruction."100") AS "100"
   FROM public.reconstruction
  GROUP BY reconstruction.model, reconstruction.etbinidx, reconstruction.etabinidx, reconstruction.measure, reconstruction.class, reconstruction.layer, reconstruction.normed, reconstruction.phase, reconstruction.model_name, reconstruction.encoding, reconstruction.bin;


ALTER TABLE public.reconstruction_stddev_sorts OWNER TO postgres;

--
-- Name: classifiers id; Type: DEFAULT; Schema: public; Owner: ringer
--

ALTER TABLE ONLY public.classifiers ALTER COLUMN id SET DEFAULT nextval('public.classifiers_id_seq'::regclass);


--
-- Name: reconstruction_metrics id; Type: DEFAULT; Schema: public; Owner: ringer
--

ALTER TABLE ONLY public.reconstruction_metrics ALTER COLUMN id SET DEFAULT nextval('public.reconstruction_metrics_id_seq'::regclass);


--
-- Name: classifiers classifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: ringer
--

ALTER TABLE ONLY public.classifiers
    ADD CONSTRAINT classifiers_pkey PRIMARY KEY (id);


--
-- Name: pgbench_accounts pgbench_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pgbench_accounts
    ADD CONSTRAINT pgbench_accounts_pkey PRIMARY KEY (aid);


--
-- Name: pgbench_branches pgbench_branches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pgbench_branches
    ADD CONSTRAINT pgbench_branches_pkey PRIMARY KEY (bid);


--
-- Name: pgbench_tellers pgbench_tellers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pgbench_tellers
    ADD CONSTRAINT pgbench_tellers_pkey PRIMARY KEY (tid);


--
-- Name: reconstruction_metrics reconstruction_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: ringer
--

ALTER TABLE ONLY public.reconstruction_metrics
    ADD CONSTRAINT reconstruction_metrics_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: ringer
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: classifiers_sort_idx; Type: INDEX; Schema: public; Owner: ringer
--

CREATE INDEX classifiers_sort_idx ON public.classifiers USING btree (sort);


--
-- Name: classifiers_time_idx; Type: INDEX; Schema: public; Owner: ringer
--

CREATE INDEX classifiers_time_idx ON public.classifiers USING btree ("time");


--
-- Name: reconstruction_metrics_sort_idx; Type: INDEX; Schema: public; Owner: ringer
--

CREATE INDEX reconstruction_metrics_sort_idx ON public.reconstruction_metrics USING btree (sort);


--
-- Name: reconstruction_metrics_time_idx; Type: INDEX; Schema: public; Owner: ringer
--

CREATE INDEX reconstruction_metrics_time_idx ON public.reconstruction_metrics USING btree ("time");


--
-- Name: TABLE classifiers; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON TABLE public.classifiers TO caducovas;
GRANT ALL ON TABLE public.classifiers TO verdun;
GRANT ALL ON TABLE public.classifiers TO cessy;
GRANT ALL ON TABLE public.classifiers TO techlab;
GRANT ALL ON TABLE public.classifiers TO marselha;


--
-- Name: TABLE reconstruction_metrics; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON TABLE public.reconstruction_metrics TO caducovas;
GRANT ALL ON TABLE public.reconstruction_metrics TO verdun;
GRANT ALL ON TABLE public.reconstruction_metrics TO cessy;
GRANT ALL ON TABLE public.reconstruction_metrics TO techlab;
GRANT ALL ON TABLE public.reconstruction_metrics TO marselha;


--
-- Name: SEQUENCE task_id_seq; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON SEQUENCE public.task_id_seq TO caducovas;
GRANT ALL ON SEQUENCE public.task_id_seq TO verdun;
GRANT ALL ON SEQUENCE public.task_id_seq TO cessy;
GRANT ALL ON SEQUENCE public.task_id_seq TO marselha;
GRANT ALL ON SEQUENCE public.task_id_seq TO techlab;


--
-- Name: TABLE tasks; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON TABLE public.tasks TO caducovas;
GRANT ALL ON TABLE public.tasks TO verdun;
GRANT ALL ON TABLE public.tasks TO cessy;
GRANT ALL ON TABLE public.tasks TO techlab;
GRANT ALL ON TABLE public.tasks TO marselha;


--
-- Name: TABLE check_models_by_bin; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON TABLE public.check_models_by_bin TO caducovas;
GRANT ALL ON TABLE public.check_models_by_bin TO verdun;
GRANT ALL ON TABLE public.check_models_by_bin TO cessy;
GRANT ALL ON TABLE public.check_models_by_bin TO techlab;
GRANT ALL ON TABLE public.check_models_by_bin TO marselha;


--
-- Name: SEQUENCE classifiers_id_seq; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON SEQUENCE public.classifiers_id_seq TO caducovas;
GRANT ALL ON SEQUENCE public.classifiers_id_seq TO verdun;
GRANT ALL ON SEQUENCE public.classifiers_id_seq TO cessy;
GRANT ALL ON SEQUENCE public.classifiers_id_seq TO marselha;
GRANT ALL ON SEQUENCE public.classifiers_id_seq TO techlab;


--
-- Name: TABLE pgbench_accounts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pgbench_accounts TO caducovas;
GRANT ALL ON TABLE public.pgbench_accounts TO verdun;
GRANT ALL ON TABLE public.pgbench_accounts TO cessy;
GRANT ALL ON TABLE public.pgbench_accounts TO techlab;
GRANT ALL ON TABLE public.pgbench_accounts TO marselha;


--
-- Name: TABLE pgbench_branches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pgbench_branches TO caducovas;
GRANT ALL ON TABLE public.pgbench_branches TO verdun;
GRANT ALL ON TABLE public.pgbench_branches TO cessy;
GRANT ALL ON TABLE public.pgbench_branches TO techlab;
GRANT ALL ON TABLE public.pgbench_branches TO marselha;


--
-- Name: TABLE pgbench_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pgbench_history TO caducovas;
GRANT ALL ON TABLE public.pgbench_history TO verdun;
GRANT ALL ON TABLE public.pgbench_history TO cessy;
GRANT ALL ON TABLE public.pgbench_history TO techlab;
GRANT ALL ON TABLE public.pgbench_history TO marselha;


--
-- Name: TABLE pgbench_tellers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pgbench_tellers TO caducovas;
GRANT ALL ON TABLE public.pgbench_tellers TO verdun;
GRANT ALL ON TABLE public.pgbench_tellers TO cessy;
GRANT ALL ON TABLE public.pgbench_tellers TO techlab;
GRANT ALL ON TABLE public.pgbench_tellers TO marselha;


--
-- Name: SEQUENCE reconstruction_metrics_id_seq; Type: ACL; Schema: public; Owner: ringer
--

GRANT ALL ON SEQUENCE public.reconstruction_metrics_id_seq TO caducovas;
GRANT ALL ON SEQUENCE public.reconstruction_metrics_id_seq TO verdun;
GRANT ALL ON SEQUENCE public.reconstruction_metrics_id_seq TO cessy;
GRANT ALL ON SEQUENCE public.reconstruction_metrics_id_seq TO marselha;
GRANT ALL ON SEQUENCE public.reconstruction_metrics_id_seq TO techlab;


--
-- PostgreSQL database dump complete
--

