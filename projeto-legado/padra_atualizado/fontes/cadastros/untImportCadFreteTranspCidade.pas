unit untImportCadFreteTranspCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons, cxProgressBar, untTValidaExcel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, ComObj,
  untImportCadFreteTranspCidadeConfirma, Data.DB, Uni, System.StrUtils;

type
  TFrmImportCadFreteTranspCidade = class(TfrmPai)
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
    function AbreExcel(FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma): Boolean;
    procedure pInsereItensCDS(intLinha: integer; FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma);
    procedure pFormataCampos(FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma);
    procedure pCriarDataSet(FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma);
    Procedure pPreparaValidador;
    procedure pAtualizaInfoValidador;
    procedure pValidaCampoVazio(strInfo: Variant);
    procedure pValidaTrueFalse(blnCampoEmBranco: Boolean);

    function  fTemTitulo: boolean;
    function fConvetVazioToNull(texto: string): Variant;
    function fTransportadoraEncontradaNoBanco(strCodTran, strCodCid: String): Boolean;


    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmImportCadFreteTranspCidade: TFrmImportCadFreteTranspCidade;
  Excel         : Variant;
  intSequencial : Integer;
  blnArqCsv     : Boolean;
  objValidaExcel: TValidadorExcel;

  FValIse,
  FValFte,
  FPerVnf,
  FValKlg,
  FValPed,
  FPerGri,
  FValGri,
  FValTas: Double;

const

  cQtdColunas = 11;

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


implementation

uses untFuncoesSimples;

{$R *.dfm}

function TFrmImportCadFreteTranspCidade.AbreExcel(FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma): Boolean;
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

    Excel.Selection.SpecialCells(11).Select;

    pgbGeral.Properties.Max := Excel.ActiveCell.Row -1;

  Except
    on E: Exception do
    Begin
      pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;
    End;
  End;

  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Cadastro de Frete...';

  Mouse.SettingChanged(10);
  pgbGeral.Visible := True;
  Application.ProcessMessages;
  pnlInfo.Caption       := 'Aguarde... Importando Tabela Cadastro de Frete...';

  pCriarDataSet(FImportaTransportadora);
  pFormataCampos(FImportaTransportadora);

  intValIni := IIf(fTemTitulo, 1 , 0);
  intSequencial := 1;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    If blnArqCsv Then
      If intContador > objValidaExcel.ArquivoCSV.Count Then
        Continue;
    pInsereItensCDS(intContador, FImportaTransportadora);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
    inc(intSequencial);
  End;

  pnlInfo.Caption       := 'Informações Carregadas...';
end;

procedure TFrmImportCadFreteTranspCidade.btnCancelaValidacaoClick(
  Sender: TObject);
begin
  inherited;
  objValidaExcel.blnCancela := True;
end;

procedure TFrmImportCadFreteTranspCidade.btnGravarClick(Sender: TObject);
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
    pCriarFormularios(TfrmImportCadFreteTranspCidadeConfirma, frmImportCadFreteTranspCidadeConfirma);
    If AbreExcel(frmImportCadFreteTranspCidadeConfirma) Then
      frmImportCadFreteTranspCidadeConfirma.ShowModal;
    If frmImportCadFreteTranspCidadeConfirma.ModalResult = mrOK Then
      fMensagem('AVISO','Importação realizada com sucesso!', ['&O K']);
  Finally
    pFreeAndNil(frmImportCadFreteTranspCidadeConfirma);
  End;

end;

