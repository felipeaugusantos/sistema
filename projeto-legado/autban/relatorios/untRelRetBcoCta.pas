unit untRelRetBcoCta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, Data.DB, MemDS, DBAccess;

type
  TfrmRelRetBcoCta = class(TfrmPaiRelatorio)
    pnlTopo: TPanel;
    gpbOrdem: TGroupBox;
    ColorLabel2: TColorLabel;
    edtOrdem: TEditFocus;
    GroupBox1: TGroupBox;
    ColorLabel3: TColorLabel;
    edtDados: TEditFocus;
    frxRetBcoCta: TfrxReport;
    frxDBRetBcoCta: TfrxDBDataset;
    qryRetBcoCta: TUniQuery;
    frxDBRetBcoCtaOcorr: TfrxDBDataset;
    qryRetBcoCtaOcorr: TUniQuery;
    qryRetBcoCtaOcorrCODOCO: TStringField;
    qryRetBcoCtaOcorrMOTOCO: TStringField;
    qryRetBcoCtaOcorrQTDDUP: TLargeintField;
    qryRetBcoCtaOcorrVALDUP: TFloatField;
    qryRetBcoCtaCODOCO: TStringField;
    qryRetBcoCtaNOSNUM: TStringField;
    qryRetBcoCtaNUMDUP: TStringField;
    qryRetBcoCtaCODEMP: TStringField;
    qryRetBcoCtaDTAVEN: TDateField;
    qryRetBcoCtaDTAPAG: TDateField;
    qryRetBcoCtaVALPAG: TFloatField;
    qryRetBcoCtaJURMOR: TFloatField;
    qryRetBcoCtaDESCON: TFloatField;
    qryRetBcoCtaOUTENT: TFloatField;
    qryRetBcoCtaVALDUP: TFloatField;
    qryRetBcoCtaVALTOT: TFloatField;
    qryRetBcoCtaCODFOR: TStringField;
    qryRetBcoCtaNOMARQ: TStringField;
    qryRetBcoCtaCEPFOR: TStringField;
    procedure btnImprimirClick(Sender: TObject);

    procedure pGeraRelatorio(strCodBco: String);

    function fRetDescOco(strCodoco: String): String;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function frxRetBcoCtaUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure edtDadosChange(Sender: TObject);
  private
    { Private declarations }
    FBancoAPI: Boolean;

    strCodBco: String;
  public
    { Public declarations }
    strNomBanco: String;
    blnPGG : Boolean;

    property BancoAPI: Boolean read FBancoAPI write FBancoAPI;
  end;

var
  frmRelRetBcoCta: TfrmRelRetBcoCta;

implementation

uses  untfuncoesSimples, untPai,  untModuloSPR, untTPagForBancoDoBrasilAPI;

{$R *.dfm}

procedure TfrmRelRetBcoCta.btnImprimirClick(Sender: TObject);
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  strCodBco := LeftStr(strNomBanco,3);

  pGeraRelatorio(strCodBco);
end;

function TfrmRelRetBcoCta.fRetDescOco(strCodoco: String): String;
  Var
    LContadorOcorrencias: Integer;

    LOcorrencia: String;
