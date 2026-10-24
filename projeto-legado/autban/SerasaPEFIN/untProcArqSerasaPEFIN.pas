unit untProcArqSerasaPEFIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, frxClass, DB, UniClientDataSet, frxDBSet, Uni, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Datasnap.DBClient, frxExportCSVTestabilidade, cxProgressBar;

type
  TfrmProcArqSerasaPEFIN = class(TfrmPai)
    Label1: TLabel;
    frxRelRetorno: TfrxReport;
    frxDBDatasetDetalhes: TfrxDBDataset;
    pnlTopo: TPanel;
    frxGen: TfrxUserDataSet;
    dbDetalhes: TUniClientDataSet;
    btnGerar: TBitBtnLocked;
    dbDetalhesNUMDUP: TStringField;
    dbDetalhesPARCEL: TStringField;
    dbDetalhesESPDOC: TStringField;
    dbDetalhesCODEMP: TStringField;
    dbDetalhesCLIENT: TStringField;
    dbDetalhesTABELA: TStringField;
    dbErros: TfrxDBDataset;
    cdsErros: TUniClientDataSet;
    cdsErrosDESERR: TStringField;
    edtArqRetorno: TFilenameEditFocus;
    dbDetalhesRETORNO: TStringField;
    procedure btnGerarClick(Sender: TObject);
    procedure frxDBCabecalhoGetValue(const VarName: String;
      var Value: Variant);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
  private
    { Private declarations }
    stlDupDel: TStringList;
    function  fRetDescriBaixaPefin(strCodBaixa: String): String;
    function  fRetErroPEFIN(strCodErr: String): String;
    procedure pBaixaDuplic(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strMotBai: String; fltValRec: Double);
    function fCriaClientDetalhes: TUniClientDataSet;
  public
    { Public declarations }
    function fProcessarArqRetorno(cxgProgresso: TcxProgressBar = nil): Boolean;
    function fConvertDataSemBarra(strData: String): String;
    function fNegritoResumo(strTexto: String): String;
    procedure pProcessaLinha(strLinha: String);
    function fConverDataSemBarra2(strData: String): String;
    function fConvertValor(strValor: String): String;
  end;

var
  frmProcArqSerasaPEFIN: TfrmProcArqSerasaPEFIN;

implementation

uses  untFuncoesSimples, StrUtils,  untCfgRel, untFuncoes, untGravando;

{$R *.dfm}

function TfrmProcArqSerasaPEFIN.fProcessarArqRetorno(cxgProgresso: TcxProgressBar): Boolean;
var
  mArquivo          : TextFile;
  strNomeArquivo    : String;

  strIndInf         : String;
  strIndRet         : String;
  strLinha          : String;
  strMensagem       : String;
  strErros          : WideString;
  strCodErr         : String;

  intAux            : Integer;
  intLinha          : Integer;
  intLinhas         : Integer;
begin
  Result := False;
  try
    stlDupDel := TStringList.Create;

    strNomeArquivo := AnsiReplaceStr(edtArqRetorno.Text, '"', '');
    AssignFile(mArquivo, strNomeArquivo);
    Reset(mArquivo);

    dbDetalhes := fCriaClientDetalhes;
    dbDetalhes.Open;
    cdsErros.EmptyDataSet;

    strMensagem := '';
    strErros    := '';
    strCodErr   := '';

    Readln(mArquivo, strLinha);

    if (Copy(strLinha, 126, 1) = 'R') or (Copy(strLinha, 126, 1) = 'I') then
    Begin
      Reset(mArquivo);

      strCodErr := Copy(strLinha, 534, 060);
      if Trim(strCodErr) <> '' then
      Begin
        With cdsErros Do
        Begin
          Append;
          cdsErrosDESERR.AsString := fRetErroPEFIN(strCodErr);
          Post;
        End;
      End;

      intLinha  := 0;
      intLinhas := fContaLinhasArq(strNomeArquivo);

      While (not Eof(mArquivo)) Do
      Begin

        Application.ProcessMessages;
        Readln(mArquivo, strLinha);

        pProgresso(fInc(intLinha), intLinhas -1, cxgProgresso);

        strIndInf := copy(strLinha, 1, 1);
        strIndRet := Copy(strLinha, 2, 1);

        If (strIndInf = '1') Then
          pProcessaLinha(strLinha)
        Else If not TryStrToInt(strIndInf, intAux) Then
        Begin
          fMensagem('', 'O arquivo está corrompido!', ['&OK']);
          Exit;
        End;
      End;

      If Not dbDetalhes.IsEmpty Then
      Begin

        frxDBDatasetDetalhes.DataSet := dbDetalhes;
        frxRelRetorno.Script.Variables['NOMREL'] := 'RELATÓRIO DE RETORNO DO SERASA (PEFIN)';

        pPreviewReport(Self.Name, 'Relatório de retorno do SERASA (PEFIN)', frxRelRetorno);

        fMensagem('','Arquivo importado com sucesso!', ['&Ok']);

        Result := True;
      End
      Else
        fMensagem('','Estrutura do arquivo não confere com o Layout PEFIN!', ['&Ok']);
    End
    Else
        fMensagem('','Arquivo Inválido! Só é possível processar arquivos de retorno ou informacional!', ['&Ok']);
  finally
    CloseFile(mArquivo);
    FreeAndNil(stlDupDel);
    FreeAndNil(dbDetalhes);
  end;