function TFrmImportCadFreteTranspCidade.fConvetVazioToNull(
  texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

procedure TFrmImportCadFreteTranspCidade.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
end;

function TFrmImportCadFreteTranspCidade.fTemTitulo: boolean;
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

function TFrmImportCadFreteTranspCidade.fTransportadoraEncontradaNoBanco(
  strCodTran, strCodCid: String): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT * FROM FRETRA WHERE FRE_CODTRA = :CODTRA ');
    qryConsulta.SQL.Add('                       AND FRE_CODCID = :CODCID ');

    qryConsulta.ParamByName('CODTRA').AsString:= fStrZero(strCodTran, 5);
    qryConsulta.ParamByName('CODCID').AsString:= fStrZero(strCodCid, 5);

    qryConsulta.Open;

    Result:= (Not(qryConsulta.IsEmpty));

    If (Result) Then
    Begin
      FValIse:= qryConsulta.FieldByName('FRE_VALISE').AsFloat;
      FValFte:= qryConsulta.FieldByName('FRE_MINFRE').AsFloat;
      FPerVnf:= qryConsulta.FieldByName('FRE_PERTOT').AsFloat;
      FValKlg:= qryConsulta.FieldByName('FRE_VALKIL').AsFloat;
      FValPed:= qryConsulta.FieldByName('FRE_PD100K').AsFloat;
      FPerGri:= qryConsulta.FieldByName('FRE_PERGRI').AsFloat;
      FValGri:= qryConsulta.FieldByName('FRE_MINGRI').AsFloat;
      FValTas:= qryConsulta.FieldByName('FRE_VALTAS').AsFloat;
    End
    Else
    Begin
      FValIse:= 0;
      FValFte:= 0;
      FPerVnf:= 0;
      FValKlg:= 0;
      FValPed:= 0;
      FPerGri:= 0;
      FValGri:= 0;
      FValTas:= 0;
    end;


  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TFrmImportCadFreteTranspCidade.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TFrmImportCadFreteTranspCidade.pCriarDataSet(
  FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma);
begin
  FImportaTransportadora.cdsDadosIns.CreateDataSet;
  FImportaTransportadora.cdsDadosUpd.CreateDataSet;
  FImportaTransportadora.cdsDadosIns.EmptyDataSet;
  FImportaTransportadora.cdsDadosUpd.EmptyDataSet;

  If (Not(FImportaTransportadora.cdsTranspNaoImportadaRelatorio.Active)) Then
    FImportaTransportadora.cdsTranspNaoImportadaRelatorio.CreateDataSet;

  If (Not(FImportaTransportadora.cdsCidadeNaoImportadaRelatorio.Active)) Then
    FImportaTransportadora.cdsCidadeNaoImportadaRelatorio.CreateDataSet;

  FImportaTransportadora.cdsTranspNaoImportadaRelatorio.EmptyDataSet;
  FImportaTransportadora.cdsCidadeNaoImportadaRelatorio.EmptyDataSet;

end;

procedure TFrmImportCadFreteTranspCidade.pFormataCampos(FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma);
begin
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('VALISE')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('VALFTE')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('PERVNF')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('VALKLG')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('VALPED')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('PERGRI')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('VALGRI')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosIns.FieldByName('VALTAS')).DisplayFormat := '###,###,##0.00';

  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALISE')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALFTE')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('PERVNF')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALKLG')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALPED')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('PERGRI')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALGRI')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALTAS')).DisplayFormat := '###,###,##0.00';

  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALISE_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALFTE_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('PERVNF_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALKLG_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALPED_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('PERGRI_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALGRI_NOVO')).DisplayFormat := '###,###,##0.00';
  TFloatField(FImportaTransportadora.cdsDadosUpd.FieldByName('VALTAS_NOVO')).DisplayFormat := '###,###,##0.00';
end;

procedure TFrmImportCadFreteTranspCidade.pInsereItensCDS(intLinha: integer; FImportaTransportadora: TfrmImportCadFreteTranspCidadeConfirma);
var
  blnCampoEmBranco: Boolean;
begin
  If (Not(fTransportadoraEncontradaNoBanco(objValidaExcel.fGetValueCSV(intLinha, cCodTra),
                                           objValidaExcel.fGetValueCSV(intLinha, cCodCid)))) Then
  Begin
    FImportaTransportadora.cdsDadosIns.Insert;

    FImportaTransportadora.cdsDadosIns.FieldByName('MARCADO').Value := 1;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaTransportadora.cdsDadosIns.FieldByName('CODTRA').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaTransportadora.cdsDadosIns.FieldByName('NOMTRA').AsString  := fRetNomTransportadora(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra)));

      Try
        pValidaCampoVazio(FImportaTransportadora.cdsDadosIns.FieldByName('NOMTRA').AsString);
      Except
        On E: Exception do
        Begin
          FImportaTransportadora.pIncluiTransportadoraNaoImportada(FImportaTransportadora.cdsDadosIns.FieldByName('CODTRA').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;

    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaTransportadora.cdsDadosIns.FieldByName('CODCID').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaTransportadora.cdsDadosIns.FieldByName('NOMCID').AsString  := fRetNomCidade(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid)));

      Try
        pValidaCampoVazio(FImportaTransportadora.cdsDadosIns.FieldByName('NOMCID').AsString);
      Except
        On E: Exception do
        Begin
          FImportaTransportadora.pIncluiCidadeNaoImportada(FImportaTransportadora.cdsDadosIns.FieldByName('CODCID').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;

    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValNFI));
      FImportaTransportadora.cdsDadosIns.FieldByName('VALISE').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValNFI)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValFrt));
      FImportaTransportadora.cdsDadosIns.FieldByName('VALFTE').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValFrt)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cPrcNta));
      FImportaTransportadora.cdsDadosIns.FieldByName('PERVNF').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPrcNta)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValKgr));
      FImportaTransportadora.cdsDadosIns.FieldByName('VALKLG').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValKgr)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValPed));
      FImportaTransportadora.cdsDadosIns.FieldByName('VALPED').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValPed)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cPrcGri));
      FImportaTransportadora.cdsDadosIns.FieldByName('PERGRI').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPrcGri)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValMGr));
      FImportaTransportadora.cdsDadosIns.FieldByName('VALGRI').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValMGr)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValTas));
      FImportaTransportadora.cdsDadosIns.FieldByName('VALTAS').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValTas)),'.','');

    Except
      on E: Exception do
      Begin

      End;
    End;

    blnCampoEmBranco:= fEmptyStr(FImportaTransportadora.cdsDadosIns.FieldByName('NOMTRA').AsString) Or
                       fEmptyStr(FImportaTransportadora.cdsDadosIns.FieldByName('NOMCID').AsString);


    Try
      pValidaTrueFalse(blnCampoEmBranco);
      FImportaTransportadora.cdsDadosIns.Post;
    Except
      On E: Exception do
      Begin
        FImportaTransportadora.cdsDadosIns.Cancel;
      End;

    End;


  End
  Else
  Begin

    FImportaTransportadora.cdsDadosUpd.Insert;

    FImportaTransportadora.cdsDadosUpd.FieldByName('MARCADO').AsInteger := 1;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaTransportadora.cdsDadosUpd.FieldByName('CODTRA').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra));
      FImportaTransportadora.cdsDadosUpd.FieldByName('NOMTRA').AsString  := fRetNomTransportadora(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodTra)));

      Try
        pValidaCampoVazio(FImportaTransportadora.cdsDadosUpd.FieldByName('NOMTRA').AsString);

      Except
        On E: Exception do
        Begin

          FImportaTransportadora.pIncluiTransportadoraNaoImportada(FImportaTransportadora.cdsDadosUpd.FieldByName('CODTRA').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;
    End;


    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaTransportadora.cdsDadosUpd.FieldByName('CODCID').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid));
      FImportaTransportadora.cdsDadosUpd.FieldByName('NOMCID').AsString  := fRetNomCidade(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCodCid)));

      Try
        pValidaCampoVazio(FImportaTransportadora.cdsDadosUpd.FieldByName('NOMCID').AsString);

      Except
        On E: Exception do
        Begin

          FImportaTransportadora.pIncluiCidadeNaoImportada(FImportaTransportadora.cdsDadosUpd.FieldByName('CODCID').AsString);
        End;

      End;

    Except
      On E: Exception do
      Begin

      End;
    End;


    FImportaTransportadora.cdsDadosUpd.FieldByName('VALISE').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValIse),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('VALFTE').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValFte),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('PERVNF').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FPerVnf),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('VALKLG').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValKlg),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('VALPED').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValPed),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('PERGRI').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FPerGri),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('VALGRI').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValGri),'.','');
    FImportaTransportadora.cdsDadosUpd.FieldByName('VALTAS').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', FValTas),'.','');

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValNFI));
      FImportaTransportadora.cdsDadosUpd.FieldByName('VALISE_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValNFI))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValFrt));
      FImportaTransportadora.cdsDadosUpd.FieldByName('VALFTE_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValFrt))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cPrcNta));
      FImportaTransportadora.cdsDadosUpd.FieldByName('PERVNF_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPrcNta))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValKgr));
      FImportaTransportadora.cdsDadosUpd.FieldByName('VALKLG_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValKgr))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValPed));
      FImportaTransportadora.cdsDadosUpd.FieldByName('VALPED_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValPed))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cPrcGri));
      FImportaTransportadora.cdsDadosUpd.FieldByName('PERGRI_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cPrcGri))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValMGr));
      FImportaTransportadora.cdsDadosUpd.FieldByName('VALGRI_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValMGr))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    Try
      pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cValTas));
      FImportaTransportadora.cdsDadosUpd.FieldByName('VALTAS_NOVO').AsString  := AnsiReplaceStr(FormatFloat('#,##0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cValTas))),'.','');

    Except
    on E: Exception do
      Begin

      End;
    End;

    blnCampoEmBranco:= fEmptyStr(FImportaTransportadora.cdsDadosUpd.FieldByName('NOMTRA').AsString) Or
                       fEmptyStr(FImportaTransportadora.cdsDadosUpd.FieldByName('NOMCID').AsString);


    Try
      pValidaTrueFalse(blnCampoEmBranco);
      FImportaTransportadora.cdsDadosUpd.Post;
    Except
    On E: Exception do
      Begin
       FImportaTransportadora.cdsDadosUpd.Cancel;
     End;
    End;

  End;
end;

procedure TFrmImportCadFreteTranspCidade.pPreparaValidador;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODTRA, cCODTRA, 5, True, False, 'CADTRA', 'TRA_CODTRA'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesCODTRA, cCODTRA));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesCODCID, cCODCID, 5, True, False, 'CADCID', 'CID_CODCID'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValNFI, cValNFI));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValFrt, cValFrt));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPrcNta, cPrcNta));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValKgr, cValKgr));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValPed, cValPed));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesPrcGri, cPrcGri));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValMGr, cValMGr));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesValTas, cValTas));
end;

procedure TFrmImportCadFreteTranspCidade.pValidaCampoVazio(strInfo: Variant);
begin
  If (strInfo = '') Then
    raise Exception.Create('Campo não possui informação!');
end;

procedure TFrmImportCadFreteTranspCidade.pValidaTrueFalse(
  blnCampoEmBranco: Boolean);
begin
  If (blnCampoEmBranco) Then
    raise Exception.Create('Informação verdadeira!');
end;

end.