begin

  {***********************************}
  {* BANCO ITAU                      *}
  {********************************AC*}
  If strCodBco = '341' Then
  Begin
    Result := '';

    LContadorOcorrencias := 1;

    While LContadorOcorrencias < strCodoco.Length Do
    Begin
      LOcorrencia := Copy(strCodoco, LContadorOcorrencias, 2);

      If LOcorrencia = '00' Then Result := Result + 'PAGAMENTO EFETUADO '
      Else If LOcorrencia = 'AE' Then Result := Result + 'DATA DE PAGAMENTO ALTERADA '
      Else If LOcorrencia = 'AG' Then Result := Result + 'NÚMERO DO LOTE INVÁLIDO '
      Else If LOcorrencia = 'AH' Then Result := Result + 'NÚMERO SEQUENCIAL DO REGISTRO NO LOTE INVÁLIDO '
      Else If LOcorrencia = 'AI' Then Result := Result + 'PRODUTO DEMOSNTRATIVO DE PAGAMENTO NÃO CONTRATADO '
      Else If LOcorrencia = 'AJ' Then Result := Result + 'TIPO DE MOVIMENTO INVÁLIDO '
      Else If LOcorrencia = 'AL' Then Result := Result + 'CÓDIGO DO BANCO FAVORECIDO INVÁLIDO '
      Else If LOcorrencia = 'AM' Then Result := Result + 'AGÊNCIA DO FAVORECIDO INVÁLIDA '
      Else If LOcorrencia = 'AN' Then Result := Result + 'CONTA CORRENTE DO FAVORECIDO INVÁLIDA '
      Else If LOcorrencia = 'AO' Then Result := Result + 'NOME DO FAVORECIDO INVÁLIDO '
      Else If LOcorrencia = 'AP' Then Result := Result + 'DATA/HORA DE LANÇAMENTO/PAGAMENTO/ARRECADAÇÃO/APURAÇÃO INVÁLIDA '
      Else If LOcorrencia = 'AQ' Then Result := Result + 'QUANTIDADE DE REGISTROS MAIOR QUE 999999 '
      Else If LOcorrencia = 'AR' Then Result := Result + 'VALOR ARRECADADO INVÁLIDO '
      Else If LOcorrencia = 'BC' Then Result := Result + 'NOSSO NÚMERO INVÁLIDO '
      Else If LOcorrencia = 'BD' Then Result := Result + 'PAGAMENTO AGENDADO '
      Else If LOcorrencia = 'BE' Then Result := Result + 'PAGAMENTO AGENDADO COM FORMA ALTERADA PARA OP '
      Else If LOcorrencia = 'BI' Then Result := Result + 'CNPJ/CPF DO FAVORECIDO NO SEGMENTO B INVÁLIDO '
      Else If LOcorrencia = 'CD' Then Result := Result + 'CNPJ / CPF INFORMADO DIVERGENTE DO CADASTRO '
      Else If LOcorrencia = 'CE' Then Result := Result + 'PAGAMENTO CANCELADO '
      Else If LOcorrencia = 'CF' Then Result := Result + 'VALOR DO DOCUMENTO INVÁLIDO '
      Else If LOcorrencia = 'CG' Then Result := Result + 'VALOR DO ABATIMENTO INVÁLIDO '
      Else If LOcorrencia = 'CH' Then Result := Result + 'VALOR DO DESCONTO INVÁLIDO '
      Else If LOcorrencia = 'CI' Then Result := Result + 'CNPJ / CPF / IDENTIFICADOR / INSCRIÇÃO ESTADUAL INVÁLIDA '
      Else If LOcorrencia = 'CJ' Then Result := Result + 'VALOR DA MULTA INVÁLIDO '
      Else If LOcorrencia = 'CK' Then Result := Result + 'TIPO DE INSCRIÇÃO INVÁLIDA '
      Else If LOcorrencia = 'CL' Then Result := Result + 'VALOR DO INSS INVÁLIDO '
      Else If LOcorrencia = 'CM' Then Result := Result + 'VALOD DO COFINS INVÁLIDO '
      Else If LOcorrencia = 'CN' Then Result := Result + 'CONTA NÃO CADASTRADA '
      Else If LOcorrencia = 'CO' Then Result := Result + 'VALOR DE OUTRAS ENTIDADES INVÁLIDO '
      Else If LOcorrencia = 'CP' Then Result := Result + 'CONFIRMAÇÃO DE OP CUMPRIDA '
      Else If LOcorrencia = 'CQ' Then Result := Result + 'SOMA DAS FATURAS DIFERE DO PAGAMENTO '
      Else If LOcorrencia = 'CR' Then Result := Result + 'VALOR DO CSLL INVÁLIDO '
      Else If LOcorrencia = 'CS' Then Result := Result + 'DATA DE VENCIMENTO DA FATURA INVÁLIDA '
      Else If LOcorrencia = 'DA' Then Result := Result + 'NÚMERO DE DEPEND. SALÁRIO FAMILIA INVÁLIDO '
      Else If LOcorrencia = 'DB' Then Result := Result + 'NÚMERO DE HORAS SEMANAIS INVÁLIDO '
      Else If LOcorrencia = 'DC' Then Result := Result + 'SALÁRIO DE CONTRIBUIÇÃO INSS INVÁLIDO '
      Else If LOcorrencia = 'DD' Then Result := Result + 'SALÁRIO DE CONTRIBUIÇÃO FGTS INVÁLIDO '
      Else If LOcorrencia = 'DE' Then Result := Result + 'VALOR TOTAL DOS PROVENTOS INVÁLIDO '
      Else If LOcorrencia = 'DF' Then Result := Result + 'VALOR TOTAL DOS DESCONTOS INVÁLIDO '
      Else If LOcorrencia = 'DG' Then Result := Result + 'VALOR LIQUÍDO NÃO NÚMERICO '
      Else If LOcorrencia = 'DH' Then Result := Result + 'VALOR LIQ. INFORMADO DIFERE DO CALCULADO '
      Else If LOcorrencia = 'DI' Then Result := Result + 'VALOR DO SALÁRIO-BASE INVÁLIDO '
      Else If LOcorrencia = 'DJ' Then Result := Result + 'BASE DE CÁLCULO IRRF INVÁLIDO '
      Else If LOcorrencia = 'DK' Then Result := Result + 'BASE DE CÁLCULO FGTS INVÁLIDA '
      Else If LOcorrencia = 'DL' Then Result := Result + 'FORMA DE PAGAMENTO INCOMPÁTIVEL COM HOLERITE '
      Else If LOcorrencia = 'DM' Then Result := Result + 'E-MAIL DO FAVORECIDO INVÁLIDO '
      Else If LOcorrencia = 'DV' Then Result := Result + 'DOC/TED DEVOLVIDO PELO BANCO FAVORECIDO '
      Else If LOcorrencia = 'D0' Then Result := Result + 'FINALIDADE DO HOLERITE INVÁLIDA '
      Else If LOcorrencia = 'D1' Then Result := Result + 'MÊS DE COMPETENCIA DO HOLERITE INVÁLIDA '
      Else If LOcorrencia = 'D2' Then Result := Result + 'DIA DA COMPETENCIA DO HOLERITE INVÁLIDA '
      Else If LOcorrencia = 'D3' Then Result := Result + 'PLANO DE CONTAS INVÁLIDO '
      Else If LOcorrencia = 'D4' Then Result := Result + 'CAMPO NÚMERO DA FUNCIONAL INVÁLIDO '
      Else If LOcorrencia = 'D5' Then Result := Result + 'DATA ÍNICIO DE FÉRIAS NÃO NUMÉRICA '
      Else If LOcorrencia = 'D6' Then Result := Result + 'DATA ÍNICIO DE FÉRIAS INCONSISTENTE '
      Else If LOcorrencia = 'D7' Then Result := Result + 'DATA FIM DE FÉRIAS NÃO NUMÉRICO '
      Else If LOcorrencia = 'D8' Then Result := Result + 'DATA FIM DE FÉRIAS INCONSISTENTE '
      Else If LOcorrencia = 'D9' Then Result := Result + 'NÚMERO DE DEPENDENTES IR INVÁLIDO '
      Else If LOcorrencia = 'EM' Then Result := Result + 'CONFIRMAÇÃO DE OP EMITIDA '
      Else If LOcorrencia = 'EX' Then Result := Result + 'DEVOLUÇÃO DE OP NÃO SACADA PELO FAVORECIDO '
      Else If LOcorrencia = 'E0' Then Result := Result + 'TIPO DE MOVIMENTO HOLERITE INVÁLIDO '
      Else If LOcorrencia = 'E1' Then Result := Result + 'VALOR 01 DO HOLERITE/INFORME INVÁLIDO '
      Else If LOcorrencia = 'E2' Then Result := Result + 'VALOR 02 DO HOLERITE/INFORME INVÁLIDO '
      Else If LOcorrencia = 'E3' Then Result := Result + 'VALOR 03 DO HOLERITE/INFORME INVÁLIDO '
      Else If LOcorrencia = 'E4' Then Result := Result + 'VALOR 04 DO HOLERITE/INFORME INVÁLIDO '
      Else If LOcorrencia = 'IB' Then Result := Result + 'VALOR DO DOCUMENTO INVÁLIDO '
      Else If LOcorrencia = 'IC' Then Result := Result + 'VALOR DO ABATIMENTO INVÁLIDO '
      Else If LOcorrencia = 'ID' Then Result := Result + 'VALOR DO DESCONTO INVÁLIDO '
      Else If LOcorrencia = 'IE' Then Result := Result + 'VALOR DA MORA INVÁLIDO '
      Else If LOcorrencia = 'IF' Then Result := Result + 'VALOR DA MULTA INVÁLIDO '
      Else If LOcorrencia = 'IG' Then Result := Result + 'VALOR DA DEDUÇÃO INVÁLIDO '
      Else If LOcorrencia = 'IH' Then Result := Result + 'VALOR DO ACRÉSCIMO INVÁLIDO '
      Else If LOcorrencia = 'II' Then Result := Result + 'DATA DE VENCIMENTO INVÁLIDA '
      Else If LOcorrencia = 'IJ' Then Result := Result + 'COMPETÊNCIA / PERÍODO REFERÊNCIA / PARCELA INVÁLIDA '
      Else If LOcorrencia = 'IK' Then Result := Result + 'TRIBUTO NÃO LIQUIDÁVEL VIA SISPAG OU NÃO CONVENIADO COM ITAÚ '
      Else If LOcorrencia = 'IL' Then Result := Result + 'CÓDIGO DE PAGAMENTO / RECEITA INVÁLIDO '
      Else If LOcorrencia = 'IM' Then Result := Result + 'TIPO X FORMA NÃO COMPATÍVEL '
      Else If LOcorrencia = 'IN' Then Result := Result + 'BANCO/AGENCIA NÃO CADASTRADOS '
      Else If LOcorrencia = 'IP' Then Result := Result + 'DÍGITO VERIFICADOR DO CÓDIGO DE BARRAS INVÁLIDO '
      Else If LOcorrencia = 'IQ' Then Result := Result + 'DÍVIDA ATIVA OU NÚMERO DE ETIQUETA INVÁLIDO '
      Else If LOcorrencia = 'IR' Then Result := Result + 'PAGAMENTO ALTERADO '
      Else If LOcorrencia = 'IS' Then Result := Result + 'CONCESSIONÁRIA NÃO CONVENIADA COM O ITAÚ '
      Else If LOcorrencia = 'IT' Then Result := Result + 'VALOR DO TRIBUTO INVÁLIDO '
      Else If LOcorrencia = 'IU' Then Result := Result + 'VALOR DA RECEITA BRUTA ACUMULADA INVÁLIDO '
      Else If LOcorrencia = 'IV' Then Result := Result + 'NÚMERO DO DOCUMENTO ORIGEM/REFERÊNCIA INVÁLIDO '
      Else If LOcorrencia = 'LA' Then Result := Result + 'DATA DE PAGAMENTO DE UM LOTE ALTERADA '
      Else If LOcorrencia = 'LC' Then Result := Result + 'LOTE DE PAGAMENTOS CANCELADO '
      Else If LOcorrencia = 'NA' Then Result := Result + 'PAGAMENTO CANCELADO POR FALTA DE AUTORIZAÇÃO '
      Else If LOcorrencia = 'NR' Then Result := Result + 'OPERAÇÃO NÃO REALIZADA '
      Else If LOcorrencia = 'RJ' Then Result := Result + 'REGISTRO REJEITADO '
      Else If LOcorrencia = 'SS' Then Result := Result + 'PAGAMENTO CANCELADO POR INSUFICIÊNCIA DE SALDO/LIMITE DIÁRIO DE PAGTO '
      Else If LOcorrencia = 'TA' Then Result := Result + 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DIFERENÇA '
      Else If LOcorrencia = 'TI' Then Result := Result + 'TITULARIDADE INVÁLIDA '
      Else Result := Result +  'OUTRAS ';

      Result := Result + '- ';

      Inc(LContadorOcorrencias, 2);
    End;

    Result := LeftStr(Result, Result.Length - 2);

  End
  Else
  If strCodBco = '033' Then
  Begin
    If strCodoco = '00' Then Result := 'PAGAMENTO EFETUADO '
    Else If strCodoco = '01' Then Result := 'INSUFICIÊNCIA DE FUNDOS - DÉBITO NÃO EFETUADO'
    Else If strCodoco = '02' Then Result := 'CRÉDITO OU DÉBITO CANCELADO PELO PAGADOR/CREDOR'
    Else If strCodoco = '03' Then Result := 'DÉBITO AUTORIZADO PELA AGÊNCIA - EFETUADOS'
    Else If strCodoco = 'AA' Then Result := 'CONTROLE INVÁLIDO'
    Else If strCodoco = 'AB' Then Result := 'TIPO DE OPERAÇÃO INVÁLIDO'
    Else If strCodoco = 'AC' Then Result := 'TIPO DE SERVIÇO INVÁLIDO'
    Else If strCodoco = 'AD' Then Result := 'FORMA DE LANÇAMENTO INVÁLIDA'
    Else If strCodoco = 'AE' Then Result := 'TIPO/NÚMERO DE INSCRIÇÃO INVÁLIDO (GERADO NA CRÍTICA OU PARA INFORMAR REJEIÇÃO)'
    Else If strCodoco = 'AF' Then Result := 'CÓDIGO DE CONVÊNIO INVÁLIDO'
    Else If strCodoco = 'AG' Then Result := 'AGÊNCIA/CONTA CORRENTE/DV INVÁLIDO'
    Else If strCodoco = 'AH' Then Result := 'NÚMERO SEQUENCIAL DO REGISTRO NO LOTE INVÁLIDO'
    Else If strCodoco = 'AI' Then Result := 'CÓDIGO DE SEGUIMENTO DETALHE INVÁLIDO'
    Else If strCodoco = 'AJ' Then Result := 'TIPO DE MOVIMENTO INVÁLIDO'
    Else If strCodoco = 'AK' Then Result := 'CÓDIGO NA CÂMARA DE COMPENSAÇÃO DO BANCO FAVORECIDO/DEPOSITÁRIO INVÁLIDO'
    Else If strCodoco = 'AL' Then Result := 'CÓDIGO DO BANCO FAVORECIDO OU DEPOSITÁRIO INVÁLIDO'
    Else If strCodoco = 'AM' Then Result := 'AGÊNCIA MANTENEDORA OU CONTA CORRENTE DO FAVORECIDO INVÁLIDA'
    Else If strCodoco = 'AN' Then Result := 'CONTA CORRENTE/DV DO FAVORECIDO INVÁLDO'
    Else If strCodoco = 'AO' Then Result := 'NOME DO FAVORECIDO NÃO INFORMADO'
    Else If strCodoco = 'AP' Then Result := 'DATA LANÇAMENTO INVÁLIDA/ VENCIMENTO INVÁLIDA'
    Else If strCodoco = 'AQ' Then Result := 'TIPO/QUANTIDADE DE MOEDA INVÁLIDO'
    Else If strCodoco = 'AR' Then Result := 'VALOR DO LANÇAMENTO INVÁLIDO'
    Else If strCodoco = 'AS' Then Result := 'AVISO AO FAVORECIDO - IDENTIFICAÇÃO INVÁLIDA'
    Else If strCodoco = 'AT' Then Result := 'TIPO/NÚMERO DE INSCRIÇÃO DO FAVORECIDO/CONTRIBUINTE INVÁLIDO'
    Else If strCodoco = 'AU' Then Result := 'LOGRADOURO DO FAVORECIDO NÃO INFORMADO'
    Else If strCodoco = 'AV' Then Result := 'NÚMERO DO LOCAL DO FAVORECIDO NÃO INFORMADO'
    Else If strCodoco = 'AW' Then Result := 'CIDADE DO FAVORECIDO NÃO INFORAMADA'
    Else If strCodoco = 'AX' Then Result := 'CEP/COMPLEMENTO DE FAVORECIDO INVÁLIDO'
    Else If strCodoco = 'AY' Then Result := 'SIGLA DO ESTADO DO FAVORECIDO INVÁLIDO'
    Else If strCodoco = 'AZ' Then Result := 'CÓDIGO/NOME DO BANCO DEPOSITÁRIO INVALIDO'
    Else If strCodoco = 'BA' Then Result := 'CÓDIGO/NOME DA AGENCIA DEPOSITÁRIO NÃO INFORMADO'
    Else If strCodoco = 'BB' Then Result := 'NÚMERO DO DOCUMENTO INVÁLIDO (SEU NÚMERO)'
    Else If strCodoco = 'BC' Then Result := 'NOSSO NÚMERO INVÁLIDO'
    Else If strCodoco = 'BD' Then Result := 'INCLISÃO EFETUADA COM SUCESSO'
    Else If strCodoco = 'BE' Then Result := 'ALTERAÇÃO EFETUADA COM SUCESSO'
    Else If strCodoco = 'BF' Then Result := 'EXCLUSÃO EFETUADA COM SUCESSO'
    Else If strCodoco = 'BG' Then Result := 'AGÊNCIA/CONTA IMPEDIDA LEGALMENTE'
    Else If strCodoco = 'B1' Then Result := 'BLOQUEADO PENDENTE DE AUTORIZAÇÃO'
    Else If strCodoco = 'B3' Then Result := 'BLOQUEADO PELO CLIENTE'
    Else If strCodoco = 'B4' Then Result := 'BLOQUEADO PELA CAPTURA DE TÍTULO DA COBRANÇA'
    Else If strCodoco = 'B8' Then Result := 'BLOQUEADO PELA VALIDAÇÃO DE TRIBUTOS'
    Else If strCodoco = 'CA' Then Result := 'CÓDIGO DE BARRAS - CÓDIGO DO BANCO INVÁLIDO'
    Else If strCodoco = 'CB' Then Result := 'CÓDIGO DE BARRAS - CÓDIGO DA MOEDA INVÁLIDO'
    Else If strCodoco = 'CC' Then Result := 'CÓDIGO DE BARRAS - DÍGITO VERIFICADOR GERAL INVÁLIDO'
    Else If strCodoco = 'CD' Then Result := 'CÓDIGO DE BARRAS - VALOR DO TÍTULO INVÁLIDO'
    Else If strCodoco = 'CE' Then Result := 'CÓDIGO DE BARRAS - CAMPO LIVRE INVÁLIDO'
    Else If strCodoco = 'CF' Then Result := 'VALOR DO DOCUMENTO/PRINCIPAL/MENOR QUE O MÍNIMO INVÁLIDO'
    Else If strCodoco = 'CH' Then Result := 'VALOR DO DESCONTO INVÁLIDO'
    Else If strCodoco = 'CI' Then Result := 'VALOR DE MORA INVÁLIDO'
    Else If strCodoco = 'CJ' Then Result := 'VALOR DE MULTA INVÁLIDO'
    Else If strCodoco = 'CK' Then Result := 'VALOR DO IR INVÁLIDO'
    Else If strCodoco = 'CL' Then Result := 'VALOR DO ISS INVÁLIDO'
    Else If strCodoco = 'CM' Then Result := 'VALOR DO IOF INVÁLIDO'
    Else If strCodoco = 'CN' Then Result := 'VALOR DE OUTRAS DEDUÇÕES INVÁLIDO'
    Else If strCodoco = 'CO' Then Result := 'VALOR DE OUTROS ACRÉSCIMOS INVÁLIDO'
    Else If strCodoco = 'HA' Then Result := 'LOTE NÃO ACEITO'
    Else If strCodoco = 'HB' Then Result := 'INSCRIÇÃO DA EMPRESA INVÁLIDA PARA O CONTRATO'
    Else If strCodoco = 'HC' Then Result := 'CONVÊNIO COM A EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO'
    Else If strCodoco = 'HD' Then Result := 'AGÊNCIA/CONTA CORRENTE DA EMPRESA INEXISTENTE/INVÁLIDA PARA O CONTRATO'
    Else If strCodoco = 'HE' Then Result := 'TIPO DE SERVIÇO INVÁLIDO PARA O CONTRATO'
    Else If strCodoco = 'HF' Then Result := 'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE'
    Else If strCodoco = 'HG' Then Result := 'LOTE DE SERVIÇO FORA DA SEQÜÊNCIA'
    Else If strCodoco = 'HH' Then Result := 'LOTE DE SERVIÇO INVÁLIDO'
    Else If strCodoco = 'HI' Then Result := 'ARQUIVO NÃO ACEITO'
    Else If strCodoco = 'HJ' Then Result := 'TIPO DE REGISTRO INVÁLIDO'
    Else If strCodoco = 'HL' Then Result := 'VERSÃO DO LAYOUT INVÁLIDA'
    Else If strCodoco = 'HU' Then Result := 'HORA DE ENVIO INVÁLIDA'
    Else If strCodoco = 'IJ' Then Result := 'COMPETÊNCIA OU PERÍODO DE REFERÊNCIA OU NÚMERO DA PARCELA INVÁLIDO'
    Else If strCodoco = 'IM' Then Result := 'MUNICÍPO INVÁLIDO'
    Else If strCodoco = 'IN' Then Result := 'NÚMERO DECLARAÇÃO INVÁLIDO'
    Else If strCodoco = 'IO' Then Result := 'NÚMERO ETIQUETA INVÁLIDO'
    Else If strCodoco = 'IP' Then Result := 'NÚMERO NOTIFICAÇÃO INVÁLIDO'
    Else If strCodoco = 'IQ' Then Result := 'INSCRIÇÃO ESTADUAL INVÁLIDA'
    Else If strCodoco = 'IR' Then Result := 'DÍVIDA ATIVA INVÁLIDA'
    Else If strCodoco = 'IS' Then Result := 'VALOR HONORÁRIOS OU OUTROS ACRÉSCIMOS INVÁLIDO'
    Else If strCodoco = 'IT' Then Result := 'PERÍODO APURAÇÃO INVÁLIDO'
    Else If strCodoco = 'IU' Then Result := 'VALOR OU PERCENTUTAL DE RECEITA INVÁLIDO'
    Else If strCodoco = 'IV' Then Result := 'NÚMERO REFERÊNCIA INVÁLIDO'
    Else If strCodoco = 'TA' Then Result := 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DIFERENÇA'
    Else If strCodoco = 'XB' Then Result := 'NÚMERO DA INSCRIÇÃO DO CONTRIBUINTE INVÁLIDO'
    Else If strCodoco = 'XC' Then Result := 'CÓDIGO DO PAGAMENTO OU COMPETÊNCIA OU NÚMERO DA INSCRIÇÃO INVÁLIDO'
    Else If strCodoco = 'XF' Then Result := 'CÓDIGO DO PAGAMENTO OU COMPETÊNCIA NÃO NÚMERICO OU IGUAL A ZEROS'
    Else If strCodoco = 'YA' Then Result := 'TÍTULO NÃO ENCONTRADO'
    Else If strCodoco = 'YB' Then Result := 'IDENTIFICAÇÃO REGISTRO OPCIONAL INVÁLIDO'
    Else If strCodoco = 'YC' Then Result := 'CÓDIGO PADRÃO INVÁLIDO'
    Else If strCodoco = 'YD' Then Result := 'CÓDIGO DE OCORRÊNCIA INVÁLIDO'
    Else If strCodoco = 'YE' Then Result := 'COMPLEMENTO DE OCORRÊNCIA INVÁLIDO'
    Else If strCodoco = 'YF' Then Result := 'ALEGAÇÃO JÁ INFORMADA'
    Else If strCodoco = 'ZA' Then Result := 'TRANSFERÊNCIA DEVOLVIDA'
    Else If strCodoco = 'ZB' Then Result := 'TRANFERÊNCIA MESMA TITULARIDADE NÃO PERMITIDA'
    Else If strCodoco = 'ZC' Then Result := 'CÓDIGO PAGAMENTO TRIBUTO INVÁLIDO'
    Else If strCodoco = 'ZD' Then Result := 'COMPETÊNCIA INVÁLIDA'
    Else If strCodoco = 'ZE' Then Result := 'VALOR OUTRAS ENTIDADES INVÁLIDO'
    Else If strCodoco = 'ZF' Then Result := 'SISTEMA ORIGEM INVÁLIDO'
    Else If strCodoco = 'ZG' Then Result := 'BANCO DESTINO NÃO RECEBE DOC'
    Else If strCodoco = 'ZH' Then Result := 'BANCO DESTINO INOPERANTE PARA DOC'
    Else If strCodoco = 'ZI' Then Result := 'CÓDIGO DO HISTÓRICO DE CRÉDITO INVÁLIDO'
    Else If strCodoco = 'ZK' Then Result := 'AUTORIZAÇÃO INICIADA NO INTERNET BANKING'
    Else If strCodoco = 'Z0' Then Result := 'CONTA COM BLOQUEIO'
    Else If strCodoco = 'Z1' Then Result := 'CONTA FECHADA. É NECESSÁRIO ATIVAR A CONTA'
    Else If strCodoco = 'Z2' Then Result := 'CONTA COM MOVIMENTO CONTROLADO'
    Else If strCodoco = 'Z3' Then Result := 'CONTA CANCELADA'
    Else If strCodoco = 'Z4' Then Result := 'REGISTRO INCONSISTENTE (TÍTULO)'
    Else If strCodoco = 'Z5' Then Result := 'APRESENTAÇÃO INDEVIDA (TÍTULO)'
    Else If strCodoco = 'Z6' Then Result := 'DADOS DO DESTINATÁRIO INVÁLIDOS'
    Else If strCodoco = 'Z7' Then Result := 'AGÊNCIA OU CONTA DESTINATÁRIA DO CRÉDITO INVÁLIDA'
    Else If strCodoco = 'Z8' Then Result := 'DIVERGÊNCIA NA TITULARIDADE'
    Else If strCodoco = 'Z9' Then Result := 'CONTA DESTINATÁRIA DO CRÉDITO ENCERRADA'
    Else If strCodoco = 'C1' Then Result := 'COMPROR – DEVOLVIDO POR OUTROS BANCOS'
    Else If strCodoco = 'C2' Then Result := 'COMPROR – RECUSADO'
    Else If strCodoco = 'C3' Then Result := 'COMPROR – REJEITADO POR SISTEMA'
    Else If strCodoco = 'C4' Then Result := 'COMPROR – REJEITADO POR HORÁRIO'
    Else If strCodoco = 'C6' Then Result := 'COMPROR – APROVADO'
    Else If strCodoco = 'C7' Then Result := 'COMPROR – COMPROMISSO INVÁLIDO' 
    Else Result :=  'OUTRAS ';
  End
  Else
  If strCodBco = '422' Then
  Begin
    If strCodoco = '00' Then Result := 'PAGAMENTO EFETUADO '
    Else If strCodoco = '01' Then Result := 'INCLUSÃO ACEITA'
    Else If strCodoco = '02' Then Result := 'ALTERAÇÃO ACEITA'
    Else If strCodoco = '03' Then Result := 'EXCLUSÃO ACEITA'
    Else If strCodoco = '04' Then Result := 'AUTORIZAÇÃO ACEITA'
    Else If strCodoco = '05' Then Result := 'BLOQUEIO ACEITO'
    Else If strCodoco = '06' Then Result := 'DESBLOQUEIO ACEITO'
    Else If strCodoco = '11' Then Result := 'INCLUSÃO REJEITADA'
    Else If strCodoco = '12' Then Result := 'ALTERAÇÃO REJEITADA'
    Else If strCodoco = '13' Then Result := 'EXCLUSÃO REJEITADA'
    Else If strCodoco = '14' Then Result := 'AUTORIZAÇÃO REJEITADA'
    Else If strCodoco = '15' Then Result := 'BLOQUEIO REJEITADO'
    Else If strCodoco = '16' Then Result := 'DESBLOQUEIO REJEITADO'
    Else If strCodoco = '17' Then Result := 'CONFIRMAÇÃO DE COMPROMISSO ANTECIPADO AO FORNECEDOR'
    Else If strCodoco = '18' Then Result := 'COMPROMISSO ANTECIPADO AO FORNECEDOR'
    Else Result :=  'OUTRAS ';
  End
  Else
  If strCodBco = '756' Then
  Begin
    If strCodoco = '00' Then Result := 'PAGAMENTO EFETUADO '
    Else If strCodoco = '01' Then Result := 'INSUFICIÊNCIA DE FUNDOS - DÉBITO NÃO EFETUADO'
    Else If strCodoco = '02' Then Result := 'CRÉDITO OU DÉBITO CANCELADO PELO PAGADOR/CREDOR'
    Else If strCodoco = '03' Then Result := 'DÉBITO AUTORIZADO PELA AGÊNCIA - EFETUADOS'
    Else If strCodoco = 'AA' Then Result := 'CONTROLE INVÁLIDO'
    Else If strCodoco = 'AB' Then Result := 'TIPO DE OPERAÇÃO INVÁLIDO'
    Else If strCodoco = 'AC' Then Result := 'TIPO DE SERVIÇO INVÁLIDO'
    Else If strCodoco = 'AD' Then Result := 'FORMA DE LANÇAMENTO INVÁLIDA'
    Else If strCodoco = 'AE' Then Result := 'TIPO/NÚMERO DE INSCRIÇÃO INVÁLIDO (GERADO NA CRÍTICA OU PARA INFORMAR REJEIÇÃO)'
    Else If strCodoco = 'AF' Then Result := 'CÓDIGO DE CONVÊNIO INVÁLIDO'
    Else If strCodoco = 'AG' Then Result := 'AGÊNCIA/CONTA CORRENTE/DV INVÁLIDO'
    Else If strCodoco = 'AH' Then Result := 'NÚMERO SEQUENCIAL DO REGISTRO NO LOTE INVÁLIDO'
    Else If strCodoco = 'AI' Then Result := 'CÓDIGO DE SEGUIMENTO DETALHE INVÁLIDO'
    Else If strCodoco = 'AJ' Then Result := 'TIPO DE MOVIMENTO INVÁLIDO'
    Else If strCodoco = 'AK' Then Result := 'CÓDIGO NA CÂMARA DE COMPENSAÇÃO DO BANCO FAVORECIDO/DEPOSITÁRIO INVÁLIDO'
    Else If strCodoco = 'AL' Then Result := 'CÓDIGO DO BANCO FAVORECIDO OU DEPOSITÁRIO INVÁLIDO'
    Else If strCodoco = 'AM' Then Result := 'AGÊNCIA MANTENEDORA OU CONTA CORRENTE DO FAVORECIDO INVÁLIDA'
    Else If strCodoco = 'AN' Then Result := 'CONTA CORRENTE/DV DO FAVORECIDO INVÁLDO'
    Else If strCodoco = 'AO' Then Result := 'NOME DO FAVORECIDO NÃO INFORMADO'
    Else If strCodoco = 'AP' Then Result := 'DATA LANÇAMENTO INVÁLIDA/ VENCIMENTO INVÁLIDA'
    Else If strCodoco = 'AQ' Then Result := 'TIPO/QUANTIDADE DE MOEDA INVÁLIDO'
    Else If strCodoco = 'AR' Then Result := 'VALOR DO LANÇAMENTO INVÁLIDO'
    Else If strCodoco = 'AS' Then Result := 'AVISO AO FAVORECIDO - IDENTIFICAÇÃO INVÁLIDA'
    Else If strCodoco = 'AT' Then Result := 'TIPO/NÚMERO DE INSCRIÇÃO DO FAVORECIDO/CONTRIBUINTE INVÁLIDO'
    Else If strCodoco = 'AU' Then Result := 'LOGRADOURO DO FAVORECIDO NÃO INFORMADO'
    Else If strCodoco = 'AV' Then Result := 'NÚMERO DO LOCAL DO FAVORECIDO NÃO INFORMADO'
    Else If strCodoco = 'AW' Then Result := 'CIDADE DO FAVORECIDO NÃO INFORAMADA'
    Else If strCodoco = 'AX' Then Result := 'CEP/COMPLEMENTO DE FAVORECIDO INVÁLIDO'
    Else If strCodoco = 'AY' Then Result := 'SIGLA DO ESTADO DO FAVORECIDO INVÁLIDO'
    Else If strCodoco = 'AZ' Then Result := 'CÓDIGO/NOME DO BANCO DEPOSITÁRIO INVALIDO'
    Else If strCodoco = 'BA' Then Result := 'CÓDIGO/NOME DA AGENCIA DEPOSITÁRIO NÃO INFORMADO'
    Else If strCodoco = 'BB' Then Result := 'NÚMERO DO DOCUMENTO INVÁLIDO (SEU NÚMERO)'
    Else If strCodoco = 'BC' Then Result := 'NOSSO NÚMERO INVÁLIDO'
    Else If strCodoco = 'BD' Then Result := 'INCLUSÃO EFETUADA COM SUCESSO'
    Else If strCodoco = 'BE' Then Result := 'ALTERAÇÃO EFETUADA COM SUCESSO'
    Else If strCodoco = 'BF' Then Result := 'TRANSAÇÃO REJEITADA'
    Else If strCodoco = 'BG' Then Result := 'AGÊNCIA/CONTA IMPEDIDA LEGALMENTE'
    Else If strCodoco = 'B1' Then Result := 'BLOQUEADO PENDENTE DE AUTORIZAÇÃO'
    Else If strCodoco = 'B3' Then Result := 'BLOQUEADO PELO CLIENTE'
    Else If strCodoco = 'B4' Then Result := 'BLOQUEADO PELA CAPTURA DE TÍTULO DA COBRANÇA'
    Else If strCodoco = 'B8' Then Result := 'BLOQUEADO PELA VALIDAÇÃO DE TRIBUTOS'
    Else If strCodoco = 'CA' Then Result := 'CÓDIGO DE BARRAS - CÓDIGO DO BANCO INVÁLIDO'
    Else If strCodoco = 'CB' Then Result := 'CÓDIGO DE BARRAS - CÓDIGO DA MOEDA INVÁLIDO'
    Else If strCodoco = 'CC' Then Result := 'CÓDIGO DE BARRAS - DÍGITO VERIFICADOR GERAL INVÁLIDO'
    Else If strCodoco = 'CD' Then Result := 'CÓDIGO DE BARRAS - VALOR DO TÍTULO INVÁLIDO'
    Else If strCodoco = 'CE' Then Result := 'CÓDIGO DE BARRAS - CAMPO LIVRE INVÁLIDO'
    Else If strCodoco = 'CF' Then Result := 'VALOR DO DOCUMENTO/PRINCIPAL/MENOR QUE O MÍNIMO INVÁLIDO'
    Else If strCodoco = 'CH' Then Result := 'VALOR DO DESCONTO INVÁLIDO'
    Else If strCodoco = 'CI' Then Result := 'VALOR DE MORA INVÁLIDO'
    Else If strCodoco = 'CJ' Then Result := 'VALOR DE MULTA INVÁLIDO'
    Else If strCodoco = 'CK' Then Result := 'VALOR DO IR INVÁLIDO'
    Else If strCodoco = 'CL' Then Result := 'VALOR DO ISS INVÁLIDO'
    Else If strCodoco = 'CM' Then Result := 'VALOR DO IOF INVÁLIDO'
    Else If strCodoco = 'CN' Then Result := 'VALOR DE OUTRAS DEDUÇÕES INVÁLIDO'
    Else If strCodoco = 'CO' Then Result := 'VALOR DE OUTROS ACRÉSCIMOS INVÁLIDO'
    Else If strCodoco = 'HA' Then Result := 'LOTE NÃO ACEITO'
    Else If strCodoco = 'HB' Then Result := 'INSCRIÇÃO DA EMPRESA INVÁLIDA PARA O CONTRATO'
    Else If strCodoco = 'HC' Then Result := 'CONVÊNIO COM A EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO'
    Else If strCodoco = 'HD' Then Result := 'AGÊNCIA/CONTA CORRENTE DA EMPRESA INEXISTENTE/INVÁLIDA PARA O CONTRATO'
    Else If strCodoco = 'HE' Then Result := 'TIPO DE SERVIÇO INVÁLIDO PARA O CONTRATO'
    Else If strCodoco = 'HF' Then Result := 'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE'
    Else If strCodoco = 'HG' Then Result := 'LOTE DE SERVIÇO FORA DA SEQÜÊNCIA'
    Else If strCodoco = 'HH' Then Result := 'LOTE DE SERVIÇO INVÁLIDO'
    Else If strCodoco = 'HI' Then Result := 'ARQUIVO NÃO ACEITO'
    Else If strCodoco = 'HJ' Then Result := 'TIPO DE REGISTRO INVÁLIDO'
    Else If strCodoco = 'HL' Then Result := 'VERSÃO DO LAYOUT INVÁLIDA'
    Else If strCodoco = 'HU' Then Result := 'HORA DE ENVIO INVÁLIDA'
    Else If strCodoco = 'IJ' Then Result := 'COMPETÊNCIA OU PERÍODO DE REFERÊNCIA OU NÚMERO DA PARCELA INVÁLIDO'
    Else If strCodoco = 'IM' Then Result := 'MUNICÍPO INVÁLIDO'
    Else If strCodoco = 'IN' Then Result := 'NÚMERO DECLARAÇÃO INVÁLIDO'
    Else If strCodoco = 'IO' Then Result := 'NÚMERO ETIQUETA INVÁLIDO'
    Else If strCodoco = 'IP' Then Result := 'NÚMERO NOTIFICAÇÃO INVÁLIDO'
    Else If strCodoco = 'IQ' Then Result := 'INSCRIÇÃO ESTADUAL INVÁLIDA'
    Else If strCodoco = 'IR' Then Result := 'DÍVIDA ATIVA INVÁLIDA'
    Else If strCodoco = 'IS' Then Result := 'VALOR HONORÁRIOS OU OUTROS ACRÉSCIMOS INVÁLIDO'
    Else If strCodoco = 'IT' Then Result := 'PERÍODO APURAÇÃO INVÁLIDO'
    Else If strCodoco = 'IU' Then Result := 'VALOR OU PERCENTUTAL DE RECEITA INVÁLIDO'
    Else If strCodoco = 'IV' Then Result := 'NÚMERO REFERÊNCIA INVÁLIDO'
    Else If strCodoco = 'PD' Then Result := 'TRANSAÇÃO PENDENTE DE ASSINATURA'
    Else If strCodoco = 'TA' Then Result := 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DIFERENÇA'
    Else If strCodoco = 'XB' Then Result := 'NÚMERO DA INSCRIÇÃO DO CONTRIBUINTE INVÁLIDO'
    Else If strCodoco = 'XC' Then Result := 'CÓDIGO DO PAGAMENTO OU COMPETÊNCIA OU NÚMERO DA INSCRIÇÃO INVÁLIDO'
    Else If strCodoco = 'XF' Then Result := 'CÓDIGO DO PAGAMENTO OU COMPETÊNCIA NÃO NÚMERICO OU IGUAL A ZEROS'
    Else If strCodoco = 'YA' Then Result := 'TÍTULO NÃO ENCONTRADO'
    Else If strCodoco = 'YB' Then Result := 'IDENTIFICAÇÃO REGISTRO OPCIONAL INVÁLIDO'
    Else If strCodoco = 'YC' Then Result := 'CÓDIGO PADRÃO INVÁLIDO'
    Else If strCodoco = 'YD' Then Result := 'CÓDIGO DE OCORRÊNCIA INVÁLIDO'
    Else If strCodoco = 'YE' Then Result := 'COMPLEMENTO DE OCORRÊNCIA INVÁLIDO'
    Else If strCodoco = 'YF' Then Result := 'ALEGAÇÃO JÁ INFORMADA'
    Else If strCodoco = 'ZA' Then Result := 'TRANSFERÊNCIA DEVOLVIDA'
    Else If strCodoco = 'ZB' Then Result := 'TRANFERÊNCIA MESMA TITULARIDADE NÃO PERMITIDA'
    Else If strCodoco = 'ZC' Then Result := 'CÓDIGO PAGAMENTO TRIBUTO INVÁLIDO'
    Else If strCodoco = 'ZD' Then Result := 'COMPETÊNCIA INVÁLIDA'
    Else If strCodoco = 'ZE' Then Result := 'VALOR OUTRAS ENTIDADES INVÁLIDO'
    Else If strCodoco = 'ZF' Then Result := 'SISTEMA ORIGEM INVÁLIDO'
    Else If strCodoco = 'ZG' Then Result := 'BANCO DESTINO NÃO RECEBE DOC'
    Else If strCodoco = 'ZH' Then Result := 'BANCO DESTINO INOPERANTE PARA DOC'
    Else If strCodoco = 'ZI' Then Result := 'CÓDIGO DO HISTÓRICO DE CRÉDITO INVÁLIDO'
    Else If strCodoco = 'ZK' Then Result := 'AUTORIZAÇÃO INICIADA NO INTERNET BANKING'
    Else If strCodoco = 'Z0' Then Result := 'CONTA COM BLOQUEIO'
    Else If strCodoco = 'Z1' Then Result := 'CONTA FECHADA. É NECESSÁRIO ATIVAR A CONTA'
    Else If strCodoco = 'Z2' Then Result := 'CONTA COM MOVIMENTO CONTROLADO'
    Else If strCodoco = 'Z3' Then Result := 'CONTA CANCELADA'
    Else If strCodoco = 'Z4' Then Result := 'REGISTRO INCONSISTENTE (TÍTULO)'
    Else If strCodoco = 'Z5' Then Result := 'APRESENTAÇÃO INDEVIDA (TÍTULO)'
    Else If strCodoco = 'Z6' Then Result := 'DADOS DO DESTINATÁRIO INVÁLIDOS'
    Else If strCodoco = 'Z7' Then Result := 'AGÊNCIA OU CONTA DESTINATÁRIA DO CRÉDITO INVÁLIDA'
    Else If strCodoco = 'Z8' Then Result := 'DIVERGÊNCIA NA TITULARIDADE'
    Else If strCodoco = 'Z9' Then Result := 'CONTA DESTINATÁRIA DO CRÉDITO ENCERRADA'
    Else If strCodoco = 'C1' Then Result := 'COMPROR – DEVOLVIDO POR OUTROS BANCOS'
    Else If strCodoco = 'C2' Then Result := 'COMPROR – RECUSADO'
    Else If strCodoco = 'C3' Then Result := 'COMPROR – REJEITADO POR SISTEMA'
    Else If strCodoco = 'C4' Then Result := 'COMPROR – REJEITADO POR HORÁRIO'
    Else If strCodoco = 'C6' Then Result := 'COMPROR – APROVADO'
    Else If strCodoco = 'C7' Then Result := 'COMPROR – COMPROMISSO INVÁLIDO'
    Else Result :=  'OUTRAS ';
  end

  Else If (strCodBco = '001') And FBancoAPI Then
    Result := TPagForBancoDoBrasilAPI.RetornaDescricaoDosErros(StrToInt(strCodoco))

  Else If (strCodBco = '237') Or ((strCodBco = '001') And Not blnPGG) Then
  begin
    Result := '';

    LContadorOcorrencias := 1;

    While LContadorOcorrencias < strCodoco.Length Do
    Begin
      LOcorrencia := Copy(strCodoco, LContadorOcorrencias, 2);

      if LOcorrencia = '00' then Result := Result + 'CRÉDITO OU DÉBITO EFETIVADO'
      else if LOcorrencia = '01' then Result := Result + 'INSUFICIÊNCIA DE FUNDOS - DÉBITO NÃO EFETUADO'
      else if LOcorrencia = '02' then Result := Result + 'CRÉDITO OU DÉBITO CANCELADO PELO PAGADOR/CREDOR'
      else if LOcorrencia = '03' then Result := Result + 'DÉBITO AUTORIZADO PELA AGÊNCIA - EFETUADO'
      else if LOcorrencia = 'AA' then Result := Result + 'CONTROLE INVÁLIDO'
      else if LOcorrencia = 'AB' then Result := Result + 'TIPO DE OPERAÇÃO INVÁLIDO'
      else if LOcorrencia = 'AC' then Result := Result + 'TIPO DE SERVIÇO INVÁLIDO'
      else if LOcorrencia = 'AD' then Result := Result + 'FORMA DE LANÇAMENTO INVÁLIDA'
      else if LOcorrencia = 'AE' then Result := Result + 'TIPO/NÚMERO DE INSCRIÇÃO INVÁLIDO'
      else if LOcorrencia = 'AF' then Result := Result + 'CÓDIGO DE CONVÊNIO INVÁLIDO'
      else if LOcorrencia = 'AG' then Result := Result + 'AGÊNCIA/CONTA CORRENTE/DV INVÁLIDO'
      else if LOcorrencia = 'AH' then Result := Result + 'Nº SEQUENCIAL DO REGISTRO NO LOTE INVÁLIDO'
      else if LOcorrencia = 'AI' then Result := Result + 'CÓDIGO DE SEGMENTO DE DETALHE INVÁLIDO'
      else if LOcorrencia = 'AJ' then Result := Result + 'TIPO DE MOVIMENTO INVÁLIDO'
      else if LOcorrencia = 'AK' then Result := Result + 'CÓDIGO DA CÂMARA DE COMPENSAÇÃO DO BANCO FAVORECIDO/DEPOSITÁRIO INVÁLIDO'
      else if LOcorrencia = 'AL' then Result := Result + 'CÓDIGO DO BANCO FAVORECIDO OU DEPOSITÁRIO INVÁLIDO'
      else if LOcorrencia = 'AM' then Result := Result + 'AGÊNCIA MANTENEDORA DA CONTA CORRENTE DO FAVORECIDO INVÁLIDA'
      else if LOcorrencia = 'AN' then Result := Result + 'CONTA CORRENTE/DV DO FAVORECIDO INVÁLIDO'
      else if LOcorrencia = 'AO' then Result := Result + 'NOME DO FAVORECIDO NÃO INFORMADO'
      else if LOcorrencia = 'AP' then Result := Result + 'DATA LANÇAMENTO INVÁLIDA'
      else if LOcorrencia = 'AQ' then Result := Result + 'TIPO/QUANTIDADE DA MOEDA INVÁLIDO'
      else if LOcorrencia = 'AR' then Result := Result + 'VALOR DO LANÇAMENTO INVÁLIDO'
      else if LOcorrencia = 'AS' then Result := Result + 'AVISO AO FAVORECIDO - IDENTifICAÇÃO INVÁLIDA'
      else if LOcorrencia = 'AT' then Result := Result + 'TIPO/NÚMERO DE INSCRIÇÃO DO FAVORECIDO INVÁLIDO'
      else if LOcorrencia = 'AU' then Result := Result + 'LOGRADOURO DO FAVORECIDO NÃO INFORMADO'
      else if LOcorrencia = 'AV' then Result := Result + 'Nº DO LOCAL DO FAVORECIDO NÃO INFORMADO'
      else if LOcorrencia = 'AW' then Result := Result + 'CIDADE DO FAVORECIDO NÃO INFORMADA'
      else if LOcorrencia = 'AX' then Result := Result + 'CEP/COMPLEMENTO DO FAVORECIDO INVÁLIDO'
      else if LOcorrencia = 'AY' then Result := Result + 'SIGLA DO ESTADO DO FAVORECIDO INVÁLIDA'
      else if LOcorrencia = 'AZ' then Result := Result + 'CÓDIGO/NOME DO BANCO DEPOSITÁRIO INVÁLIDO'
      else if LOcorrencia = 'BA' then Result := Result + 'CÓDIGO/NOME DA AGÊNCIA DEPOSITÁRIA NÃO INFORMADO'
      else if LOcorrencia = 'BB' then Result := Result + 'SEU NÚMERO INVÁLIDO'
      else if LOcorrencia = 'BC' then Result := Result + 'NOSSO NÚMERO INVÁLIDO'
      else if LOcorrencia = 'BD' then Result := Result + 'INCLUSÃO EFETUADA COM SUCESSO'
      else if LOcorrencia = 'BE' then Result := Result + 'ALTERAÇÃO EFETUADA COM SUCESSO'
      else if LOcorrencia = 'BF' then Result := Result + 'EXCLUSÃO EFETUADA COM SUCESSO'
      else if LOcorrencia = 'BG' then Result := Result + 'AGÊNCIA/CONTA IMPEDIDA LEGALMENTE'
      else if LOcorrencia = 'BH' then Result := Result + 'EMPRESA NÃO PAGOU SALÁRIO'
      else if LOcorrencia = 'BI' then Result := Result + 'FALECIMENTO DO MUTUÁRIO'
      else if LOcorrencia = 'BJ' then Result := Result + 'EMPRESA NÃO ENVIOU REMESSA DO MUTUÁRIO'
      else if LOcorrencia = 'BK' then Result := Result + 'EMPRESA NÃO ENVIOU REMESSA NO VENCIMENTO'
      else if LOcorrencia = 'BL' then Result := Result + 'VALOR DA PARCELA INVÁLIDA'
      else if LOcorrencia = 'BM' then Result := Result + 'IDENTifICAÇÃO DO CONTRATO INVÁLIDA'
      else if LOcorrencia = 'BN' then Result := Result + 'OPERAÇÃO DE CONSIGNAÇÃO INCLUÍDA COM SUCESSO'
      else if LOcorrencia = 'BO' then Result := Result + 'OPERAÇÃO DE CONSIGNAÇÃO ALTERADA COM SUCESSO'
      else if LOcorrencia = 'BP' then Result := Result + 'OPERAÇÃO DE CONSIGNAÇÃO EXCLUÍDA COM SUCESSO'
      else if LOcorrencia = 'BQ' then Result := Result + 'OPERAÇÃO DE CONSIGNAÇÃO LIQUIDADA COM SUCESSO'
      else if LOcorrencia = 'CA' then Result := Result + 'CÓDIGO DE BARRAS - CÓDIGO DO BANCO INVÁLIDO'
      else if LOcorrencia = 'CB' then Result := Result + 'CÓDIGO DE BARRAS - CÓDIGO DA MOEDA INVÁLIDO'
      else if LOcorrencia = 'CC' then Result := Result + 'CÓDIGO DE BARRAS - DÍGITO VERifICADOR GERAL INVÁLIDO'
      else if LOcorrencia = 'CD' then Result := Result + 'CÓDIGO DE BARRAS - VALOR DO TÍTULO INVÁLIDO'
      else if LOcorrencia = 'CE' then Result := Result + 'CÓDIGO DE BARRAS -  CAMPO LIVRE INVÁLIDO'
      else if LOcorrencia = 'CF' then Result := Result + 'VALOR DO DOCUMENTO INVÁLIDO'
      else if LOcorrencia = 'CG' then Result := Result + 'VALOR DO ABATIMENTO INVÁLIDO'
      else if LOcorrencia = 'CH' then Result := Result + 'VALOR DO DESCONTO INVÁLIDO'
      else if LOcorrencia = 'CI' then Result := Result + 'VALOR DE MORA INVÁLIDO'
      else if LOcorrencia = 'CJ' then Result := Result + 'VALOR DA MULTA INVÁLIDO'
      else if LOcorrencia = 'CK' then Result := Result + 'VALOR DO IR INVÁLIDO'
      else if LOcorrencia = 'CL' then Result := Result + 'VALOR DO ISS INVÁLIDO'
      else if LOcorrencia = 'CM' then Result := Result + 'VALOR DO IOF INVÁLIDO'
      else if LOcorrencia = 'CN' then Result := Result + 'VALOR DE OUTRAS DEDUÇÕES INVÁLIDO'
      else if LOcorrencia = 'CO' then Result := Result + 'VALOR DE OUTROS ACRÉSCIMOS INVÁLIDO'
      else if LOcorrencia = 'CP' then Result := Result + 'VALOR DO INSS INVÁLIDO'
      else if LOcorrencia = 'HA' then Result := Result + 'LOTE NÃO ACEITO'
      else if LOcorrencia = 'HB' then Result := Result + 'INSCRIÇÃO DA EMPRESA INVÁLIDA PARA O CONTRATO'
      else if LOcorrencia = 'HC' then Result := Result + 'CONVÊNIO COM A EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO'
      else if LOcorrencia = 'HD' then Result := Result + 'AGÊNCIA/CONTA CORRENTE DA EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO'
      else if LOcorrencia = 'HE' then Result := Result + 'TIPO DE SERVIÇO INVÁLIDO PARA O CONTRATO'
      else if LOcorrencia = 'HF' then Result := Result + 'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE'
      else if LOcorrencia = 'HG' then Result := Result + 'LOTE DE SERVIÇO FORA DE SEQUÊNCIA'
      else if LOcorrencia = 'HH' then Result := Result + 'LOTE DE SERVIÇO INVÁLIDO'
      else if LOcorrencia = 'HI' then Result := Result + 'ARQUIVO NÃO ACEITO'
      else if LOcorrencia = 'HJ' then Result := Result + 'TIPO DE REGISTRO INVÁLIDO'
      else if LOcorrencia = 'HK' then Result := Result + 'CÓDIGO REMESSA / RETORNO INVÁLIDO'
      else if LOcorrencia = 'HL' then Result := Result + 'VERSÃO DE LAYOUT INVÁLIDA'
      else if LOcorrencia = 'HM' then Result := Result + 'MUTUÁRIO NÃO IDENTifICADO'
      else if LOcorrencia = 'HN' then Result := Result + 'TIPO DO BENEFÍCIO NÃO PERMITE EMPRÉSTIMO'
      else if LOcorrencia = 'HO' then Result := Result + 'BENEFICIO CESSADO/SUSPENSO'
      else if LOcorrencia = 'HP' then Result := Result + 'BENEFICIO POSSUI REPRESENTANTE LEGAL'
      else if LOcorrencia = 'HQ' then Result := Result + 'BENEFÍCIO É DO TIPO PA (PENSÃO ALIMENTÍCIA)'
      else if LOcorrencia = 'HR' then Result := Result + 'QUANTIDADE DE CONTRATOS PERMITIDA EXCEDIDA'
      else if LOcorrencia = 'HS' then Result := Result + 'BENEFÍCIO NÃO PERTENCE AO BANCO INFORMADO'
      else if LOcorrencia = 'HT' then Result := Result + 'INÍCIO DO DESCONTO INFORMADO JÁ ULTRAPASSADO'
      else if LOcorrencia = 'HU' then Result := Result + 'NÚMERO DA PARCELA INVÁLIDA'
      else if LOcorrencia = 'HV' then Result := Result + 'QUANTIDADE DE PARCELA INVÁLIDA'
      else if LOcorrencia = 'HW' then Result := Result + 'MARGEM CONSIGNÁVEL EXCEDIDA PARA O MUTUÁRIO DENTRO DO PRAZO DO CONTRATO'
      else if LOcorrencia = 'HX' then Result := Result + 'EMPRÉSTIMO JÁ CADASTRADO'
      else if LOcorrencia = 'HY' then Result := Result + 'EMPRÉSTIMO INEXISTENTE'
      else if LOcorrencia = 'HZ' then Result := Result + 'EMPRÉSTIMO JÁ ENCERRADO'
      else if LOcorrencia = 'H1' then Result := Result + 'ARQUIVO SEM TRAILER'
      else if LOcorrencia = 'H2' then Result := Result + 'MUTUÁRIO SEM CRÉDITO NA COMPETÊNCIA'
      else if LOcorrencia = 'H3' then Result := Result + 'NÃO DESCONTADO – OUTROS MOTIVOS'
      else if LOcorrencia = 'H4' then Result := Result + 'RETORNO DE CRÉDITO NÃO PAGO'
      else if LOcorrencia = 'H5' then Result := Result + 'CANCELAMENTO DE EMPRÉSTIMO RETROATIVO'
      else if LOcorrencia = 'H6' then Result := Result + 'OUTROS MOTIVOS DE GLOSA'
      else if LOcorrencia = 'H7' then Result := Result + 'MARGEM CONSIGNÁVEL EXCEDIDA PARA O MUTUÁRIO ACIMA DO PRAZO DO CONTRATO'
      else if LOcorrencia = 'H8' then Result := Result + 'MUTUÁRIO DESLIGADO DO EMPREGADOR'
      else if LOcorrencia = 'H9' then Result := Result + 'MUTUÁRIO AFASTADO POR LICENÇA'
      else if LOcorrencia = 'IA' then Result := Result + 'PRIMEIRO NOME DO MUTUÁRIO DifERENTE DO PRIMEIRO NOME DO MOVIMENTO DO CENSO OU DifERENTE DA BASE DE'
      else if LOcorrencia = 'TA' then Result := Result + 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DifERENÇA'
      else if LOcorrencia = 'YA' then Result := Result + 'TÍTULO NÃO ENCONTRADO'
      else if LOcorrencia = 'YB' then Result := Result + 'IDENTifICADOR REGISTRO OPCIONAL INVÁLIDO'
      else if LOcorrencia = 'YC' then Result := Result + 'CÓDIGO PADRÃO INVÁLIDO'
      else if LOcorrencia = 'YD' then Result := Result + 'CÓDIGO DE OCORRÊNCIA INVÁLIDO'
      else if LOcorrencia = 'YE' then Result := Result + 'COMPLEMENTO DE OCORRÊNCIA INVÁLIDO'
      else if LOcorrencia = 'YF' then Result := Result + 'ALEGAÇÃO JÁ INFORMADA'
      else if LOcorrencia = 'ZA' then Result := Result + 'AGÊNCIA / CONTA DO FAVORECIDO SUBSTITUÍDA'
      else if LOcorrencia = 'ZB' then Result := Result + 'DIVERGÊNCIA ENTRE O PRIMEIRO E ÚLTIMO NOME DO BENEFICIÁRIO VERSUS PRIMEIRO E ÚLTIMO'
      else if LOcorrencia = 'ZC' then Result := Result + 'CONFIRMAÇÃO DE ANTECIPAÇÃO DE VALOR'
      else if LOcorrencia = 'ZD' then Result := Result + 'ANTECIPAÇÃO PARCIAL DE VALOR'
      else if LOcorrencia = '5A' then Result := Result + 'AGENDADO SOB LISTA DE DEBITO'
      else if LOcorrencia = '5B' then Result := Result + 'PAGAMENTO NÃO AUTORIZA SOB LISTA DE DEBITO'
      else if LOcorrencia = '5C' then Result := Result + 'LISTA COM MAIS DE UMA MODALIDADE'
      else if LOcorrencia = '5D' then Result := Result + 'LISTA COM MAIS DE UMA DATA DE PAGAMENTO'
      else if LOcorrencia = '5E' then Result := Result + 'NÚMERO DE LISTA DUPLICADO'
      else if LOcorrencia = '5F' then Result := Result + 'LISTA DE DEBITO VENCIDA E NÃO AUTORIZADA'
      else if LOcorrencia = '5M' then Result := Result + 'NÚMERO DE LISTA DE DEBITO INVALIDA'
      else Result := Result +  'OUTRAS ';

      Result := Result + ' - ';

      Inc(LContadorOcorrencias, 2);
    End;

    Result := LeftStr(Result, Result.Length - 2);
  end

  Else If ((strCodBco = '001') And blnPGG) Then
  Begin
         If (strCodOco = '00') then Result := 'CRÉDITO OU DÉBITO EFETIVADO'
    Else If (strCodOco = '01') Then Result := 'Campo não numérico'
    Else If (strCodOco = '02') Then Result := 'Valor maior do que o permitido'
    Else If (strCodOco = '03') Then Result := 'Campo com dígito verificador inválido'
    Else If (strCodOco = '04') Then Result := 'Identificador do produto inválido'
    Else If (strCodOco = '05') Then Result := 'Código de segmento inválido'
    Else If (strCodOco = '06') Then Result := 'Código de moeda inválido'
    Else If (strCodOco = '07') Then Result := 'Ano inválido no campo data'
    Else If (strCodOco = '08') Then Result := 'Barra Secretaria da Fazenda inválido'
    Else If (strCodOco = '09') Then Result := 'Convênio não ativo'
    Else If (strCodOco = '10') Then Result := 'Quantidade de dias maior do que o limite'
    Else If (strCodOco = '11') Then Result := 'Erro no cálculo do valor'
    Else If (strCodOco = '12') Then Result := 'Código de incidência de multa inválido'
    Else If (strCodOco = '13') Then Result := 'Valor do dígito difere do valor do código de barra'
    Else If (strCodOco = '14') Then Result := 'Erro na depuração da barra'
    Else If (strCodOco = '15') Then Result := 'Erro na recuperação de índice'
    Else If (strCodOco = '16') Then Result := 'Erro na recuperação de feriado'
    Else If (strCodOco = '17') Then Result := 'Documento vencido'
    Else If (strCodOco = '18') Then Result := 'Recebimento indevido pelo autoatendimento'
    Else If (strCodOco = '19') Then Result := 'Erro no sistema DB2'
    Else If (strCodOco = '20') Then Result := 'Sem comunicação com o sistema de contas correntes'
    Else If (strCodOco = '21') Then Result := 'Data do pagamento vencida'
    Else If (strCodOco = '22') Then Result := 'Convênio não autorizado'
    Else If (strCodOco = '23') Then Result := 'Ausência de autorização de débito'
    Else If (strCodOco = '24') Then Result := 'Autorização de débito inválida'
    Else If (strCodOco = '25') Then Result := 'Autorização de débito irregular'
    Else If (strCodOco = '26') Then Result := 'Data pagamento anterior data atual'
    Else If (strCodOco = '27') Then Result := 'Tipo inválido ou incompatível com a receita'
    Else If (strCodOco = '28') Then Result := 'Campo referência não numérico'
    Else If (strCodOco = '29') Then Result := 'Exigida referência válida'
    Else If (strCodOco = '32') Then Result := 'Data vencimento inválida'
    Else If (strCodOco = '33') Then Result := 'Valor juros invalido'
    Else If (strCodOco = '35') Then Result := 'Valor total inválido'
    Else If (strCodOco = '37') Then Result := 'Autorização de débito não vinculado ao convênio remetente'
    Else If (strCodOco = '38') Then Result := 'Convênio não autorizado a efetuar pagamento p/autorização'
    Else If (strCodOco = '82') Then Result := 'Convênio não ativo'
    Else If (strCodOco = '85') Then Result := 'Header do arquivo inválido'
    Else If (strCodOco = '87') Then Result := 'Remessa sem Trailer'
    Else If (strCodOco = '88') Then Result := 'Número sequencial da remessa duplicado'
    Else If (strCodOco = '90') Then Result := 'Identificador arquivo não é REC300'
    Else If (strCodOco = '91') Then Result := 'Convênio não cadastrado'
    Else If (strCodOco = '93') Then Result := 'Problemas no campo Ocorrências de Retorno'
    Else If (strCodOco = '94') Then Result := 'Convenio remetente em situação irregular'
    Else If (strCodOco = '95') Then Result := 'Saldo insuficiente'
    Else If (strCodOco = '96') Then Result := 'Convenio destinatário da Receita em situação irregular'
    Else If (strCodOco = '97') Then Result := 'Sem comunicação com o sistema de contas correntes'
    Else If (strCodOco = '99') Then Result := 'Débito não autorizado'
    Else Result := 'OUTRAS';

    Result := AnsiUpperCase(Result);
  End

  else
  If strCodBco = '021' Then
  begin
    If strCodoco = '00' Then Result := 'PAGAMENTO EFETUADO '
    Else If strCodOco = '01' Then Result := 'INCLUSÃO'
    Else If strCodOco = '11' Then Result := 'INCLUSÃO REJEITADA';
  end
  Else
  If (strCodBco = '041') Then
  begin
         if strCodOco = '00' then Result := 'CRÉDITO OU DÉBITO EFETIVADO'
    else if strCodOco = '01' then Result := 'INSUFICIÊNCIA DE FUNDOS - DÉBITO NÃO EFETUADO'
    else if strCodOco = '02' then Result := 'CRÉDITO OU DÉBITO CANCELADO PELO PAGADOR/CREDOR'
    else if strCodOco = '03' then Result := 'DÉBITO AUTORIZADO PELA AGÊNCIA - EFETUADO'
    else if strCodOco = 'AA' then Result := 'CONTROLE INVÁLIDO'
    else if strCodOco = 'AB' then Result := 'TIPO DE OPERAÇÃO INVÁLIDO'
    else if strCodOco = 'AC' then Result := 'TIPO DE SERVIÇO INVÁLIDO'
    else if strCodOco = 'AD' then Result := 'FORMA DE LANÇAMENTO INVÁLIDA'
    else if strCodOco = 'AE' then Result := 'TIPO/NÚMERO DE INSCRIÇÃO INVÁLIDO'
    else if strCodOco = 'AF' then Result := 'CÓDIGO DE CONVÊNIO INVÁLIDO'
    else if strCodOco = 'AG' then Result := 'AGÊNCIA/CONTA CORRENTE/DV INVÁLIDO'
    else if strCodOco = 'AH' then Result := 'Nº SEQUENCIAL DO REGISTRO NO LOTE INVÁLIDO'
    else if strCodOco = 'AI' then Result := 'CÓDIGO DE SEGMENTO DE DETALHE INVÁLIDO'
    else if strCodOco = 'AJ' then Result := 'TIPO DE MOVIMENTO INVÁLIDO'
    else if strCodOco = 'AK' then Result := 'CÓDIGO DA CÂMARA DE COMPENSAÇÃO DO BANCO FAVORECIDO/DEPOSITÁRIO INVÁLIDO'
    else if strCodOco = 'AL' then Result := 'CÓDIGO DO BANCO FAVORECIDO, INSTITUIÇÃO DE PAGAMENTO OU DEPOSITÁRIO INVÁLIDO'
    else if strCodOco = 'AM' then Result := 'AGÊNCIA MANTENEDORA DA CONTA CORRENTE DO FAVORECIDO INVÁLIDA'
    else if strCodOco = 'AN' then Result := 'CONTA CORRENTE/DV DO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'AO' then Result := 'NOME DO FAVORECIDO NÃO INFORMADO'
    else if strCodOco = 'AP' then Result := 'DATA LANÇAMENTO INVÁLIDA'
    else if strCodOco = 'AQ' then Result := 'TIPO/QUANTIDADE DA MOEDA INVÁLIDO'
    else if strCodOco = 'AR' then Result := 'VALOR DO LANÇAMENTO INVÁLIDO'
    else if strCodOco = 'AS' then Result := 'AVISO AO FAVORECIDO - IDENTifICAÇÃO INVÁLIDA'
    else if strCodOco = 'AT' then Result := 'TIPO/NÚMERO DE INSCRIÇÃO DO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'AU' then Result := 'LOGRADOURO DO FAVORECIDO NÃO INFORMADO'
    else if strCodOco = 'AV' then Result := 'Nº DO LOCAL DO FAVORECIDO NÃO INFORMADO'
    else if strCodOco = 'AW' then Result := 'CIDADE DO FAVORECIDO NÃO INFORMADA'
    else if strCodOco = 'AX' then Result := 'CEP/COMPLEMENTO DO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'AY' then Result := 'SIGLA DO ESTADO DO FAVORECIDO INVÁLIDA'
    else if strCodOco = 'AZ' then Result := 'CÓDIGO/NOME DO BANCO DEPOSITÁRIO INVÁLIDO'
    else if strCodOco = 'BA' then Result := 'CÓDIGO/NOME DA AGÊNCIA DEPOSITÁRIA NÃO INFORMADO'
    else if strCodOco = 'BB' then Result := 'SEU NÚMERO INVÁLIDO'
    else if strCodOco = 'BC' then Result := 'NOSSO NÚMERO INVÁLIDO'
    else if strCodOco = 'BD' then Result := 'INCLUSÃO EFETUADA COM SUCESSO'
    else if strCodOco = 'BE' then Result := 'ALTERAÇÃO EFETUADA COM SUCESSO'
    else if strCodOco = 'BF' then Result := 'EXCLUSÃO EFETUADA COM SUCESSO'
    else if strCodOco = 'BG' then Result := 'AGÊNCIA/CONTA IMPEDIDA LEGALMENTE'
    else if strCodOco = 'BH' then Result := 'EMPRESA NÃO PAGOU SALÁRIO'
    else if strCodOco = 'BI' then Result := 'FALECIMENTO DO MUTUÁRIO'
    else if strCodOco = 'BJ' then Result := 'EMPRESA NÃO ENVIOU REMESSA DO MUTUÁRIO'
    else if strCodOco = 'BK' then Result := 'EMPRESA NÃO ENVIOU REMESSA NO VENCIMENTO'
    else if strCodOco = 'BL' then Result := 'VALOR DA PARCELA INVÁLIDA'
    else if strCodOco = 'BM' then Result := 'IDENTifICAÇÃO DO CONTRATO INVÁLIDA'
    else if strCodOco = 'BN' then Result := 'OPERAÇÃO DE CONSIGNAÇÃO INCLUÍDA COM SUCESSO'
    else if strCodOco = 'BO' then Result := 'OPERAÇÃO DE CONSIGNAÇÃO ALTERADA COM SUCESSO'
    else if strCodOco = 'BP' then Result := 'OPERAÇÃO DE CONSIGNAÇÃO EXCLUÍDA COM SUCESSO'
    else if strCodOco = 'BQ' then Result := 'OPERAÇÃO DE CONSIGNAÇÃO LIQUIDADA COM SUCESSO'
    else if strCodOco = 'BR' then Result := 'REATIVAÇÃO EFETUADA COM SUCESSO'
    else if strCodOco = 'BS' then Result := 'SUSPENÇÃO EFETUADA COM SUCESSO'
    else if strCodOco = 'CA' then Result := 'CÓDIGO DE BARRAS - CÓDIGO DO BANCO INVÁLIDO'
    else if strCodOco = 'CB' then Result := 'CÓDIGO DE BARRAS - CÓDIGO DA MOEDA INVÁLIDO'
    else if strCodOco = 'CC' then Result := 'CÓDIGO DE BARRAS - DÍGITO VERifICADOR GERAL INVÁLIDO'
    else if strCodOco = 'CD' then Result := 'CÓDIGO DE BARRAS - VALOR DO TÍTULO INVÁLIDO'
    else if strCodOco = 'CE' then Result := 'CÓDIGO DE BARRAS -  CAMPO LIVRE INVÁLIDO'
    else if strCodOco = 'CF' then Result := 'VALOR DO DOCUMENTO INVÁLIDO'
    else if strCodOco = 'CG' then Result := 'VALOR DO ABATIMENTO INVÁLIDO'
    else if strCodOco = 'CH' then Result := 'VALOR DO DESCONTO INVÁLIDO'
    else if strCodOco = 'CI' then Result := 'VALOR DE MORA INVÁLIDO'
    else if strCodOco = 'CJ' then Result := 'VALOR DA MULTA INVÁLIDO'
    else if strCodOco = 'CK' then Result := 'VALOR DO IR INVÁLIDO'
    else if strCodOco = 'CL' then Result := 'VALOR DO ISS INVÁLIDO'
    else if strCodOco = 'CM' then Result := 'VALOR DO IOF INVÁLIDO'
    else if strCodOco = 'CN' then Result := 'VALOR DE OUTRAS DEDUÇÕES INVÁLIDO'
    else if strCodOco = 'CO' then Result := 'VALOR DE OUTROS ACRÉSCIMOS INVÁLIDO'
    else if strCodOco = 'CP' then Result := 'VALOR DO INSS INVÁLIDO'
    else if strCodOco = 'HA' then Result := 'LOTE NÃO ACEITO'
    else if strCodOco = 'HB' then Result := 'INSCRIÇÃO DA EMPRESA INVÁLIDA PARA O CONTRATO'
    else if strCodOco = 'HC' then Result := 'CONVÊNIO COM A EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO'
    else if strCodOco = 'HD' then Result := 'AGÊNCIA/CONTA CORRENTE DA EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO'
    else if strCodOco = 'HE' then Result := 'TIPO DE SERVIÇO INVÁLIDO PARA O CONTRATO'
    else if strCodOco = 'HF' then Result := 'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE'
    else if strCodOco = 'HG' then Result := 'LOTE DE SERVIÇO FORA DE SEQUÊNCIA'
    else if strCodOco = 'HH' then Result := 'LOTE DE SERVIÇO INVÁLIDO'
    else if strCodOco = 'HI' then Result := 'ARQUIVO NÃO ACEITO'
    else if strCodOco = 'HJ' then Result := 'TIPO DE REGISTRO INVÁLIDO'
    else if strCodOco = 'HK' then Result := 'CÓDIGO REMESSA / RETORNO INVÁLIDO'
    else if strCodOco = 'HL' then Result := 'VERSÃO DE LAYOUT INVÁLIDA'
    else if strCodOco = 'HM' then Result := 'MUTUÁRIO NÃO IDENTifICADO'
    else if strCodOco = 'HN' then Result := 'TIPO DO BENEFÍCIO NÃO PERMITE EMPRÉSTIMO'
    else if strCodOco = 'HO' then Result := 'BENEFICIO CESSADO/SUSPENSO'
    else if strCodOco = 'HP' then Result := 'BENEFICIO POSSUI REPRESENTANTE LEGAL'
    else if strCodOco = 'HQ' then Result := 'BENEFÍCIO É DO TIPO PA (PENSÃO ALIMENTÍCIA)'
    else if strCodOco = 'HR' then Result := 'QUANTIDADE DE CONTRATOS PERMITIDA EXCEDIDA'
    else if strCodOco = 'HS' then Result := 'BENEFÍCIO NÃO PERTENCE AO BANCO INFORMADO'
    else if strCodOco = 'HT' then Result := 'INÍCIO DO DESCONTO INFORMADO JÁ ULTRAPASSADO'
    else if strCodOco = 'HU' then Result := 'NÚMERO DA PARCELA INVÁLIDA'
    else if strCodOco = 'HV' then Result := 'QUANTIDADE DE PARCELA INVÁLIDA'
    else if strCodOco = 'HW' then Result := 'MARGEM CONSIGNÁVEL EXCEDIDA PARA O MUTUÁRIO DENTRO DO PRAZO DO CONTRATO'
    else if strCodOco = 'HX' then Result := 'EMPRÉSTIMO JÁ CADASTRADO'
    else if strCodOco = 'HY' then Result := 'EMPRÉSTIMO INEXISTENTE'
    else if strCodOco = 'HZ' then Result := 'EMPRÉSTIMO JÁ ENCERRADO'
    else if strCodOco = 'H1' then Result := 'ARQUIVO SEM TRAILER'
    else if strCodOco = 'H2' then Result := 'MUTUÁRIO SEM CRÉDITO NA COMPETÊNCIA'
    else if strCodOco = 'H3' then Result := 'NÃO DESCONTADO – OUTROS MOTIVOS'
    else if strCodOco = 'H4' then Result := 'RETORNO DE CRÉDITO NÃO PAGO'
    else if strCodOco = 'H5' then Result := 'CANCELAMENTO DE EMPRÉSTIMO RETROATIVO'
    else if strCodOco = 'H6' then Result := 'OUTROS MOTIVOS DE GLOSA'
    else if strCodOco = 'H7' then Result := 'MARGEM CONSIGNÁVEL EXCEDIDA PARA O MUTUÁRIO ACIMA DO PRAZO DO CONTRATO'
    else if strCodOco = 'H8' then Result := 'MUTUÁRIO DESLIGADO DO EMPREGADOR'
    else if strCodOco = 'H9' then Result := 'MUTUÁRIO AFASTADO POR LICENÇA'
    else if strCodOco = 'IA' then Result := 'PRIMEIRO NOME DO MUTUÁRIO DifERENTE DO PRIMEIRO NOME DO MOVIMENTO DO CENSO OU DifERENTE DA BASE DE'
    else if strCodOco = 'IB' then Result := 'BENEFICIO SUSPENSO/CESSADO PELA APS OU SISOBI'
    else if strCodOco = 'IC' then Result := 'BENEFICIO SUSPENSO POR DEPENDÊNCIA DE CALCULO'
    else if strCodOco = 'ID' then Result := 'BENEFICIO SUSPENSO/CESSADO PELA INSPETORIA/AUDITORIA'
    else if strCodOco = 'IE' then Result := 'BENEFICIO BLOQUEADO PARA EMPRESTIMO PELO BENEFICIÁRIO'
    else if strCodOco = 'IF' then Result := 'BENEFICIO BLOQUEADO PARA EMPRESTIMO POR TBM'
    else if strCodOco = 'IG' then Result := 'BENEFICIO ESTA EM FASE DE CONCESSÃO DE PA OU DESDOBRAMENTO'
    else if strCodOco = 'IH' then Result := 'BENEFICIO CESSADO POR ÓBITO'
    else if strCodOco = 'II' then Result := 'BENEFICIO CESSADO POR FRAUDE'
    else if strCodOco = 'IJ' then Result := 'BENEFICIO CESSADO POR COCESSÃO DE OUTRO BENEFICIO'
    else if strCodOco = 'IK' then Result := 'BENEFICIO CESSADO: ESTATUARIO TRANSFERIDO PARA ORGÃO DE ORIGEM'
    else if strCodOco = 'IL' then Result := 'EMPRESTIMO SUSPENSO PELA APS'
    else if strCodOco = 'IM' then Result := 'EMPRESTIMO CANCELADO PELO BANCO'
    else if strCodOco = 'IN' then Result := 'CREDITO TRANSFORMADO EM PAB'
    else if strCodOco = 'IO' then Result := 'TERMINO DE CONSIGNAÇÃO FOI ALTERADO'
    else if strCodOco = 'IP' then Result := 'FIM DO EMPRESTIMO OCORREU DURANTE O PERIODO DE SUSPENSÃO OU CONCESSÃO'
    else if strCodOco = 'IQ' then Result := 'EMPRESTIMO SUSPENSO PELO BANCO'
    else if strCodOco = 'IQ' then Result := 'EMPRESTIMO SUSPENSO PELO BANCO'
    else if strCodOco = 'TA' then Result := 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DifERENÇA'
    else if strCodOco = 'YA' then Result := 'TÍTULO NÃO ENCONTRADO'
    else if strCodOco = 'YB' then Result := 'IDENTifICADOR REGISTRO OPCIONAL INVÁLIDO'
    else if strCodOco = 'YC' then Result := 'CÓDIGO PADRÃO INVÁLIDO'
    else if strCodOco = 'YD' then Result := 'CÓDIGO DE OCORRÊNCIA INVÁLIDO'
    else if strCodOco = 'YE' then Result := 'COMPLEMENTO DE OCORRÊNCIA INVÁLIDO'
    else if strCodOco = 'YF' then Result := 'ALEGAÇÃO JÁ INFORMADA'
    else if strCodOco = 'ZA' then Result := 'AGÊNCIA / CONTA DO FAVORECIDO SUBSTITUÍDA'
    else if strCodOco = 'ZB' then Result := 'DIVERGÊNCIA ENTRE O PRIMEIRO E ÚLTIMO NOME DO BENEFICIÁRIO VERSUS PRIMEIRO E ÚLTIMO'
    else if strCodOco = 'ZC' then Result := 'CONFIRMAÇÃO DE ANTECIPAÇÃO DE VALOR'
    else if strCodOco = 'ZD' then Result := 'ANTECIPAÇÃO PARCIAL DE VALOR'
    else if strCodOco = 'ZE' then Result := 'TITULO BLOQUEADO NA BASE'
    else if strCodOco = 'ZF' then Result := 'SISTEMA EM CONTIGÊNCIA-TITULO VALOR MAIOR QUE REFERENCIA'
    else if strCodOco = 'ZG' then Result := 'SISTEMA EM CONTIGÊNCIA-TITULO VENCIDO'
    else if strCodOco = 'ZH' then Result := 'SISTEMA EM CONTIGÊNCIA-TITULO INDEXADO'
    else if strCodOco = 'ZI' then Result := 'BENEFICIARIO DIVERGENTE'
    else if strCodOco = 'ZJ' then Result := 'LIMITE DE PAGAMENTOS'
    else if strCodOco = 'ZK' then Result := 'BOLETO JA LIQUIDADO'
    else Result :=  'OUTRAS ';
  end
  else
  If (strCodBco = '246') Then // BANCO ABC BRASIL
  begin

         if strCodOco = '00' then Result := 'PAGAMENTO EFETUADO'
    else if strCodOco = '01' then Result := 'AGENDADO ENVIO PARA O SPF'
    else if strCodOco = '03' then Result := 'NOTA FISCAL OU BOLETO COM ERRO'
    else if strCodOco = 'AG' then Result := 'NÚMERO DO LOTE INVÁLIDO'
    else if strCodOco = 'AH' then Result := 'NÚMERO SEQUENCIAL DO REGISTRO NO LOTE INVÁLIDO'
    else if strCodOco = 'AI' then Result := 'PRODUTO DEMONSTRATIVO DE PAGAMENTO NÃO CONTRATADO'
    else if strCodOco = 'AL' then Result := 'CÓDIGO DO BANCO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'AM' then Result := 'AGÊNCIA DO FAVORECIDO INVÁLIDA'
    else if strCodOco = 'AO' then Result := 'NOME DO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'AP' then Result := 'DATA DE PAGAMENTO / DATA DE VALIDADE / HORA DE LANÇAMENTO / ARRECADAÇÃO / APURAÇÃO INVÁLIDA'
    else if strCodOco = 'BD' then Result := 'PAGAMENTO AGENDADO'
    else if strCodOco = 'BI' then Result := 'CNPJ / CPF DO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'CE' then Result := 'PAGAMENTO CANCELADO'
    else if strCodOco = 'CO' then Result := 'VALOR DE OUTROS ACRÉSCIMOS INVÁLIDO'
    else if strCodOco = 'DV' then Result := 'TED DEVOLVIDA PELO BANCO FAVORECIDO (*)'
    else if strCodOco = 'E7' then Result := 'DADOS INCOMPLETOS PARA PAGAMENTO'
    else if strCodOco = 'IB' then Result := 'VALOR DO DOCUMENTO INVÁLIDO'
    else if strCodOco = 'ID' then Result := 'VALOR DO DESCONTO INVÁLIDO'
    else if strCodOco = 'II' then Result := 'DATA DE VENCIMENTO INVÁLIDA'
    else if strCodOco = 'IP' then Result := 'DAC DO CÓDIGO DE BARRAS INVÁLIDO'
    else if strCodOco = 'JO' then Result := 'TIPO DE DOC/TED INVÁLIDO.'
    else if strCodOco = 'LR' then Result := 'PAGAMENTO NÃO EFETUADO, SALDO INSUFICIENTE'
    else if strCodOco = 'NR' then Result := 'OPERAÇÃO NÃO REALIZADA'
    else if strCodOco = 'RJ' then Result := 'REGISTRO REJEITADO'
    else if strCodOco = 'RR' then Result := 'VALORES INVÁLIDOS / PROBLEMAS OPERACIONAIS'
    else if strCodOco = 'RT' then Result := 'PAGAMENTO ENVIADO APÓS HORÁRIO ESTIPULADO'
    else if strCodOco = 'RY' then Result := 'FINALIDADE DA TED INVALIDA OU INEXISTENTE'
    else if strCodOco = 'SS' then Result := 'PAGAMENTO CANCELADO POR INSUFICIÊNCIA DE SALDO / LIMITE DIÁRIO DE PAGTO'
    else if strCodOco = 'TA' then Result := 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DIFERENÇA'
    else if strCodOco = 'ZN' then Result := 'NÚMERO MÁXIMO DE TEDC EXCEDIDA PARA PROCESSAMENTO INDIVIDUAL'
    else if strCodOco = 'ZO' then Result := 'REGISTRO REJEITADO NA CHECAGEM'
    else if strCodOco = 'ZP' then Result := 'TIPO DE PAGAMENTO NÃO ACEITO PELO BANCO'
    else if strCodOco = 'ZQ' then Result := 'TRANSAÇÃO INDISPONÍVEL PARA ESTA DATA/HORÁRIO'
    else if strCodOco = 'ZR' then Result := 'TÍTULO NÃO CONSISTIDO NA CIP'
    else if strCodOco = '34' then Result := 'CONTA CORRENTE DE DÉBITO BLOQUEADA'
    else if strCodOco = '42' then Result := 'CÓDIGO DE BARRAS INVÁLIDO (CÓDIGO DE BARRAS NÃO NUMÉRICO, ZERADO OU DAC INVÁLIDO)'
    else if strCodOco = '73' then Result := 'TÍTULO BLOQUEADO PELO CEDENTE'
    else if strCodOco = '74' then Result := 'TÍTULO INEXISTENTE'
    else if strCodOco = '75' then Result := 'CEDENTE INFORMADO INEXISTENTE'
    else if strCodOco = '76' then Result := 'CPF/CNPJ DO CREDOR DIVERGENTE/INVÁLIDO'
    else if strCodOco = '77' then Result := 'AGÊNCIA E/OU CONTA CORRENTE ENCERRADA'
    else if strCodOco = '90' then Result := 'TÍTULO REJEITADO POR DUPLICIDADE'
    else if strCodOco = '97' then Result := 'TÍTULO JÁ LIQUIDADO'
    else if strCodOco = 'AJ' then Result := 'TIPO DE MOVIMENTO INVÁLIDO'
    else if strCodOco = 'AR' then Result := 'VALOR DO LANÇAMENTO INVÁLIDO'
    else if strCodOco = 'AT' then Result := 'TIPO/NÚMERO DE INSCRIÇÃO DO FAVORECIDO INVÁLIDO'
    else if strCodOco = 'BA' then Result := 'CÓDIGO/NOME DA AGÊNCIA DEPOSITÁRIA NÃO INFORMADO'
    else if strCodOco = 'BM' then Result := 'IDENTIFICAÇÃO DO CONTRATO INVÁLIDA'
    else if strCodOco = 'BR' then Result := 'IDENTIFICADOR DE PAGAMENTO INVÁLIDO'
    else if strCodOco = 'CB' then Result := 'CÓDIGO DE BARRAS - CÓDIGO DA MOEDA INVÁLIDO'
    else if strCodOco = 'CD' then Result := 'CÓDIGO DE BARRAS - VALOR DO TÍTULO INVÁLIDO'
    else if strCodOco = 'CT' then Result := 'OUTROS ERROS'
    else if strCodOco = 'DH' then Result := 'VALOR LIQUIDO INFORMADO DIFERENTE DO CALCULADO'
    else if strCodOco = 'ES' then Result := 'NÃO PERMITIDO, VALOR ACIMA DO LIMITE'
    else if strCodOco = 'F0' then Result := 'BANCO FAVORECIDO FORA DA CLEARING'
    else if strCodOco = 'GK' then Result := 'TÍTULO EM CARTÓRIO OU PROTESTADO'
    else if strCodOco = 'H4' then Result := 'RETORNO DE CRÉDITO NÃO PAGO'
    else if strCodOco = 'IU' then Result := 'BLOQUEADO PELA VALIDAÇÃO DE TRIBUTOS'
    else if strCodOco = 'JI' then Result := 'TIPO DA CONTA INVÁLIDA PARA FINALIDADE'
    else if strCodOco = 'JN' then Result := 'TIPO DE DOCUMENTO INVÁLIDO'
    else if strCodOco = 'MU' then Result := 'BANCO/AGENCIA NÃO CADASTRADOS'
    else if strCodOco = 'RM' then Result := 'VALOR AUTORIZADO NÃO CONFERE PARA PAGAMENTO EM ATRASO'
    else if strCodOco = 'TI' then Result := 'TITULARIDADE INVÁLIDA'
    else if strCodOco = 'WH' then Result := 'CNPJ DO PAGADOR INVÁLIDO'
    else if strCodOco = 'XP' then Result := 'DEVOLUÇÃO DO SPB POR SITUAÇÃO ESPECIAL'
    else if strCodOco = 'Z7' then Result := 'AGÊNCIA OU CONTA DESTINATÁRIA DE CRÉDITO INVÁLIDA';

  End;