end;

function TfrmProcArqSerasaPEFIN.fRetDescriBaixaPefin(
  strCodBaixa: String): String;
begin
  if strCodBaixa = '00' then
    Result := 'Motivo Antes da Implantação(passado)'
  Else if strCodBaixa = '01' then
    Result := 'Pagamento da Dívida'
  Else if strCodBaixa = '02' then
    Result := 'Renegociação da Dívida'
  Else if strCodBaixa = '03' then
    Result := 'Por solicitação do Cliente'
  Else if strCodBaixa = '04' then
    Result := 'Ordem Judicial'
  Else if strCodBaixa = '05' then
    Result := 'Correção de Endereço'
  Else if strCodBaixa = '06' then
    Result := 'Atualização do Valor - Valorização'
  Else if strCodBaixa = '07' then
    Result := 'Atualização do Valor - Pagamento Parcial'
  Else if strCodBaixa = '08' then
    Result := 'Atualização de Data'
  Else if strCodBaixa = '09' then
    Result := 'Correção do Nome'
  Else if strCodBaixa = '10' then
    Result := 'Correção do Número do Contrato'
  Else if strCodBaixa = '11' then
    Result := 'Correção de Vários Dados'
  Else if strCodBaixa = '12' then
    Result := 'Baixa por Perda de Controle da Base'
  Else if strCodBaixa = '13' then
    Result := 'Motivo Não Identificado'
  Else if strCodBaixa = '14' then
    Result := 'Pontualização da Dívida'
  Else if strCodBaixa = '15' then
    Result := 'Baixa por Concessão de Crédito'
  Else if strCodBaixa = '16' then
    Result := 'Incorporação/Mudança de Titularidade'
  Else if strCodBaixa = '17' then
    Result := 'Comunicado Devolvido aos Correios'
  Else if strCodBaixa = '18' then
    Result := 'Correção de Dados  do Coobrigado/Avalista'
  Else if strCodBaixa = '19' then
    Result := 'Renegociação da Dívida por Acordo'
  Else if strCodBaixa = '20' then
    Result := 'Pagamento da Dívida por Depósito Bancário'
  Else if strCodBaixa = '21' then
    Result := 'Ánalise de Documentos'
  Else if strCodBaixa = '22' then
    Result := 'Correção de Dados pela Loja/Filial'
  Else if strCodBaixa = '23' then
    Result := 'Pgto da Dívida por Emissão de Nota Promissória'
  Else if strCodBaixa = '24' then
    Result := 'Análise de Documento por Seguro'
  Else if strCodBaixa = '25' then
    Result := 'Devolução ou Troca de Bem Financiado'
  Else if strCodBaixa = '88' then
    Result := 'Carta / Comprovante não Retornado dos Correios'
  Else if strCodBaixa = '89' then
    Result := 'Motivos Diversos'
  Else if strCodBaixa = '90' then
    Result := 'Falta de Documentação da Dívida'
  Else if strCodBaixa = '91' then
    Result := 'Contestação / Declaração do Interessado'
  Else if strCodBaixa = '92' then
    Result := 'Aditivo Contratual'
  Else if strCodBaixa = '93' then
    Result := 'Exclusão por Extinção do Contrato'
  Else if strCodBaixa = '94' then
    Result := 'Decurso de Prazo Especial'
  Else if strCodBaixa = '99' then
    Result := 'Motivo de Baixa não Informado'
  else
    Result := '';
end;

function TfrmProcArqSerasaPEFIN.fRetErroPEFIN(strCodErr: String): String;
  Var
    intCont   : Integer;

