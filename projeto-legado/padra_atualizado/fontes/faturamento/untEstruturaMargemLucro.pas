unit untEstruturaMargemLucro;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet, untFuncoesSimples,
{$ENDIF}
  Data.DB;

Type
  TEstruturaClienteDataSetMargemLucro = Class
  Private

  Public
    class function fCriaEstruturaDadosMargemLucro: TUniClientDataSet;
  End;

implementation


{ TEstruturaClienteDataSetMargemLucro }

class function TEstruturaClienteDataSetMargemLucro.fCriaEstruturaDadosMargemLucro: TUniClientDataSet;
begin

  Result := TUniClientDataSet.Create(nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_SEQUEN';
    DataType := ftString;
    Size     := 5;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_EMPITE';
    DataType := ftString;
    Size     := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_EMPPRD';
    DataType := ftString;
    Size     := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODITE';
    DataType := ftString;
    Size     := fTamCodIte;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODFOR';
    DataType := ftString;
    Size     := 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODABF';
    DataType := ftString;
    Size     := 7;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_BAREMB';
    DataType := ftString;
    Size     := 13;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESITE';
    DataType := ftString;
    Size     := 80;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_SIGUNI';
    DataType := ftString;
    Size     := 004;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMAR';
    DataType := ftString;
    Size     := 025;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESSIM';
    DataType := ftString;
    Size     := 80;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_QTDITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UNIORI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UNITAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRECUS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARLUC';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARKUP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARMIN';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREMED';
    DataType := ftFloat;
  End;

  // PREÇO MÉDIO LIQUIDO
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREMED_LIQ';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARMED';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IMPULT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CUSIMP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARIMP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRANUM_MAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRANUM_MAR_SDO'; //Sem despesas operacionais
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IDENUM_MAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MEDNUM_MAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IMPNUM_MAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRONUM_MAR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRANUM_MKP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRANUM_MKP_SDO'; //Sem despesas operacionais
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MEDNUM_MKP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IMPNUM_MKP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRONUM_MKP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREULT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IMPFED';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_COMTBL';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_OUTVAL';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESOPE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ICMSAI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ICMCAL';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMGE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMSU';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMAX';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESCON';
    DataType := ftFloat;
  End;

  // PERCENTUAL DE DESCONTO ENTRE OS VALORES "ITE_UNIORI" E "ITE_UNITAR".'
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_PERDES';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_QTDEMB';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREEMB';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRCTIN';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRVTIN';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_TOTITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UNIDEV';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_EMBALA';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREINI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_TABPRE';
    DataType := ftString;
    Size     := 01;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ENTSAI';
    DataType := ftString;
    Size     := 01;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_BRINDE';
    DataType := ftString;
    Size     := 01;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IDEPRO';
    DataType := ftString;
    Size     := 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_TIPPRE';
    DataType := ftString;
    Size     := 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PROMOC';
    DataType := ftString;
    Size     := 01;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PROVEN';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CATALI';
    DataType := ftString;
    Size     := 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ITETIN';
    DataType := ftString;
    Size     := 40;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODUNI';
    DataType := ftString;
    Size     := 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'AUTOINCREM';
    DataType := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRELOT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IMPDIR';
    DataType := ftString;
    Size     := 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CUSITE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_PROACA';
    DataType := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_TAXJUR';
    DataType := ftFloat;
  End;

  // RESULT := PRECO_VENDA - PRECO_CUSTO
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_RESULT';
    DataType := ftFloat;
  End;

  // MARGEM IDEAL
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARIDE';
    DataType := ftFloat;
  End;

  // PREÇO IDEAL
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREIDE';
    DataType := ftFloat;
  End;

  // UNITÁRIO MARGEM CAT17 - VALOR AUXILIAR UTILIZADO NA TOTALIZAÇÃO DA MARGEM CAT17
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_C17NUM_MAR';
    DataType := ftFloat;
  End;

  // (CUSTO - CAT17)
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CUSCAT';
    DataType := ftFloat;
  End;

  // MARGEM CAT17
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARCAT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CUMAZR';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_LIBEST';
    DataType := ftString;
    Size     := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_SEQCOM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ATIVAC';
    DataType := ftString;
    Size     := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UNISBI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UNIDOL';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VLCTVN';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DTCTVN';
    DataType := ftDateTime;
  End;

  // PREÇO DA ÚLTIMA COMPRA - LIQUIDO
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREULT_LIQ';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ICMPAV';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CALCST';
    DataType := ftBoolean;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin // Observação do Colorista na seleção das embalagens automotiva
    Name     := 'ITE_OBSCOL';
    DataType := ftString;
    Size     := 100;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin // Tipo da Fórmula (Fórmula Original ou ajustada)
    Name     := 'ITE_TIPFOR';
    DataType := ftInteger ;
  End;

  // MARGEM PRATICADA "BRUTA" [PREÇO DA ÚLTIMA COMPRA]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARBRU_PREULT';
    DataType := ftFloat;
  End;

  // MARGEM PRATICADA "LIQUIDA" [PREÇO DA ÚLTIMA COMPRA]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARLIQ_PREULT';
    DataType := ftFloat;
  End;

  // MARGEM PROPOSTA [CUSTO]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARPRO_CUSITE';
    DataType := ftFloat;
  End;

  // MARGEM PRATICADA [CUSTO]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARPRA_CUSITE';
    DataType := ftFloat;
  End;

  // SALDO DISPONÍVEL DO PRODUTO
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_SALDOS';
    DataType := ftFloat;
  End;

  // NUMERO DO LOTE
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_NUMLOT';
    DataType := ftString;
    Size     := 20;
  End;

  // TIPO - UTILIZADO PARA TINTA DE MÁQUINA
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_TIPTMQ';
    DataType := ftString;
    Size     := 100;
  End;

  // MARGEM PRATICADA [PREÇO DE CUSTO REAL]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARPRA_PRECUS';
    DataType := ftFloat;
  End;

  // MARGEM PRATICADA BRUTA [PREÇO DE CUSTO REAL] //PARA MARKUP 5
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MRPRBT_PRECUS';
    DataType := ftFloat;
  End;

  // MARGEM PROPOSTA [PREÇO DE CUSTO REAL]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARPRO_PRECUS';
    DataType := ftFloat;
  End;

  // PREÇO MÉDIO BRUTA [PREÇO DE CUSTO REAL] //PARA MARKUP 5
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MRPRBT_PREMED';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARBRU_PREMED';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARLIQ_PREMED';
    DataType := ftFloat;
  End;

  // MARGEM PRATICADA "BRUTA" [PREÇO DE ÚLTIMA COMPRA + IMPOSTOS]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARBRU_IMPULT';
    DataType := ftFloat;
  End;

  // MARGEM PRATICADA "LIQUIDA" [PREÇO DE ÚLTIMA COMPRA + IMPOSTOS]
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARLIQ_IMPULT';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODSIT';
    DataType := ftString;
    Size     := 4;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VAL_ST';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VDIFAL';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VALFCP';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VALIPI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IPISAI';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRECU2';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_BASICM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQICM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VALICM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_TOTCU2';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_BASRET';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VALRET';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ABF_CODFIS';
    DataType := ftString;
    Size     := 3;
  End;

  //USADO PARA AGRUPAR A TINTA E SEUS COLORANTES
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESTIN';
    DataType := ftString;
    Size     := 80;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ICMSAI_PREIDE';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CUSPRA';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MEDPRA';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_IMPULTPRA';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CALMAR_PREDIN_MAR';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CALMAR_PREDIN_MARLIQ';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIFICM_MKPMAR4';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIFICM_MARMED';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIFICM_MARIMP';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIFICM_MARITE';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIFICM_MARLUC';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CALCST_MARGEM';
    DataType := ftBoolean;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ICMPAV_MARGEM';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESOPE_CLI';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CLAFIS';
    DataType := ftString;
    Size     := 6;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PED_ORC_ENT_FUT';
    DataType := ftBoolean;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_RICMPR';
    DataType := ftString;
    Size     := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PERRIC';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODFIS_MARGEM';
    DataType := ftString;
    Size     := 5;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CALMAR_PREDIN_MAR_MARGEM';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CALMAR_PREDIN_MARLIQ_MARGEM';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VDIFAL_MARGEM';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODABF_MARGEM';
    DataType := ftString;
    Size     := 7;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM';
    DataType := ftBoolean;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_VALFCP_MARGEM';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIF_ICMS_MARGEM';
    DataType := ftFloat;
  End;

  //Campo calculado utilizado no calculo da margem
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ALQDIF_ICMS_MARGEM_IMPOSTOS';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MKPPRO';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_INDPRO';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ENCPRO';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MARPRO';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PRETAB';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_PREORI';
    DataType := ftFloat;
  End;


  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_NUMORC';
    DataType := ftString;
    Size     := 012;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ESPORC';
    DataType := ftString;
    Size     := 002;
  End;
  
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_EMPORC';
    DataType := ftString;
    Size     := 003;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_SEQDET';
    DataType := ftString;
    Size     := 020;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMVM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMSM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_DESMGM';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_UNIDIG';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ORDITE';
    DataType := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SELECIONADO';
    DataType := ftString;
    Size     := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_CODFAB';
    DataType := ftString;
    Size     := 035;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ENTRET';
    DataType := ftString;
    Size     := 001;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_MOTFUT';
    DataType := ftString;
    Size     := 001;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_ENTFUT';
    DataType := ftString;
    Size     := 001;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_LOCRET';
    DataType := ftString;
    Size     := 001;
  End;

  { Campos utilizados para exibir as travas mínimas na tela de margem de lucro }
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TRM_DESMAX';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TRM_VLRMIN';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TRM_TOTMIN';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_EHEMBA';
    DataType := ftBoolean;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_PEREMB';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_VLPEMB';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'GIR_DIAEST';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CUSREA';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_UNIFRE';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ITE_COMISS';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_OUTVAL_VALORI';
    DataType := ftFloat;
    Required := False;
  End;

  Result.CreateDataSet;
  Result.LogChanges := False;
end;

end.