end;

function TfrmRelRetBcoCta.frxRetBcoCtaUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  //inherited;
   if MethodName = upperCase('fRetDescOco') then
      Result := fRetDescOco(Params[0]);
end;

procedure TfrmRelRetBcoCta.pGeraRelatorio(strCodBco: String);
  Var
    strSQL: String;
    strNomeBco : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  RET_CODOCO AS CODOCO, ';
  strSQL := strSQL + '  RET_NOSNUM AS NOSNUM, ';
  strSQL := strSQL + '  CONCAT(RET_NUMDUP,RET_PARCEL) AS NUMDUP, ';
  strSQL := strSQL + '  RET_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  RET_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  RET_DTAPAG AS DTAPAG, ';
  strSQL := strSQL + '  RET_VALPAG AS VALPAG, ';
  strSQL := strSQL + '  IFNULL(RET_VALJUR, 0) AS JURMOR, ';
  strSQL := strSQL + '  IFNULL(RET_VALDES, 0) AS DESCON, ';
  strSQL := strSQL + '  IFNULL(RET_OUTENT, 0) AS OUTENT, ';
  strSQL := strSQL + '  RET_VALDUP AS VALDUP, ';
  strSQL := strSQL + '  RET_VALDUP + IFNULL(RET_VALJUR, 0) + IFNULL(RET_OUTENT, 0) - IFNULL(RET_VALDES, 0) AS VALTOT, ';
  strSQL := strSQL + '  LEFT(CONCAT(RET_CODFOR, "-", FOR_NOMFOR), 24) AS CODFOR, ';
  strSQL := strSQL + '  CONCAT(RET_NOMARQ, " - ", RET_DTAARQ, " - ", RET_HORARQ) AS NOMARQ, ';
  strSQL := strSQL + '  FOR_C_E_P_ AS CEPFOR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RETCTP LEFT JOIN CADFOR ON FOR_CODFOR = RET_CODFOR ';
  strSQL := strSQL + 'WHERE ';

  If blnPGG Then
    strSQL := strSQL + '  RET_BCOPGG = RET_CODBCO AND '
  Else
    strSQL := strSQL + '  RET_BCOPGG IS NULL AND ';

  strSQL := strSQL + '  RET_CODBCO = :CODBCO AND ';

  If FBancoAPI Then
    strSQL := strSQL + '  RET_TIPLAY = "API" '
  Else
    strSQL := strSQL + '  RET_TIPLAY IS NULL ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  RET_NUMDUP, ';
  strSQL := strSQL + '  RET_PARCEL, ';
  strSQL := strSQL + '  RET_CODFOR, ';
  strSQL := strSQL + '  RET_CODEMP, ';
  strSQL := strSQL + '  RET_SERIE_, ';
  strSQL := strSQL + '  RET_NOSNUM  ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  RET_CODOCO, ';

  If (edtOrdem.Text = 'V') Then
    strSQL := strSQL + '  RET_DTAVEN  '
  Else
    strSQL := strSQL + '  RET_NUMDUP ';

  qryRetBcoCta.Close;
  qryRetBcoCta.SQL.Text := strSQL;
  qryRetBcoCta.ParamByName('CODBCO').AsString := strCodBco;
  qryRetBcoCta.Open;

  If Not qryRetBcoCta.IsEmpty Then
  Begin
    Try

      {**********************************}
      {* RETORNA O CODIGO DA OCORRENCIA *}
      {*******************************LB*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RET_CODOCO AS CODOCO, ';
      strSQL := strSQL + '  IFNULL(RET_MOTOCO,'''') AS MOTOCO, ';
      strSQL := strSQL + '  COUNT(RET_CODOCO) AS QTDDUP, ';
      strSQL := strSQL + '  SUM(RET_VALDUP) AS VALDUP ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  RETCTP ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  RET_CODBCO = :CODBCO AND ';

      If FBancoAPI Then
        strSQL := strSQL + '  RET_TIPLAY = "API" '
      Else
        strSQL := strSQL + '  RET_TIPLAY IS NULL ';

      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  RET_CODOCO ';
      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  RET_CODOCO ';

      qryRetBcoCtaOcorr.Close;
      qryRetBcoCtaOcorr.SQL.Text := strSQL;
      qryRetBcoCtaOcorr.ParamByName('CODBCO').AsString := strCodBco;
      qryRetBcoCtaOcorr.Open;

      {********************}
      {* CABEÇALHO DO QCK *}
      {*****************LB*}
      TfrxMemoView(frxRetBcoCta.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

      frxRetBcoCta.Script.Variables['NOMEMP']   := fRetNomeEmpresa;
      frxRetBcoCta.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
      frxRetBcoCta.Script.Variables['NOMEFORM'] := '[FrmRelRetBcoCta]';

      frxRetBcoCta.Script.Variables['NOMEREL']  := 'RELATORIO DE ARQUIVO DE RETORNO ';
      strNomeBco := '';

      If strCodBco = '001' Then
         strNomeBco := '001 - BANCO DO BRASIL '
      Else If strCodBco = '341' Then
         strNomeBco := '341 - ITAU '
      Else If strCodBco = '237' Then
         strNomeBco := '237 - BRADESCO '
      Else If strCodBco = '033' Then
         strNomeBco := '033 - SANTANDER '
      Else If strCodBco = '356' Then
         strNomeBco := '356 - BANCO REAL '
      Else If strCodBco = '389' Then
         strNomeBco := '389 - MERCANTIL '
      Else If strCodBco = '399' Then
         strNomeBco := '399 - HSBC '
      Else If strCodBco = '151' Then
         strNomeBco := '151 - NOSSA CAIXA NOSSO BANCO '
      Else If strCodBco = '104' Then
         strNomeBco := '104 - CAIXA ECONOMICA FEDERAL '
      Else If strCodBco = '741' Then
         strNomeBco := '741 - BANCO RIB PRETO '
      Else If strCodBco = '756' Then
         strNomeBco := '756 - BANCOOB '
      Else If strCodBco = '021' Then
         strNomeBco := '021 - BANESTES '
      Else If strCodBco = '041' Then
         strNomeBco := '041 - BANRISUL'
      Else If strCodBco = '246' Then
         strNomeBco := '246 - ABC BRASIL';

      frxRetBcoCta.Script.Variables['NOMEBCO'] := strNomeBco + IIF(FBancoAPI, ' [Online]', EmptyStr);

      If edtDados.Text = 'A' Then
      Begin
         frxRetBcoCta.FindObject('Memo3').Visible                 := False;
         frxRetBcoCta.FindObject('frxDBDataset1CEPFOR').Visible   := False;
         frxRetBcoCta.FindObject('frxDBDataset1CODFOR').Width     := 200;//5.45;
         TFrxMemoView(frxRetBcoCta.FindObject('Memo1')).Text      := 'ARQUIVO - DATA - HORA';
         TFrxMemoView(frxRetBcoCta.FindObject('frxDBDataset1CODFOR')).DataField := 'NOMARQ';
      End
      Else
      Begin
         frxRetBcoCta.FindObject('Memo3').Visible                 := True;
         frxRetBcoCta.FindObject('frxDBDataset1CEPFOR').Visible   := True;
         frxRetBcoCta.FindObject('frxDBDataset1CODFOR').Width     :=  151.181102362204700000;//5.45;
         TFrxMemoView(frxRetBcoCta.FindObject('Memo1')).Text      := 'CODIGO / NOME FORNECEDOR';
         TFrxMemoView(frxRetBcoCta.FindObject('frxDBDataset1CODFOR')).DataField := 'CODFOR';
      End;


      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxRetBcoCta)
      Else
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxRetBcoCta);

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&O K']);
      End;
    End;
  End
  Else
  Begin
    pTabelaVazia;
    pSetFocus(edtDestino);
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
end;

procedure TfrmRelRetBcoCta.edtDadosChange(Sender: TObject);
begin
  inherited;
  If Pos(edtDados.Text, 'AF') <= 0 Then
  Begin
    edtDados.Clear;
  End;
end;

procedure TfrmRelRetBcoCta.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtOrdem);
end;

procedure TfrmRelRetBcoCta.FormCreate(Sender: TObject);
var Grupo: string;
begin
  inherited;

   with frxRetBcoCta do
   begin
      Grupo := 'Minhas Funções';

      AddFunction('function fRetDescOco(strCodoco: String): String', Grupo,
                  'Retorna a descrição da ocorrência');
   end;

   FBancoAPI := False;

end;

end.

