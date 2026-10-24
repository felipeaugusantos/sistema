unit untImportCadFreteTranspCidadeFaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons, cxProgressBar, untTValidaExcel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, ComObj,
  untImportCadFreteTranspCidadeFaixaConfirma, Data.DB, Uni, System.StrUtils;

type
  TFrmImportCadFreteTranspCidadeFaixa = class(TfrmPai)
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnGravar: TBitBtnLocked;
    btnCancelaValidacao: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaValidacaoClick(Sender: TObject);
  private
    Excel          : Variant;
    intSequencial  : Integer;
    blnArqCsv      : Boolean;
    objValidaExcel : TValidadorExcel;
    FSeqFre        : String;
    FValFtI,
    FValFtF,
    FValDtF        : Double;

    function AbreExcel(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma): Boolean;
    procedure pInsereItensCDS(intLinha: integer; FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma);
    procedure pFormataCampos(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma);
    procedure pCriarDataSet(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma);
    Procedure pPreparaValidador;
    procedure pAtualizaInfoValidador;
    procedure pValidaCampoVazio(strInfo: Variant);
    procedure pValidaTrueFalse(blnCampoEmBranco: Boolean);

    function  fTemTitulo: boolean;
    function fConvetVazioToNull(texto: string): Variant;
    function fFaixaFaturamentoEncontradaNoBanco(strCodTran, strCodCid: String;
      dblFatIni, dblFatFin: Double): Boolean;


    { Private declarations }
  public
    { Public declarations }
  end;

const

  cQtdColunas = 14;

  cCodTra = 'A';  // Código da transportadora
  cCodCid = 'C';  // Código da cidade
  cValNFI = 'D';  // Valor da nota para isenção
  cValFrt = 'E';  // Valor mínimo do frete
  cPrcNta = 'F';  // Percentual sobre o valor da nota
  cValKgr = 'G';  // Valor por Kilo
  cValPed = 'H';  // Valor do pegágio a cada 100KG
  cPrcGri = 'I';  // Percentual do GRIS
  cValMGr = 'J';  // Valor mínimo do GRIS
  cValTas = 'K';  // Valor da TAS
  cValFtI = 'L';  // Faturamento Inicial
  cValFtF = 'M';  // Faturamento Final
  cValDtF = 'N';  // Desconto sobre o Frete (%)

  cDesCodTra = 'Cod. Transportadora';  // Código da transportadora
  cDesCodCid = 'Cod. Cidade';  // Código da cidade
  cDesValNFI = 'Valor da Nota para Isenção';  // Valor da nota para isenção
  cDesValFrt = 'Valor do Frete';  // Valor mínimo do frete
  cDesPrcNta = 'Percentual da Nota';  // Percentual sobre o valor da nota
  cDesValKgr = 'Valor por Kilo';  // Valor por Kilo
  cDesValPed = 'Valor do Pedágio';  // Valor do pegágio a cada 100KG
  cDesPrcGri = 'Percentual do GRIS';  // Percentual do GRIS
  cDesValMGr = 'Valor Minimo do GRIS';  // Valor mínimo do GRIS
  cDesValTas = 'Valor da Tas';  // Valor da TAS
  cDesValFtI = 'Faturamento Inicial';  // Faturamento Inicial
  cDesValFtF = 'Faturamento Final';  // Faturamento Final
  cDesValDtF = 'Desconto sobre o Frete(%)';  // Desconto sobre o Frete (%)


implementation

uses untFuncoesSimples;

{$R *.dfm}

function TFrmImportCadFreteTranspCidadeFaixa.AbreExcel(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma): Boolean;
Var
  intValIni, intContador : Integer;