begin

  For intCont := 1 To Length(strCodErr) - 3 Do
  Begin
    If Copy(strCodErr, intCont, 3) = '001'      Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'ARQUIVO SEM DETALHES'
    Else If Copy(strCodErr, intCont, 3) = '002' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PRIMEIRO REGISTRO NAO E HEADER/SEQUENCIA DIFERENTE DE 1'
    Else If Copy(strCodErr, intCont, 3) = '003' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO DIFERENTE DE 0, 1 E 9'
    Else If Copy(strCodErr, intCont, 3) = '004' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO FORA DE SEQUENCIA'
    Else If Copy(strCodErr, intCont, 3) = '005' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO TRAILLER NAO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '008' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CODIGO DE OPERACAO DIFERENTE DE E, I'
    Else If Copy(strCodErr, intCont, 3) = '009' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA PRINCIPAL DIFERENTE DE F, J'
    Else If Copy(strCodErr, intCont, 3) = '010' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA COOBRIGADO DIFERENTE DE F, J'
    Else If Copy(strCodErr, intCont, 3) = '011' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOME INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '012' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOME NAO PODE SER BRANCOS'
    Else If Copy(strCodErr, intCont, 3) = '013' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DO HEADER INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '014' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DA OCORRENCIA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '016' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DA OCORRENCIA MAIOR QUE A ATUAL'
    Else If Copy(strCodErr, intCont, 3) = '017' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DA OCORRENCIA JA DECURSADA'
    Else If Copy(strCodErr, intCont, 3) = '018' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'IDENTIFICACAO DO ARQUIVO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '019' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REMESSA NAO POSTERIOR A ULTIMA'
    Else If Copy(strCodErr, intCont, 3) = '020' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REMESSA NAO NUMERICA OU IGUAL A ZERO'
    Else If Copy(strCodErr, intCont, 3) = '021' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CAMPO DE RECEBIMENTO DA REMESSA DIFERENTE DE E'
    Else If Copy(strCodErr, intCont, 3) = '022' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCLUSAO PARA REGISTRO INEXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '024' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CNPJ DO HEADER INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '025' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CNPJ NAO CADASTRADO NO SISTEMA (TABELA DE REMESSA)'
    Else If Copy(strCodErr, intCont, 3) = '026' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FILIAL DA INSTITUICAO NAO NUMERICA'
    Else If Copy(strCodErr, intCont, 3) = '027' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FILIAL DA INSTITUICAO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '028' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO PRINCIPAL NAO NUMERICO'
    Else If Copy(strCodErr, intCont, 3) = '029' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO PRINCIPAL INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '030' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO COOBRIGADO NAO NUMERICO'
    Else If Copy(strCodErr, intCont, 3) = '031' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO COOBRIGADO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '033' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TRAILLER FORA DE SEQUENCIA'
    Else If Copy(strCodErr, intCont, 3) = '034' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'SEQUENCIA NAO NUMERICA'
    Else If Copy(strCodErr, intCont, 3) = '035' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NATUREZA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '036' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NATUREZA INVALIDA PARA O CNPJ INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '037' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PRACA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '040' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REG. NAO ATUALIZADO. ERRO NO PRINCIPAL OU COOBRIGADO DA OCORRENCIA'
    Else If Copy(strCodErr, intCont, 3) = '044' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'AGENCIA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '047' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CONTA NAO NUMERICA'
    Else If Copy(strCodErr, intCont, 3) = '059' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO PARA REGISTRO JA EXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '064' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CONTA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '065' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CHEQUE INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '072' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'ALINEA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '081' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO APOS TRAILLER'
    Else If Copy(strCodErr, intCont, 3) = '085' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NUMERO DO CONTRATO/TITULO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '089' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EMPRESA NAO PARTICIPANTE DO CONVENIO'
    Else If Copy(strCodErr, intCont, 3) = '101' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DE NASCIMENTO EH OBRIGATORIA/INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '102' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NUMERO DO CONTRATO/TITULO EH OBRIGATORIO'
    Else If Copy(strCodErr, intCont, 3) = '103' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE DOCUMENTO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '105' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO BLOQUEADA FACE A DETERMINACAO ADMINISTRATIVA'
    Else If Copy(strCodErr, intCont, 3) = '106' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'MOVIMENTO APOS RESCISAO DE CONTRATO DO CONVENIO'
    Else If Copy(strCodErr, intCont, 3) = '109' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA ENDERECO'
    Else If Copy(strCodErr, intCont, 3) = '111' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA UF DO ENDERECO'
    Else If Copy(strCodErr, intCont, 3) = '112' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA CEP DO ENDERECO'
    Else If Copy(strCodErr, intCont, 3) = '113' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA INFORMACAO TIPO DE PESSOA'
    Else If Copy(strCodErr, intCont, 3) = '115' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA DO PRINCIPAL DIFERENTE DE F'
    Else If Copy(strCodErr, intCont, 3) = '116' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA DO COOBRIGADO DIFERENTE DE F'
    Else If Copy(strCodErr, intCont, 3) = '119' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CEP DO ENDERECO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '121' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DE NASCIMENTO INFERIOR A 18 ANOS'
    Else If Copy(strCodErr, intCont, 3) = '142' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'BANCO NAO TRABALHA COM CONTA CORRENTE'
    Else If Copy(strCodErr, intCont, 3) = '156' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA OCORRENCIA INFERIOR A 4 DIAS'
    Else If Copy(strCodErr, intCont, 3) = '165' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DT.TERMINO DO CONTRATO ANTERIOR A DT. DA OCORRENCIA'
    Else If Copy(strCodErr, intCont, 3) = '166' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DE TERMINO DO CONTRATO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '167' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA UF DO RG'
    Else If Copy(strCodErr, intCont, 3) = '168' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DEVE SER NUMERICO E MAIOR QUE ZEROS'
    Else If Copy(strCodErr, intCont, 3) = '169' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'AREA INFORMANTE DA REMESSA C/ ERRO. MOVIMENTO REJEITADO'
    Else If Copy(strCodErr, intCont, 3) = '170' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'BANCO INVAL. P/ NATUREZA DE/DC'
    Else If Copy(strCodErr, intCont, 3) = '171' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA DO CREDOR DIFERENTE DE F, J'
    Else If Copy(strCodErr, intCont, 3) = '172' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE DOCUMENTO DO CREDOR INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '173' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO CREDOR NAO NUMERICO'
    Else If Copy(strCodErr, intCont, 3) = '174' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO CREDOR INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '175' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOME DO CREDOR EH OBRIGATORIO'
    Else If Copy(strCodErr, intCont, 3) = '176' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOME DO CREDOR INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '177' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FOI INFORMADO O CREDOR. PARTICIPANTE NAO EH ENTIDADE DE CLASSE'
    Else If Copy(strCodErr, intCont, 3) = '181' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. MUDOU-SE'
    Else If Copy(strCodErr, intCont, 3) = '182' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. ENDERECO INSUFICIENT'
    Else If Copy(strCodErr, intCont, 3) = '183' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. NUMERO INEXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '184' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. DESCONHECIDO'
    Else If Copy(strCodErr, intCont, 3) = '185' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. RECUSADO'
    Else If Copy(strCodErr, intCont, 3) = '186' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. NAO PROCURADO'
    Else If Copy(strCodErr, intCont, 3) = '187' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. AUSENTE'
    Else If Copy(strCodErr, intCont, 3) = '188' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. FALECIDO'
    Else If Copy(strCodErr, intCont, 3) = '189' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL.DEVIDO DEVOL.COMUNICADO PELO CORREIO.INFOR.PORTEIRO/SINDICO'
    Else If Copy(strCodErr, intCont, 3) = '190' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. ENDERECO DESCONHECIDO'
    Else If Copy(strCodErr, intCont, 3) = '191' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. CEP INCORRETO'
    Else If Copy(strCodErr, intCont, 3) = '192' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. NAO ESPECIFICADO'
    Else If Copy(strCodErr, intCont, 3) = '193' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. CX POSTAL INEXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '194' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO. IMOVEL INEXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '195' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCL. DEVIDO DEVOL. COMUNICADO PELO CORREIO'
    Else If Copy(strCodErr, intCont, 3) = '196' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO RECUSADA/CARTA DEVOLVIDA DO CORREIO/END.IGUAL AO ANTERIOR'
    Else If Copy(strCodErr, intCont, 3) = '197' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'ENDERECO ALTERNATIVO SOLICITADO PELA CONTRATANTE'
    Else If Copy(strCodErr, intCont, 3) = '219' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DO TITULO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '263' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'IDENTIFICACAO DO ARQUIVO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '274' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CNPJ NAO EXISTE NO CADASTRO DE CNPJ/CPF ATE ESTA DAT'
    Else If Copy(strCodErr, intCont, 3) = '275' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CPF NAO EXISTE NO CADASTRO DE CNPJ/CPF ATE ESTA DATA'
    Else If Copy(strCodErr, intCont, 3) = '276' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FILIAL NAO EXISTE NO CADASTRO DE CNPJ/CPF ATE ESTA DATA'
    Else If Copy(strCodErr, intCont, 3) = '277' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CNPJ CREDOR/CEDENTE NAO EXISTE NO CADASTRO DE CNPJ/CPF ATE ESTA DATA'
    Else If Copy(strCodErr, intCont, 3) = '278' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CPF CREDOR/CEDENTE NAO EXISTE NO CADASTRO DE CNPJ/CPF ATE ESTA DATA'
    Else If Copy(strCodErr, intCont, 3) = '279' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FILIAL CREDOR/CEDENTE NAO EXISTE CADASTRO DE CNPJ/CPF ATE ESTA DATA'
    Else If Copy(strCodErr, intCont, 3) = '286' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO CREDOR IGUAL AO DO NEGATIVADO'
    Else If Copy(strCodErr, intCont, 3) = '289' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INFORMADO A UF SEM O NUMERO DO RG'
    Else If Copy(strCodErr, intCont, 3) = '290' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCLUSAO POR DATA DE OCORRENCIA JA DECURSADA'
    Else If Copy(strCodErr, intCont, 3) = '291' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCLUSAO POR DETERMINACAO JUDICIAL'
    Else If Copy(strCodErr, intCont, 3) = '292' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCLUSAO POR SOLICITACAO DA EMPRESA PARTICIPANTE'
    Else If Copy(strCodErr, intCont, 3) = '295' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'RAZAO SOCIAL NAO CORRESPONDE AO CNPJ INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '296' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOME NAO CORRESPONDE AO CPF INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '298' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'COOBRIGADO NAO INCLUIDO - PRINCIPAL NAO ENCONTRADO'
    Else If Copy(strCodErr, intCont, 3) = '301' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - MUDOU-SE'
    Else If Copy(strCodErr, intCont, 3) = '302' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - END INSUFICIENTE'
    Else If Copy(strCodErr, intCont, 3) = '303' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - NR INEXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '304' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - DESCONHECIDO'
    Else If Copy(strCodErr, intCont, 3) = '305' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - RECUSADO'
    Else If Copy(strCodErr, intCont, 3) = '306' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - NAO PROCURADO'
    Else If Copy(strCodErr, intCont, 3) = '307' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - AUSENTE'
    Else If Copy(strCodErr, intCont, 3) = '308' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - FALECIDO'
    Else If Copy(strCodErr, intCont, 3) = '309' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO CORREIO - INFORM P/ PORTEIRO'
    Else If Copy(strCodErr, intCont, 3) = '310' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - END N CONHECIDO'
    Else If Copy(strCodErr, intCont, 3) = '311' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - CEP INCORRETO'
    Else If Copy(strCodErr, intCont, 3) = '312' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO DO CORREIO - N ESPECIFICADO'
    Else If Copy(strCodErr, intCont, 3) = '313' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO CORREIO - CX POSTAL INEXIST'
    Else If Copy(strCodErr, intCont, 3) = '314' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO ESPECIAL - DEVOLUCAO COMUNICADO CORREIO - IMOVEL INEXISTENTE'
    Else If Copy(strCodErr, intCont, 3) = '315' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DEVIDO A DEVOLUCAO DO COMUNICADO DO CORREIO'
    Else If Copy(strCodErr, intCont, 3) = '356' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DO COMPROMISSO MAIOR QUE A ATUAL'
    Else If Copy(strCodErr, intCont, 3) = '357' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DO COMPROMISSO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '358' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DO COMPROMISSO NAO NUMERICO'
    Else If Copy(strCodErr, intCont, 3) = '359' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DDD DEVE SER NUMERICO'
    Else If Copy(strCodErr, intCont, 3) = '360' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TELEFONE DEVE SER NUMERICO'
    Else If Copy(strCodErr, intCont, 3) = '381' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO REJEITADA - VLR CONSID.ELEVADO - INCLUIR PELO SISCONVEM'
    Else If Copy(strCodErr, intCont, 3) = '390' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO RECUSADA - PARTICIPANTE COM LOGON BLOQUEADO'
    Else If Copy(strCodErr, intCont, 3) = '391' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REGISTRO REJEITADO - INCONSISTENCIA NO HEADER'
    Else If Copy(strCodErr, intCont, 3) = '392' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA CODIGO CLIENTE NA REMESSA OU CODIGO NAO TEM 5 CARACTERE'
    Else If Copy(strCodErr, intCont, 3) = '393' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTA PROCNAME NA RSREMESS OU PROCNAME NAO TEM 8 CARACTERS'
    Else If Copy(strCodErr, intCont, 3) = '394' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CNPJ NAO CORRESPONDE AO CODIGO DE CLIENTE INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '396' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO REJEITADA-VLR.CONS.ELEVADO-NEGAT.PRIMARIA-INCL.SISCONVEM'
    Else If Copy(strCodErr, intCont, 3) = '397' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VLR CONSID ELEVADO-NEGAT PRIMARIA-REDIGITAR O VALOR'
    Else If Copy(strCodErr, intCont, 3) = '429' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PROCNAME (REMESSA) INVALIDO - TAMANHO DO REGISTRO ERRADO'
    Else If Copy(strCodErr, intCont, 3) = '430' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PROCNAME (REMESSA) INVALIDO - TIPO DE TRANSMISSAO ERRADO'
    Else If Copy(strCodErr, intCont, 3) = '443' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCLUSAO POR CONTESTACAO/DECLARACAO DO INTERESSADO'
    Else If Copy(strCodErr, intCont, 3) = '465' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DO CANCELAMENTO DO CONTRATO NAO INFORMADA'
    Else If Copy(strCodErr, intCont, 3) = '466' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXCLUSAO POR FALTA DE DOCUMENTACAO DA DIVIDA'
    Else If Copy(strCodErr, intCont, 3) = '488' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PARTICIPANTE NAO POSSUI PROCURACAO DO CREDOR'
    Else If Copy(strCodErr, intCont, 3) = '489' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'UF DO RG INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '490' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'FALTAM DADOS CADASTRAIS DO CREDOR DA DIVIDA'
    Else If Copy(strCodErr, intCont, 3) = '491' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'MUNICIPIO NAO CORRESPONDE AO CEP E/OU UF INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '495' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PRO-REDE - NAO LOCALIZADO O ENDERECO DO CREDOR'
    Else If Copy(strCodErr, intCont, 3) = '609' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + ' EXCLUSAO - CARTA COMUNICADO/COMPROVANTE NAO RETORNOU DOS CORREIOS'
    Else If Copy(strCodErr, intCont, 3) = '610' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + ' INCLUSAO CONDICIONADA A APRESENTACAO DE DOCTO DA DIVIDA'
    Else If Copy(strCodErr, intCont, 3) = '611' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + ' LOGON INFORMADO NO HEADER NAO PERTENCE AO PARTICIPANTE'
    Else If Copy(strCodErr, intCont, 3) = '612' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + ' LOGON INFORMADO NO HEADER NAO ENCONTRADO'
    Else If Copy(strCodErr, intCont, 3) = '620' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'SCORE NAO CALCULADO POR SOLICITACAO DO CLIENTE, ANOTACAO NAO INCLUIDA'
    Else If Copy(strCodErr, intCont, 3) = '621' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'SCORE ACIMA DO PERMITIDO, ANOTACAO NAO INCLUIDA'
    Else If Copy(strCodErr, intCont, 3) = '650' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CODIGO DO BANCO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '651' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'BANCO NÃO CADASTRADO'
    Else If Copy(strCodErr, intCont, 3) = '652' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DIGITO DO CODIGO DO BANCO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '653' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOME DO BANCO NÃO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '654' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CARACTERES DA LINHA DIGITAVEL INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '655' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PRIMEIRO DIGITO DA LINHA DIGITAVEL DIVERGENTE'
    Else If Copy(strCodErr, intCont, 3) = '656' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'SEGUNDO DIGITO DA LINHA DIGITAVEL DIVERGENTE'
    Else If Copy(strCodErr, intCont, 3) = '657' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TERCEIRO DIGITO DA LINHA DIGITAVEL DIVERGENTE'
    Else If Copy(strCodErr, intCont, 3) = '658' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'QUARTO DIGITO DA LINHA DIGITAVEL DIVERGENTE'
    Else If Copy(strCodErr, intCont, 3) = '659' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TEXTO DO LOCAL DE PAGAMENTO NÃO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '660' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DE VENCIMENTO DO BOLETO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '661' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DE VENCIMENTO DO BOLETO MENOR QUE A DATA DE HOJE'
    Else If Copy(strCodErr, intCont, 3) = '662' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA DO DOCUMENTO DO CEDENTE INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '663' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE DOCUMENTO  DO CEDENTE DIVERGENTE DO TIPO DE PESSOA'
    Else If Copy(strCodErr, intCont, 3) = '664' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO CEDENTE INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '665' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DIGITO DO DOCUMENTO DO CEDENTE INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '666' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'AGENCIA E CODIGO DO CEDENTE NÃO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '667' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DO DOCUMENTO INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '668' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NUMERO DO DOCUMENTO NÃO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '669' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DATA DO PROCESSAMENTO INFORMADA E INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '670' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'NOSSO NUMERO NÃO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '671' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'QUANTIDADE DE MOEDA NÃO INFORMADA'
    Else If Copy(strCodErr, intCont, 3) = '672' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'QUANTIDADE DE MOEDA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '673' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'QUANTIDADE DE DECIMAIS DA MOEDA NÃO INFORMADA'
    Else If Copy(strCodErr, intCont, 3) = '674' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'QUANTIDADE DE DECIMAIS DA MOEDA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '675' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'QUANTIDADE DE DECIMAIS DA MOESA MAIOR QUE 5 CASAS DECIMAIS'
    Else If Copy(strCodErr, intCont, 3) = '676' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DA MOEDA NÃO INFORMADO'
    Else If Copy(strCodErr, intCont, 3) = '677' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DA MOEDA INVALIDA'
    Else If Copy(strCodErr, intCont, 3) = '678' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DO DOCUMENTO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '679' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DE OUTROS ACRESCIMOS INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '680' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DE DESCONTOS/ABATIMENTO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '681' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DE OUTRAS DEDUCOES INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '682' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR DE MORA/MULTA INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '683' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'VALOR COBRADO INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '684' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE PESSOA DO DOCUMENTO DO SACADOR INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '685' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE DOCUMENTO  DO SACADOR DIVERGENTE DO TIPO DE PESSOA'
    Else If Copy(strCodErr, intCont, 3) = '686' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DOCUMENTO DO SACADOR INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '687' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'DIGITO DO DOCUMENTO DO SACADOR INVALIDO'
    Else If Copy(strCodErr, intCont, 3) = '701' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'EXISTE DADOS DE BOLETO E NAO INFORMADO O INDICATIVO DE TIPO DE COMUNICADO'
    Else If Copy(strCodErr, intCont, 3) = '702' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INDICATIVO DE TIPO DE COMUNICADO DIFERENTE DE BRANCO OU B'
    Else If Copy(strCodErr, intCont, 3) = '703' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE COMUNICADO COMO BOLETO E NÃO FOI INFORMADO O REG. TP 2 E/OU 3'
    Else If Copy(strCodErr, intCont, 3) = '704' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'TIPO DE COMUNICADO BOLETO NÃO PERMITIDO PARA COOBRIGADO'
    Else If Copy(strCodErr, intCont, 3) = '705' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REG BOLETO TIPO 2 ENCONTRADO, SEM REGISTRO TIPO 1 CORRESPONDENTE'
    Else If Copy(strCodErr, intCont, 3) = '706' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'REG BOLETO TIPO 3 ENCONTRADO, SEM REGISTRO TIPO 1 CORRESPONDENTE'
    Else If Copy(strCodErr, intCont, 3) = '707' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PARTICIPANTE NAO POSSUI CONTRATO PARA EMISSAO DE COMUNICADO COM BOLETO'
    Else If Copy(strCodErr, intCont, 3) = '710' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CNPJ/TRANSACAO COM PROBLEMA'
    Else If Copy(strCodErr, intCont, 3) = '711' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'INCLUSAO NAO PERMITIDA DOCUMENTO DO DEVEDOR IGUAL DO CREDOR'
    Else If Copy(strCodErr, intCont, 3) = '719' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'CADASTRAMENTO DE CREDOR NAO AUTORIZADO PARA CONVEM DEVEDORES'
    Else If Copy(strCodErr, intCont, 3) = '720' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'PARTICIPANTE INFORMADO INVALIDO, ESTA CADASTRADO COMO CREDOR'
    Else If Copy(strCodErr, intCont, 3) = '721' Then	 Result := Result + IIF(Result.IsEmpty, '', sLineBreak) + 'ENDERECO DO CEDENTE NAO CADASTRADO';
  End;

