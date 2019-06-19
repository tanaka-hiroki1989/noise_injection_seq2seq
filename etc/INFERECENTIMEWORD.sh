#!/bin/zsh
#oge=("Noisy" "phoneme" "Input")
hoge=("Input")
datas=("YOTA" "WANGDATA")
#hoge=("phoneme")

cd Dataset
for var in ${hoge[@]}
do

for data in ${datas[@]}
do

  echo "わぁ"$var >> log.txt 
  echo `./datasetMake.sh $var`
  echo 
  cd ..
  rm ~/Desktop/syuuron/nmt/Noattention_${var}_model/hparams

  python -m nmt.nmt --src=in --tgt=out --vocab_prefix=/home/emlab/Desktop/syuuron/nmt/Dataset/Vocab --train_prefix=/home/emlab/Desktop/syuuron/nmt/Dataset/traindata --dev_prefix=/home/emlab/Desktop/syuuron/nmt/Dataset/devdata --test_prefix=/home/emlab/Desktop/syuuron/recodescript/${data}/google_Wordresultdata --out_dir=/home/emlab/Desktop/syuuron/nmt/Noattention_${var}_model --num_train_steps=12000 --steps_per_stats=100 --num_layers=1 --num_units=128 --dropout=0.2 --metrics=bleu --attention_architecture=standard 


  cp ~/Desktop/syuuron/nmt/Noattention_${var}_model/output_test ~/Desktop/syuuron/nmt/DataResult/Noattention_${var}_model_${data}_google_infer

  rm ~/Desktop/syuuron/nmt/attention_${var}_model/hparams
  python -m nmt.nmt --src=in --tgt=out --vocab_prefix=/home/emlab/Desktop/syuuron/nmt/Dataset/Vocab --train_prefix=/home/emlab/Desktop/syuuron/nmt/Dataset/traindata --dev_prefix=/home/emlab/Desktop/syuuron/nmt/Dataset/devdata --test_prefix=/home/emlab/Desktop/syuuron/recodescript/${data}/sphinx_wordresultdata --out_dir=/home/emlab/Desktop/syuuron/nmt/attention_${var}_model --num_train_steps=12000 --steps_per_stats=100 --num_layers=1 --num_units=128 --dropout=0.2 --metrics=bleu --attention_architecture=standard --attention=luong 
  cp ~/Desktop/syuuron/nmt/Noattention_${var}_model/output_test ~/Desktop/syuuron/nmt/DataResult/Noattention_${var}_model_${data}_sphinx_infer

  echo attention_${var}_model >> log.txt
  cd Dataset
done
done

#cd /home/emlab/Desktop/syuuron/phonemeWordSeq2Seq

#python -m nmt.nmt --src=in --tgt=out --vocab_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/Vocab --train_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/traindata --dev_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/devdata --test_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/testdata --out_dir=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Wordphoneme_model --num_train_steps=12000 --steps_per_stats=100 --num_layers=1 --num_units=128 --dropout=0.2 --metrics=bleu --phenome_vocab_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/VocabNoisylabel --phenome_train_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Noisytraindata --phenome_dev_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/Noisydevdata --phenome_test_prefix=/home/emlab/Desktop/syuuron/phonemeWordSeq2Seq/Dataset/Noisytestdata --num_gpus=1 --attention_architecture=MultiInput