begin
  Result:= True;
  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Arquivo Excel...';

  objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCodTra, '');

  If fMensagem('Atenção', 'Deseja validar os dados contidos no arquivo informado', ['&Sim', '&Não']) = 1 Then
  Begin
    Try
      pPreparaValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;
      btnCancelaValidacao.Visible := True;
      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
      Begin
        Result:= False;
        Exit;
      End;
    Finally
      btnGravar.Enabled := False;
      btnCancelaValidacao.Visible := False;
    End;
  End;

  blnArqCsv := UpperCase(ExtractFileExt(objValidaExcel.NomeArquivo)) = '.CSV';

  Try
    pValidaTrueFalse(blnArqCsv);
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible       := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(edtPath.Text);

    Excel.Selection.SpecialCells(cQtdColunas).Select;

    pgbGeral.Properties.Max := Excel.ActiveCell.Row -1;

  Except
    on E: Exception do
    Begin
      pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;
    End;
  End;

  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Cadastro de Faixas de Faturamento x Desconto...';

  Mouse.SettingChanged(10);
  pgbGeral.Visible := True;
  Application.ProcessMessages;
  pnlInfo.Caption       := 'Aguarde... Importando Tabela Cadastro de Faixas de Faturamento x Desconto...';

  pCriarDataSet(FImportaFaixa);
  pFormataCampos(FImportaFaixa);

  intValIni := IIf(fTemTitulo, 1 , 0);
  intSequencial := 1;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    If blnArqCsv Then
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;
    pInsereItensCDS(intContador, FImportaFaixa);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
    inc(intSequencial);
  End;

  pnlInfo.Caption       := 'Informações Carregadas...';
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.btnCancelaValidacaoClick(
  Sender: TObject);
begin
  inherited;
  objValidaExcel.blnCancela := True;
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.btnGravarClick(Sender: TObject);
var
  frmImportConfirma: TfrmImportCadFreteTranspCidadeFaixaConfirma;
begin
  inherited;

  If fEmptyStr(edtPath.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o caminho do arquivo para a importação!', ['&Ok']);
    Exit;
  End;

  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmImportCadFreteTranspCidadeFaixaConfirma, frmImportConfirma);
    If AbreExcel(frmImportConfirma) Then
      frmImportConfirma.ShowModal;
    If frmImportConfirma.ModalResult = mrOK Then
      fMensagem('AVISO','Importação realizada com sucesso!', ['&O K']);
  Finally
    pFreeAndNil(frmImportConfirma);
  End;

end;

function TFrmImportCadFreteTranspCidadeFaixa.fConvetVazioToNull(
  texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
end;

function TFrmImportCadFreteTranspCidadeFaixa.fTemTitulo: boolean;
var
  intValDef: Integer;
begin
  If Not blnArqCsv Then
  Begin
    If Trim(Excel.Range[cCodTra + IntToStr(1)].Value) <> '' Then
      Result := not TryStrToInt(Trim(Excel.Range[cCodTra + IntToStr(1)].Value), intValDef)
    Else
      Result := False;
  End
  Else
  Begin
    If objValidaExcel.fGetValueCSV(0, cCodTra) <> '' Then
      Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCodTra)), intValDef)
    Else
      Result := False;
  End
end;

function TFrmImportCadFreteTranspCidadeFaixa.fFaixaFaturamentoEncontradaNoBanco(
  strCodTran, strCodCid: String; dblFatIni, dblFatFin: Double): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  FValFtI := 0;
  FValFtF := 0;
  FValDtF := 0;
  FSeqFre := EmptyStr;
  Result  := False;

  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT * FROM FRETRA ');
    qryConsulta.SQL.Add(' WHERE FRE_CODTRA = :CODTRA ');
    qryConsulta.SQL.Add('   AND FRE_CODCID = :CODCID ');

    qryConsulta.ParamByName('CODTRA').AsString := fStrZero(strCodTran, 5);
    qryConsulta.ParamByName('CODCID').AsString := fStrZero(strCodCid, 5);

    qryConsulta.Open;
    FSeqFre := qryConsulta.FieldByName('AUTOINCREM').AsString;

    if fEmptyStr(FSeqFre) then
      Exit;

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT * FROM FREFAI ');
    qryConsulta.SQL.Add(' INNER JOIN FRETRA ON FRETRA.AUTOINCREM = FREFAI.FAI_SEQFRE ');
    qryConsulta.SQL.Add(' WHERE FRE_CODTRA = :CODTRA ');
    qryConsulta.SQL.Add('   AND FRE_CODCID = :CODCID ');
    qryConsulta.SQL.Add('   AND FAI_FATINI = :FATINI ');
    qryConsulta.SQL.Add('   AND FAI_FATFIN = :FATFIN ');

    qryConsulta.ParamByName('CODTRA').AsString := fStrZero(strCodTran, 5);
    qryConsulta.ParamByName('CODCID').AsString := fStrZero(strCodCid, 5);
    qryConsulta.ParamByName('FATINI').AsFloat  := dblFatIni;
    qryConsulta.ParamByName('FATFIN').AsFloat  := dblFatFin;

    qryConsulta.Open;

    Result:= (Not(qryConsulta.IsEmpty));

    If (Result) Then
    Begin
      FValFtI := qryConsulta.FieldByName('FAI_FATINI').AsFloat;
      FValFtF := qryConsulta.FieldByName('FAI_FATFIN').AsFloat;
      FValDtF := qryConsulta.FieldByName('FAI_PERDES').AsFloat;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pCriarDataSet(
  FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma);