end;

procedure TfrmProcArqSerasaPEFIN.btnGerarClick(Sender: TObject);
  Var
    frmProcessando: TfrmGravando;
begin
  inherited;
  If fEmptyStr(edtArqRetorno.Text) Then
    fMensagem(Application.Title, 'Informe o arquivo a ser processado!', ['OK'])
  Else
  Begin
    btnGerar.Enabled := False;
    btnSair.Enabled  := False;
    edtArqRetorno.Enabled := False;

    TfrmGravando.fExecuta(fProcessarArqRetorno, frmProcessando, 'Processando...');

    edtArqRetorno.Enabled := True;
    btnSair.Enabled  := True;
    btnGerar.Enabled := True;
  End;
end;


procedure TfrmProcArqSerasaPEFIN.frxDBCabecalhoGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;
  If VarName = 'DTAINI' Then
  Begin
    Value := VS_Date;
  End;
end;

{****************************************}
{* Converte de ddmmyyyy para dd/mm/yyyy *}
{*************************************PH*}
function TfrmProcArqSerasaPEFIN.fConvertDataSemBarra(strData: String): String;
begin
  Result := '';
  Result := Result + Copy(strData, 0, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 3, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 5, 4);
end;

function TfrmProcArqSerasaPEFIN.fNegritoResumo(strTexto: String): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + '<B>';
  intCont := Pos(':', strTexto);
  Result := Result + Copy(strTexto, 0, intCont) + '</B>' + Copy(strTexto, intCont + 1, Length(strTexto));
