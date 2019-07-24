bot.sendMessage('@ringer_tuning',create_simple_table(dCurator.ppChain.shortName()+"_"+mname,startTime).get_string())
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
#     bot.sendMessage('@ringer_tuning',create_reconstruction_table(dCurator.ppChain.shortName()+"_"+mname,startTime,normed='no').get_string())
#     bot.sendMessage('@ringer_tuning',create_reconstruction_table(dCurator.ppChain.shortName()+"_"+mname,startTime,normed='yes').get_string())
#     bot.sendMessage('@ringer_tuning',create_reconstruction_table_complete(dCurator.ppChain.shortName()+"_"+mname,startTime,normed='no').get_string())

# if('AE' in str(dCurator.ppChain.shortName()) and ('LSTM' not in str(dCurator.ppChain.shortName()) and 'GRU' not in str(dCurator.ppChain.shortName()))):
#   png_files=plot_AE_training(work_path+'StackedAutoEncoder_preproc/'+tuning_folder_name,work_path+'files/'+tuning_folder_name+'/')
#   for png_file in png_files:
#     png_f = open(png_file,'rb')
#     bot.sendPhoto('@ringer_tuning',png_f)
#
# # if('NLPCA' in str(dCurator.ppChain.shortName())):
# #   png_files=plot_NLPCA_training(work_path+'nlpca_preproc/'+tuning_folder_name,work_path+'files/'+tuning_folder_name+'/')
# #   for png_file in png_files:
# #     png_f = open(png_file,'rb')
# #     bot.sendPhoto('@ringer_tuning',png_f)
#
# if('AE' in str(dCurator.ppChain.shortName()) and ('LSTM' not in str(dCurator.ppChain.shortName()) and 'GRU' not in str(dCurator.ppChain.shortName()))):
#   png_files=plot_reconstruction_error(trnReconError=trnReconError,valReconError=valReconError,model_name=dCurator.ppChain.shortName(),layer=reconstruct.keys()[-1],time=startTime,dirout=work_path+'files/'+tuning_folder_name+'/')
#   for png_file in png_files:
#     png_f = open(png_file,'rb')
#     bot.sendPhoto('@ringer_tuning',png_f)
#
# confMatrix_png_files=send_confusion_matrix(work_path+'files/'+tuning_folder_name,work_path+'files/'+tuning_folder_name,dCurator.ppChain.shortName(),valTarget,valOutput,tstPoint[0])
# for confMatrix_png_file in confMatrix_png_files:
#   confMatrix_png_f = open(confMatrix_png_file,'rb')
#   bot.sendPhoto('@ringer_tuning',confMatrix_png_f)
# #
# #
# roc_png_files=plot_Roc(work_path+'files/'+tuning_folder_name,work_path+'files/'+tuning_folder_name,dCurator.ppChain.shortName())
# for roc_png_file in roc_png_files:
#   roc_png_f = open(roc_png_file,'rb')
#   bot.sendPhoto('@ringer_tuning',roc_png_f)
#
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_input_reconstruction(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
#
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_input_reconstruction_diff_measures(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False,Normed=False, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
#
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_input_reconstruction_diff_measures(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False,Normed=True, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
#
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_input_reconstruction_diff_measures2(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False,Normed=True, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
#
if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
#if('AE' in str(dCurator.ppChain.shortName())):
  for layer in reconstruct.keys():
    png_files=plot_input_reconstruction_diff_measures2(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False,Normed=False, dirout=work_path+'files/'+tuning_folder_name+'/')
    for png_file in png_files:
      png_f = open(png_file,'rb')
      bot.sendPhoto('@ringer_tuning',png_f)
#
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_input_reconstruction_diff_measures3(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False,Normed=True, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
#
if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
#if('AE' in str(dCurator.ppChain.shortName())):
  for layer in reconstruct.keys():
    png_files=plot_input_reconstruction_diff_measures3(model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False,Normed=False, dirout=work_path+'files/'+tuning_folder_name+'/')
    for png_file in png_files:
      png_f = open(png_file,'rb')
      bot.sendPhoto('@ringer_tuning',png_f)
# #
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# # #if('AE' in str(dCurator.ppChain.shortName())):
# #   for layer in reconstruct.keys():
# #     png_files=plot_input_reconstruction_separed(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
# #     for png_file in png_files:
# #       png_f = open(png_file,'rb')
# #       bot.sendPhoto('@ringer_tuning',png_f)
# #
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# # #if('AE' in str(dCurator.ppChain.shortName())):
# #   for layer in reconstruct.keys():
# #     png_files=plot_input_reconstruction_separed_noErrbar(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
# #     for png_file in png_files:
# #       png_f = open(png_file,'rb')
# #       bot.sendPhoto('@ringer_tuning',png_f)
# #
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# # #if('AE' in str(dCurator.ppChain.shortName())):
# #   for layer in reconstruct.keys():
# #     png_files=plot_input_reconstruction_error(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
# #     #png_files=plot_input_reconstruction_delta(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
# #     for png_file in png_files:
# #       png_f = open(png_file,'rb')
# #       bot.sendPhoto('@ringer_tuning',png_f)
# #
# # # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# # # #if('AE' in str(dCurator.ppChain.shortName())):
# #   # for layer in reconstruct.keys():
# #     # png_files=plot_input_reconstruction_delta_separed(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
# #     # for png_file in png_files:
# #       # png_f = open(png_file,'rb')
# #       # bot.sendPhoto('@ringer_tuning',png_f)
# #
##REPLOT
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_measures_2d(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
#
# if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #if('AE' in str(dCurator.ppChain.shortName())):
#   for layer in reconstruct.keys():
#     png_files=plot_representation_2d(norm1Par=norm1Par,code=code,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout=work_path+'files/'+tuning_folder_name+'/')
#     for png_file in png_files:
#       png_f = open(png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',png_f)
##REPLOT
# #
# # # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# # # #if('AE' in str(dCurator.ppChain.shortName())):
# # #   #for layer in reconstruct.keys():
# # #   png_files=plot_pdfs(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),time=startTime,sort=sort,etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,phase='Validation', dirout=work_path+'files/'+tuning_folder_name+'/')
# # #   for png_file in png_files:
# # #     png_f = open(png_file,'rb')
# # #     bot.sendDocument('@ringer_tuning',png_f)
# # #
# # # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# # # #if('AE' in str(dCurator.ppChain.shortName())):
# # #   #for layer in reconstruct.keys():
# # #   png_files=plot_pdfs_byclass(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),time=startTime,sort=sort,etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,phase='Validation', dirout=work_path+'files/'+tuning_folder_name+'/')
# # #   for png_file in png_files:
# # #     png_f = open(png_file,'rb')
# # #     bot.sendDocument('@ringer_tuning',png_f)
# # #
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #  #if('AE' in str(dCurator.ppChain.shortName())):
# #    #for layer in reconstruct.keys():
# #   png_files=plot_pdfs_representation(norm1Par=norm1Par,code=code,layer=layer,model_name=dCurator.ppChain.shortName(),time=startTime,sort=sort,etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,phase='Validation', dirout=work_path+'files/'+tuning_folder_name+'/')
# #   for png_file in png_files:
# #     png_f = open(png_file,'rb')
# #     bot.sendDocument('@ringer_tuning',png_f)
# #
# # # # ##HISTO PLOTS
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #   #if('AE' in str(dCurator.ppChain.shortName())):
# #   #for layer in reconstruct.keys():
# #   png_files=plot_scatter(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),time=startTime,sort=sort,etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,normed=True,phase='Validation', dirout=work_path+'files/'+tuning_folder_name+'/')
# #   for png_file in png_files:
# #     png_f = open(png_file,'rb')
# #     bot.sendDocument('@ringer_tuning',png_f)
# #
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #   #if('AE' in str(dCurator.ppChain.shortName())):
# #   #for layer in reconstruct.keys():
# #   png_files=plot_scatter(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),time=startTime,sort=sort,etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,normed=False,phase='Validation', dirout=work_path+'files/'+tuning_folder_name+'/')
# #   for png_file in png_files:
# #     png_f = open(png_file,'rb')
# #     bot.sendDocument('@ringer_tuning',png_f)
#
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #   #if('AE' in str(dCurator.ppChain.shortName())):
# #   #for layer in reconstruct.keys()
# #   make_ring_hist(norm1Par=norm1Par,reconstruct=reconstruct,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout='/home/caducovas/run/plots/')
# #   try:
# #       bot.sendMessage('@ringer_tuning','Finished Plotting Rings Histogram Input X Reconstruction')
# #       print 'Finished Plotting RIngs Histogram Input X Reconstruction'
# #   except:
# #       print 'Finished Plotting RIngs Histogram Input X Reconstruction'
#
# ###if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
#   #if('AE' in str(dCurator.ppChain.shortName())):
#   #for layer in reconstruct.keys()
#   ###make_representation_hist(norm1Par=norm1Par,code=code,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout='/scratch/22061a/caducovas/run/plots/')
#   #bot.sendMessage('@ringer_tuning','Finished Plotting Rings Histogram Input X Reconstruction')
#   ###print 'Finished Plotting Code Histogram Signal X Background'
#
# # if('PCA' in str(dCurator.ppChain.shortName()) or 'AE' in str(dCurator.ppChain.shortName()) and 'std' not in str(dCurator.ppChain.shortName())):
# #   #if('AE' in str(dCurator.ppChain.shortName())):
# #   #for layer in reconstruct.keys()
# #   make_ReconstructionErro_hist(norm1Par=norm1Par,reconstructErrVector=valReconError,model_name=dCurator.ppChain.shortName(),layer=layer,time=startTime, etBinIdx=etBinIdx,etaBinIdx=etaBinIdx,log_scale=False, dirout='/scratch/22061a/caducovas/run/plots/')
# #   #bot.sendMessage('@ringer_tuning','Finished Plotting Rings Histogram Input X Reconstruction')
# #   print 'Finished Plotting Code Reconstruction Error Signal X Background'
# ##UNCOMMENT AFTER FIRST ROUND
#
# # #dl_png_files=plot_classifier_training(work_path+'files/'+tuning_folder_name+'/models/',work_path+'files/'+tuning_folder_name+'/models/')
#

# #time.sleep(20)
# if coreConf() == 2:
#   #keras
#   feature_relevance_png_files=feature_relevance_mse(work_path+'files/'+tuning_folder_name,work_path+'files/'+tuning_folder_name,tb_name,val_all,dCurator.ppChain.shortName(),valTarget,valOutput,tstPoint[0])
#   for feature_relevance_png_file in feature_relevance_png_files:
#       feature_relevance_png_f = open(feature_relevance_png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',feature_relevance_png_f)
#
#   feature_relevance_png_files=feature_relevance_sp(work_path+'files/'+tuning_folder_name,work_path+'files/'+tuning_folder_name,tb_name,val_all,dCurator.ppChain.shortName(),valTarget,valOutput,tstPoint[0])
#   for feature_relevance_png_file in feature_relevance_png_files:
#       feature_relevance_png_f = open(feature_relevance_png_file,'rb')
#       bot.sendPhoto('@ringer_tuning',feature_relevance_png_f)


# #@!for refN in refName:
  # #@!bot.sendMessage('@ringer_tuning',createClassifierTable(dCurator.ppChain.shortName()+"_"+mname,startTime,refN).get_string())
# #@@print 'TENTATIVA DE ENVIAR OS PLOTS'
# #@@dl_png_files= plot_classifier_training('/scratch/22061a/caducovas/run/files/N1_20180613130104/models/','/scratch/22061a/caducovas/run/files/N1_20180613130104/models/')
# #@@print dl_png_files
# #@@for dl_png_file in dl_png_files:
  # #@@dl_png_f = open(dl_png_file,'rb')
  # #@@bot.sendPhoto('@ringer_tuning',dl_png_f)

#time.sleep(20)
#bot.sendMessage('@ringer_tuning','Finished tuning job!')
# #Finished all configurations we had to do

###############################################################################################
# Finished all configurations we had to do