begin
  FImportaFaixa.cdsDadosIns.CreateDataSet;
  FImportaFaixa.cdsDadosUpd.CreateDataSet;
  FImportaFaixa.cdsDadosIns.EmptyDataSet;
  FImportaFaixa.cdsDadosUpd.EmptyDataSet;

  If (Not(FImportaFaixa.cdsTranspNaoImportadaRelatorio.Active)) Then
    FImportaFaixa.cdsTranspNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportaFaixa.cdsCidadeNaoImportadaRelatorio.Active)) Then
    FImportaFaixa.cdsCidadeNaoImportadaRelatorio.CreateDataSet;

  FImportaFaixa.cdsTranspNaoImportadaRelatorio.EmptyDataSet;
  FImportaFaixa.cdsCidadeNaoImportadaRelatorio.EmptyDataSet;

end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pFormataCampos(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma);
begin
  TFloatField(FImportaFaixa.cdsDadosIns.FieldByName('VALFTI')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaFaixa.cdsDadosIns.FieldByName('VALFTF')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaFaixa.cdsDadosIns.FieldByName('VALDTF')).DisplayFormat := '###,###,##0.00';

  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALFTI')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALFTF')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALDTF')).DisplayFormat := '###,###,##0.00';

  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALFTI_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALFTF_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALDTF_NOVO')).DisplayFormat := '###,###,##0.00';
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pInsereItensCDS(intLinha: integer; FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixaConfirma);
var
  blnCampoEmBranco: Boolean;