end;

procedure TfrmProcArqSerasaPEFIN.pBaixaDuplic(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strMotBai: String; fltValRec: Double);
  Var
    qryCadRec : TUniQuery;
    strSQL    : String;
begin

  qryCadRec := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   CTR_MOTBAI = :MOTBAI, ';
  strSQL := strSQL + '   CTR_DTAREC = :DTAREC, ';
  strSQL := strSQL + '   CTR_VALREC = :VALREC, ';
  strSQL := strSQL + '   CTR_VALDUP = 0        ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP ';
  strSQL := strSQL + '   AND CTR_PARCEL = :PARCEL ';
  strSQL := strSQL + '   AND CTR_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + '   AND CTR_CODEMP = :CODEMP ';

  With qryCadRec Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('MOTBAI').AsString  := strMotBai;
    ParamByName('DTAREC').AsDateTime:= VS_Date;
    ParamByName('VALREC').AsFloat   := fltValRec;
    ParamByName('NUMDUP').AsString  := strNumDup;
    ParamByName('PARCEL').AsString  := strParcel;
    ParamByName('ESPDOC').AsString  := strEspDoc;
    ParamByName('CODCLI').AsString  := strCodCli;
    ParamByName('CODEMP').AsString  := strCodEmp;

    ExecSQL;
  End;