begin
  If (Not(fFaixaFaturamentoEncontradaNoBanco(objValidaExcel.fGetValueCSV(intLinha, cCodTra),
                                             objValidaExcel.fGetValueCSV(intLinha, cCodCid),
                                             StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, cValFtI),0),
                                             StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, cValFtF),0)))) Then
  Begin
    FImportaFaixa.cdsDadosIns.Insert;

    FImportaFaixa.cdsDadosIns.FieldByName('MARCADO').Value   := 1;
    FImportaFaixa.cdsDadosIns.FieldByName('SEQFRE').AsString := FSeqFre;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaFaixa.cdsDadosIns.FieldByName('CODTRA').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaFaixa.cdsDadosIns.FieldByName('NOMTRA').AsString  := fRetNomTransportadora(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra)));

      Try
        pValidaCampoVazio(FImportaFaixa.cdsDadosIns.FieldByName('NOMTRA').AsString);
      Except
        On E: Exception do
        Begin
          FImportaFaixa.pIncluiTransportadoraNaoImportada(FImportaFaixa.cdsDadosIns.FieldByName('CODTRA').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;

    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaFaixa.cdsDadosIns.FieldByName('CODCID').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaFaixa.cdsDadosIns.FieldByName('NOMCID').AsString  := fRetNomCidade(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid)));

      Try
        pValidaCampoVazio(FImportaFaixa.cdsDadosIns.FieldByName('NOMCID').AsString);
      Except
        On E: Exception do
        Begin
          FImportaFaixa.pIncluiCidadeNaoImportada(FImportaFaixa.cdsDadosIns.FieldByName('CODCID').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;

    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValFtI));
      FImportaFaixa.cdsDadosIns.FieldByName('VALFTI').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValFtI)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValFtF));
      FImportaFaixa.cdsDadosIns.FieldByName('VALFTF').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValFtF)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValDtF));
      FImportaFaixa.cdsDadosIns.FieldByName('VALDTF').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValDtF)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;

    blnCampoEmBranco:= fEmptyStr(FImportaFaixa.cdsDadosIns.FieldByName('NOMTRA').AsString) Or
                       fEmptyStr(FImportaFaixa.cdsDadosIns.FieldByName('NOMCID').AsString) Or
                       fEmptyStr(FSeqFre);


    Try
      pValidaTrueFalse(blnCampoEmBranco);
      FImportaFaixa.cdsDadosIns.Post;
    Except
      On E: Exception do
      Begin
        FImportaFaixa.cdsDadosIns.Cancel;
      End;

    End;
  End
  Else
  Begin

    FImportaFaixa.cdsDadosUpd.Insert;

    FImportaFaixa.cdsDadosUpd.FieldByName('MARCADO').AsInteger := 1;
    FImportaFaixa.cdsDadosUpd.FieldByName('SEQFRE').AsString   := FSeqFre;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaFaixa.cdsDadosUpd.FieldByName('CODTRA').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaFaixa.cdsDadosUpd.FieldByName('NOMTRA').AsString  := fRetNomTransportadora(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra)));

      Try
        pValidaCampoVazio(FImportaFaixa.cdsDadosUpd.FieldByName('NOMTRA').AsString);

      Except
        On E: Exception do
        Begin

          FImportaFaixa.pIncluiTransportadoraNaoImportada(FImportaFaixa.cdsDadosUpd.FieldByName('CODTRA').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaFaixa.cdsDadosUpd.FieldByName('CODCID').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaFaixa.cdsDadosUpd.FieldByName('NOMCID').AsString  := fRetNomCidade(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid)));

      Try
        pValidaCampoVazio(FImportaFaixa.cdsDadosUpd.FieldByName('NOMCID').AsString);

      Except
        On E: Exception do
        Begin

          FImportaFaixa.pIncluiCidadeNaoImportada(FImportaFaixa.cdsDadosUpd.FieldByName('CODCID').AsString);
        End;
      End;
    Except
      On E: Exception do
      Begin

      End;
    End;

    FImportaFaixa.cdsDadosUpd.FieldByName('VALFTI').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValFtI),'.','');
    FImportaFaixa.cdsDadosUpd.FieldByName('VALFTF').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValFtF),'.','');
    FImportaFaixa.cdsDadosUpd.FieldByName('VALDTF').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValDtF),'.','');

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValFti));
      FImportaFaixa.cdsDadosUpd.FieldByName('VALFTI_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValFtI))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValFtF));
      FImportaFaixa.cdsDadosUpd.FieldByName('VALFTF_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValFtF))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValDtf));
      FImportaFaixa.cdsDadosUpd.FieldByName('VALDTF_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValDtF))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    if (FImportaFaixa.cdsDadosUpd.FieldByName('VALFTI').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('VALFTI_NOVO').AsString) and
       (FImportaFaixa.cdsDadosUpd.FieldByName('VALFTF').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('VALFTF_NOVO').AsString) and
       (FImportaFaixa.cdsDadosUpd.FieldByName('VALDTF').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('VALDTF_NOVO').AsString) then
      FImportaFaixa.cdsDadosUpd.FieldByName('MARCADO').AsInteger := 0;

    blnCampoEmBranco:= fEmptyStr(FImportaFaixa.cdsDadosUpd.FieldByName('NOMTRA').AsString) Or
                       fEmptyStr(FImportaFaixa.cdsDadosUpd.FieldByName('NOMCID').AsString) Or
                       fEmptyStr(FSeqFre);

    Try
      pValidaTrueFalse(blnCampoEmBranco);
      FImportaFaixa.cdsDadosUpd.Post;
    Except
    On E: Exception do
      Begin
       FImportaFaixa.cdsDadosUpd.Cancel;
     End;
    End;

  End;
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pPreparaValidador;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODTRA, cCODTRA, 5, True, False, 'CADTRA', 'TRA_CODTRA'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCODTRA, cCODTRA));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODCID, cCODCID, 5, True, False, 'CADCID', 'CID_CODCID'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValFtI, cValFtI));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValFtF, cValFtF));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValDtF, cValDtF));
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pValidaCampoVazio(strInfo: Variant);
begin
  If (strInfo = '') Then
    raise Exception.Create('Campo não possui informação!');
end;

procedure TFrmImportCadFreteTranspCidadeFaixa.pValidaTrueFalse(
  blnCampoEmBranco: Boolean);
begin
  If (blnCampoEmBranco) Then
    raise Exception.Create('Informação verdadeira!');
end;

end.