end;

procedure TfrmProcArqSerasaPEFIN.pProcessaLinha(strLinha: String);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    strMotBai: String;
    strCodErr: String;
    strAutInc: String;
    strValRec: String;
    fltValRec: Double;

begin
  qryGen := fCriaQuery;
  qryGen.Close;

  strMotBai := Copy(strLinha, 049, 002);
  strCodErr := Copy(strLinha, 534, 060);
  strAutInc := Copy(strLinha, 439, 016);
  Insert('0', strAutInc, 15);
//  strAutInc := LeftStr(strAutInc, 14) + '0' + RightStr(strAutInc, 02);
  strValRec := Copy(strLinha, 510, 015);
  Insert(',', strValRec, 13);
  fltValRec := fStrToFloat(strValRec);



  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '	CTR_NUMDUP, ';
  strSQL := strSQL + '	CTR_PARCEL, ';
  strSQL := strSQL + '	CTR_ESPDOC, ';
  strSQL := strSQL + '	CTR_CODCLI, ';
  strSQL := strSQL + '	CTR_CODEMP, ';
  strSQL := strSQL + '  CLI_NOMCLI  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '	CADREC ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '	RIGHT(AUTOINCREM, 17) = :AUTINC ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('AUTINC').AsString := strAutInc;
  qryGen.Open;

  dbDetalhes.Insert;

  If qryGen.IsEmpty Then
  Begin
    dbDetalhes.FieldByName('CLIENT').AsString := '';
    dbDetalhes.FieldByName('NUMDUP').AsString := 'DUPLICATA NÃO ENCONTRADA, AUTOINCREM: ' + strAutInc;
    dbDetalhes.FieldByName('ESPDOC').AsString := '';
    dbDetalhes.FieldByName('PARCEL').AsString := '';
    dbDetalhes.FieldByName('CODEMP').AsString := '';
    dbDetalhes.FieldByName('TABELA').AsString := '';
  End
  Else
  Begin

    If (Not fEmptyStr(strMotBai)) And (fEmptyStr(strCodErr)) Then
    Begin

      pBaixaDuplic(qryGen.FieldByName('CTR_NUMDUP').AsString,
                   qryGen.FieldByName('CTR_PARCEL').AsString,
                   qryGen.FieldByName('CTR_ESPDOC').AsString,
                   qryGen.FieldByName('CTR_CODEMP').AsString,
                   qryGen.FieldByName('CTR_CODCLI').AsString,
                   strMotBai,
                   fltValRec);

      dbDetalhes.FieldByName('NUMDUP').AsString := qryGen.FieldByName('CTR_NUMDUP').AsString;
      dbDetalhes.FieldByName('ESPDOC').AsString := qryGen.FieldByName('CTR_ESPDOC').AsString;
      dbDetalhes.FieldByName('PARCEL').AsString := qryGen.FieldByName('CTR_PARCEL').AsString;
      dbDetalhes.FieldByName('CODEMP').AsString := qryGen.FieldByName('CTR_CODEMP').AsString;
      dbDetalhes.FieldByName('CLIENT').AsString := qryGen.FieldByName('CTR_CODCLI').AsString + ' - ' + qryGen.FieldByName('CLI_NOMCLI').AsString;
      dbDetalhes.FieldByName('TABELA').AsString := 'CADREC';
      dbDetalhes.FieldByName('RETORNO').AsString := strMotBai + ' - ' + Trim(fRetDescriBaixaPefin(strMotBai));
    End;

    If (Not fEmptyStr(strCodErr))  Then
    Begin
      dbDetalhes.FieldByName('NUMDUP').AsString := qryGen.FieldByName('CTR_NUMDUP').AsString;
      dbDetalhes.FieldByName('ESPDOC').AsString := qryGen.FieldByName('CTR_ESPDOC').AsString;
      dbDetalhes.FieldByName('PARCEL').AsString := qryGen.FieldByName('CTR_PARCEL').AsString;
      dbDetalhes.FieldByName('CODEMP').AsString := qryGen.FieldByName('CTR_CODEMP').AsString;
      dbDetalhes.FieldByName('CLIENT').AsString := qryGen.FieldByName('CTR_CODCLI').AsString + ' - ' + qryGen.FieldByName('CLI_NOMCLI').AsString;
      dbDetalhes.FieldByName('TABELA').AsString := 'CADREC';
      dbDetalhes.FieldByName('RETORNO').AsString :=  'ERRO(S): ' + fRetErroPEFIN(strCodErr);
    End;

  End;

  dbDetalhes.Post;

  FreeAndNil(qryGen);

end;


{****************************************}
{* Converte de yyyymmdd para dd/mm/yyyy *}
{*************************************PH*}
function TfrmProcArqSerasaPEFIN.fConverDataSemBarra2(strData: String): String;
begin
  Result := '';
  Result := Result + Copy(strData, 7, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 5, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 0, 4);
end;
{********************************}
{* CONVERTE O VALOR FORNECIDO   *}
{* NO ARQUIVO PARA UMVALOR REAL *}
{* COM 2 CASAS DECIMAIS         *}
{*****************************PH*}
function TfrmProcArqSerasaPEFIN.fConvertValor(strValor: String): String;
  Var
    fltValor: Double;
begin
  fltValor := fStrToFloat(strValor) / 100;
  Result := FloatToStr(fltValor);
end;

function TfrmProcArqSerasaPEFIN.fCriaClientDetalhes: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDUP';
    DataType := ftString;
    Size := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PARCEL';
    DataType := ftString;
    Size := 1;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPDOC';
    DataType := ftString;
    Size := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

    With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLIENT';
    DataType := ftString;
    Size := 100;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TABELA';
    DataType := ftString;
    Size := 10;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RETORNO';
    DataType := ftString;
    Size := 300;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ERRO';
    DataType := ftBoolean;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR';
    DataType := ftCurrency;
    Precision := 15;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SITUACAO';
    DataType := ftString;
    Size := 100;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OPERACAO';
    DataType := ftString;
    Size := 100;
  End;

  Result.CreateDataSet;
  Result.Open;

  pSetaClient(Result);

  Result.IndexFieldNames := 'NUMDUP';
end;

procedure TfrmProcArqSerasaPEFIN.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp) + #10

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name + #10;
end;

end.
