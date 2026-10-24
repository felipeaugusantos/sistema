unit untImportCadFreteTranspCidadeFaixasPeso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons, cxProgressBar, untTValidaExcel,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, ComObj,
  untImportCadFreteTranspCidadeFaixasPesoConfirma, Data.DB, Uni, System.StrUtils;

type
  TFrmImportCadFreteTranspCidadeFaixasPeso = class(TfrmPai)
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
    { Private declarations }
    Excel          : Variant;
    intSequencial  : Integer;
    blnArqCsv      : Boolean;
    objValidaExcel : TValidadorExcel;
    FSeqFre        : String;
    FValPkg,
    FPesIni,
    FPesFin,
    FValFre        : Double;

    function AbreExcel(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma): Boolean;
    procedure pInsereItensCDS(intLinha: integer; FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma);
    procedure pFormataCampos(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma);
    procedure pCriarDataSet(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma);
    Procedure pPreparaValidador;
    procedure pAtualizaInfoValidador;
    procedure pValidaCampoVazio(strInfo: Variant);
    procedure pValidaTrueFalse(blnCampoEmBranco: Boolean);

    function  fTemTitulo: boolean;
    function fConvetVazioToNull(texto: string): Variant;
    function fFaixaPesoEncontradaNoBanco(strCodTran, strCodCid: String;
      dblPesIni, dblPesFin: Double): Boolean;

  public
    { Public declarations }
  end;

const

  //A - Código da transportadora
  //B - Código da cidade
  //C - Valor por KG
  //D - Faixa 1 peso inicial
  //E - Faixa 1 peso final
  //F - Faixa 1 valor
  //G - Faixa 2 peso inicial
  //H - Faixa 2 peso final
  //I - Faixa 2 valor
  //J - Faixa 3 peso inicial
  //K - Faixa 3 peso final
  //L - Faixa 3 valor
  //M - Faixa 4 peso inicial
  //N - Faixa 4 peso final
  //O - Faixa 4 valor
  //P - Faixa 5 peso inicial
  //Q - Faixa 5 peso final
  //R - Faixa 5 valor
  //S - Faixa 6 peso inicial
  //T - Faixa 6 peso final
  //U - Faixa 6 valor

  cColunasExcel: array[0..20] of String = ('A','B','C','D','E','F','G','H','I','J',
                                           'K','L','M','N','O','P','Q','R','S','T',
                                           'U');

  cDesColunasExcel: array[0..20] of String = ('Código da transportadora',
                                              'Código da cidade',
                                              'Valor por KG',
                                              'Faixa 1 peso inicial',
                                              'Faixa 1 peso final',
                                              'Faixa 1 valor',
                                              'Faixa 2 peso inicial',
                                              'Faixa 2 peso final',
                                              'Faixa 2 valor',
                                              'Faixa 3 peso inicial',
                                              'Faixa 3 peso final',
                                              'Faixa 3 valor',
                                              'Faixa 4 peso inicial',
                                              'Faixa 4 peso final',
                                              'Faixa 4 valor',
                                              'Faixa 5 peso inicial',
                                              'Faixa 5 peso final',
                                              'Faixa 5 valor',
                                              'Faixa 6 peso inicial',
                                              'Faixa 6 peso final',
                                              'Faixa 6 valor');

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TFrmImportCadFreteTranspCidadeFaixasPeso.AbreExcel(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma): Boolean;
Var
  intValIni, intContador : Integer;
begin
  Result:= True;
  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Arquivo Excel...';

  objValidaExcel := TValidadorExcel.Create(edtPath.text, Length(cColunasExcel), cColunasExcel[0], EmptyStr);

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

    Excel.Selection.SpecialCells(Length(cColunasExcel)).Select;

    pgbGeral.Properties.Max := Excel.ActiveCell.Row -1;
  Except
    on E: Exception do
    Begin
      pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;
    End;
  End;

  pgbGeral.Position := 0;
  pnlInfo.Caption       := 'Aguarde... Carregando Cadastro de Faixas de Peso...';

  Mouse.SettingChanged(10);
  pgbGeral.Visible := True;
  Application.ProcessMessages;
  pnlInfo.Caption       := 'Aguarde... Importando Tabela Cadastro de Faixas de Peso...';

  pCriarDataSet(FImportaFaixa);
  pFormataCampos(FImportaFaixa);

  intValIni     := IIf(fTemTitulo, 1 , 0);
  intSequencial := 1;

  pgbGeral.Properties.Max := pgbGeral.Properties.Max
                           - intValIni;

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

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.btnCancelaValidacaoClick(
  Sender: TObject);
begin
  inherited;
  objValidaExcel.blnCancela := True;
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.btnGravarClick(Sender: TObject);
var
  frmImportConfirma: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma;
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
    pCriarFormularios(TfrmImportCadFreteTranspCidadeFaixasPesoConfirma, frmImportConfirma);
    If AbreExcel(frmImportConfirma) Then
      frmImportConfirma.ShowModal;
    If frmImportConfirma.ModalResult = mrOK Then
    Begin
      fMensagem('AVISO','Importação realizada com sucesso!', ['&O K']);
      Self.Close;
    End;
  Finally
    pFreeAndNil(frmImportConfirma);
  End;
end;

function TFrmImportCadFreteTranspCidadeFaixasPeso.fConvetVazioToNull(
  texto: string): Variant;
begin
  If Texto = EmptyStr Then
    Result := null
  Else
    Result := texto;
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
end;

function TFrmImportCadFreteTranspCidadeFaixasPeso.fTemTitulo: boolean;
var
  intValDef: Integer;
begin
  If Not blnArqCsv Then
  Begin
    If Trim(Excel.Range[cColunasExcel[0] + IntToStr(1)].Value) <> EmptyStr Then
      Result := not TryStrToInt(Trim(Excel.Range[cColunasExcel[0] + IntToStr(1)].Value), intValDef)
    Else
      Result := False;
  End
  Else
  Begin
    If objValidaExcel.fGetValueCSV(0, cColunasExcel[0]) <> EmptyStr Then
      Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cColunasExcel[0])), intValDef)
    Else
      Result := False;
  End
end;

function TFrmImportCadFreteTranspCidadeFaixasPeso.fFaixaPesoEncontradaNoBanco(
  strCodTran, strCodCid: String; dblPesIni, dblPesFin: Double): Boolean;
Var
  qryConsulta: TUniQuery;
begin
  FValPkg := 0;
  FPesIni := 0;
  FPesFin := 0;
  FValFre := 0;
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
    FValPkg := qryConsulta.FieldByName('FRE_VALKIL').AsFloat;

    If fEmptyStr(FSeqFre) Then
      Exit;

    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT * FROM FREFXP ');
    qryConsulta.SQL.Add(' INNER JOIN FRETRA ON FRETRA.AUTOINCREM = FREFXP.FAI_SEQFRE ');
    qryConsulta.SQL.Add(' WHERE FRE_CODTRA = :CODTRA ');
    qryConsulta.SQL.Add('   AND FRE_CODCID = :CODCID ');
    qryConsulta.SQL.Add('   AND FAI_PESINI = :PESINI ');
    qryConsulta.SQL.Add('   AND FAI_PESFIN = :PESFIN ');

    qryConsulta.ParamByName('CODTRA').AsString := fStrZero(strCodTran, 5);
    qryConsulta.ParamByName('CODCID').AsString := fStrZero(strCodCid, 5);
    qryConsulta.ParamByName('PESINI').AsFloat  := dblPesIni;
    qryConsulta.ParamByName('PESFIN').AsFloat  := dblPesFin;

    qryConsulta.Open;

    Result := (Not(qryConsulta.IsEmpty));

    If (Result) Then
    Begin
      FValPkg := qryConsulta.FieldByName('FRE_VALKIL').AsFloat;
      FPesIni := qryConsulta.FieldByName('FAI_PESINI').AsFloat;
      FPesFin := qryConsulta.FieldByName('FAI_PESFIN').AsFloat;
      FValFre := qryConsulta.FieldByName('FAI_VALFRE').AsFloat;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pAtualizaInfoValidador;
begin
  PnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pCriarDataSet(
  FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma);
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

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pFormataCampos(FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma);
begin
  TFloatField(FImportaFaixa.cdsDadosIns.FieldByName('PESINI')).DisplayFormat := ',0.00';
  TFloatField(FImportaFaixa.cdsDadosIns.FieldByName('PESFIN')).DisplayFormat := ',0.00';
  TFloatField(FImportaFaixa.cdsDadosIns.FieldByName('VALFRE')).DisplayFormat := ',0.0000';

  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('PESINI')).DisplayFormat := ',0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN')).DisplayFormat := ',0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE')).DisplayFormat := ',0.0000';

  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('PESINI_NOVO')).DisplayFormat := ',0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN_NOVO')).DisplayFormat := ',0.00';
  TFloatField(FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE_NOVO')).DisplayFormat := ',0.0000';
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pInsereItensCDS(intLinha: integer; FImportaFaixa: TfrmImportCadFreteTranspCidadeFaixasPesoConfirma);
var
  blnCampoEmBranco: Boolean;
  intContador     : Integer;
begin
  intContador := 3;
  While intContador <= 20 Do
  Begin
    If (Not fFaixaPesoEncontradaNoBanco(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0]),
                                        objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1]),
                                        StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador]),0),
                                        StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+1]),0))) Then
    Begin
      FImportaFaixa.cdsDadosIns.Insert;

      FImportaFaixa.cdsDadosIns.FieldByName('MARCADO').Value   := 1;
      FImportaFaixa.cdsDadosIns.FieldByName('SEQFRE').AsString := FSeqFre;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0]));
        FImportaFaixa.cdsDadosIns.FieldByName('CODTRA').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0]));
        FImportaFaixa.cdsDadosIns.FieldByName('NOMTRA').AsString  := fRetNomTransportadora(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0])));

        Try
          pValidaCampoVazio(FImportaFaixa.cdsDadosIns.FieldByName('NOMTRA').AsString);
        Except
          On E: Exception do
          Begin
            FImportaFaixa.pIncluiTransportadoraNaoImportada(FImportaFaixa.cdsDadosIns.FieldByName('CODTRA').AsString);
          End;
        End;
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1]));
        FImportaFaixa.cdsDadosIns.FieldByName('CODCID').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1]));
        FImportaFaixa.cdsDadosIns.FieldByName('NOMCID').AsString  := fRetNomCidade(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1])));

        Try
          pValidaCampoVazio(FImportaFaixa.cdsDadosIns.FieldByName('NOMCID').AsString);
        Except
          On E: Exception do
          Begin
            FImportaFaixa.pIncluiCidadeNaoImportada(FImportaFaixa.cdsDadosIns.FieldByName('CODCID').AsString);
          End;
        End;
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[2]));
        FImportaFaixa.cdsDadosIns.FieldByName('VALPKG').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[2])),'.',EmptyStr);
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador]));
        FImportaFaixa.cdsDadosIns.FieldByName('PESINI').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador])),'.',EmptyStr);
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+1]));
        FImportaFaixa.cdsDadosIns.FieldByName('PESFIN').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+1])),'.',EmptyStr);
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+2]));
        FImportaFaixa.cdsDadosIns.FieldByName('VALFRE').AsString  := AnsiReplaceStr(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+2])),'.',EmptyStr);
      Except
      End;

      blnCampoEmBranco:= fEmptyStr(FImportaFaixa.cdsDadosIns.FieldByName('NOMTRA').AsString) Or
                         fEmptyStr(FImportaFaixa.cdsDadosIns.FieldByName('NOMCID').AsString) Or
                         fEmptyStr(FSeqFre) Or
                         ((FImportaFaixa.cdsDadosIns.FieldByName('PESINI').AsFloat = 0) And
                          (FImportaFaixa.cdsDadosIns.FieldByName('PESFIN').AsFloat = 0) And
                          (FImportaFaixa.cdsDadosIns.FieldByName('VALFRE').AsFloat = 0));

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
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0]));
        FImportaFaixa.cdsDadosUpd.FieldByName('CODTRA').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0]));
        FImportaFaixa.cdsDadosUpd.FieldByName('NOMTRA').AsString  := fRetNomTransportadora(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[0])));

        Try
          pValidaCampoVazio(FImportaFaixa.cdsDadosUpd.FieldByName('NOMTRA').AsString);
        Except
          On E: Exception do
          Begin
            FImportaFaixa.pIncluiTransportadoraNaoImportada(FImportaFaixa.cdsDadosUpd.FieldByName('CODTRA').AsString);
          End;
        End;
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1]));
        FImportaFaixa.cdsDadosUpd.FieldByName('CODCID').AsString  := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1]));
        FImportaFaixa.cdsDadosUpd.FieldByName('NOMCID').AsString  := fRetNomCidade(fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[1])));

        Try
          pValidaCampoVazio(FImportaFaixa.cdsDadosUpd.FieldByName('NOMCID').AsString);
        Except
          On E: Exception do
          Begin
            FImportaFaixa.pIncluiCidadeNaoImportada(FImportaFaixa.cdsDadosUpd.FieldByName('CODCID').AsString);
          End;
        End;
      Except
      End;

      FImportaFaixa.cdsDadosUpd.FieldByName('VALPKG').AsString := AnsiReplaceStr(FormatFloat(',0.0000', FValPkg),'.',EmptyStr);
      FImportaFaixa.cdsDadosUpd.FieldByName('PESINI').AsString := AnsiReplaceStr(FormatFloat(',0.00', FPesIni),'.',EmptyStr);
      FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN').AsString := AnsiReplaceStr(FormatFloat(',0.00', FPesFin),'.',EmptyStr);
      FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE').AsString := AnsiReplaceStr(FormatFloat(',0.0000', FValFre),'.',EmptyStr);

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[2]));
        FImportaFaixa.cdsDadosUpd.FieldByName('VALPKG_NOVO').AsString := AnsiReplaceStr(FormatFloat(',0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[2]))),'.',EmptyStr);
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador]));
        FImportaFaixa.cdsDadosUpd.FieldByName('PESINI_NOVO').AsString := AnsiReplaceStr(FormatFloat(',0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador]))),'.',EmptyStr);
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+1]));
        FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN_NOVO').AsString := AnsiReplaceStr(FormatFloat(',0.00', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+1]))),'.',EmptyStr);
      Except
      End;

      Try
        pValidaCampoVazio(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+2]));
        FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE_NOVO').AsString := AnsiReplaceStr(FormatFloat(',0.0000', fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cColunasExcel[intContador+2]))),'.',EmptyStr);
      Except
      End;

      If (FImportaFaixa.cdsDadosUpd.FieldByName('VALPKG').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('VALPKG_NOVO').AsString) And
         (FImportaFaixa.cdsDadosUpd.FieldByName('PESINI').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('PESINI_NOVO').AsString) And
         (FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN_NOVO').AsString) And
         (FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE').AsString = FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE_NOVO').AsString) Then
        FImportaFaixa.cdsDadosUpd.FieldByName('MARCADO').AsInteger := 0;

      blnCampoEmBranco:= fEmptyStr(FImportaFaixa.cdsDadosUpd.FieldByName('NOMTRA').AsString) Or
                         fEmptyStr(FImportaFaixa.cdsDadosUpd.FieldByName('NOMCID').AsString) Or
                         fEmptyStr(FSeqFre) Or
                         ((FImportaFaixa.cdsDadosUpd.FieldByName('PESINI').AsFloat = 0) And
                          (FImportaFaixa.cdsDadosUpd.FieldByName('PESFIN').AsFloat = 0) And
                          (FImportaFaixa.cdsDadosUpd.FieldByName('VALFRE').AsFloat = 0));


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

    intContador := intContador
                 + 3;
  End
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pPreparaValidador;
var
  intContador: Integer;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesColunasExcel[0], cColunasExcel[0], 5, True, False, 'CADTRA', 'TRA_CODTRA'));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoInt(cDesColunasExcel[0], cColunasExcel[0]));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cDesColunasExcel[1], cColunasExcel[1], 5, True, False, 'CADCID', 'CID_CODCID'));

  intContador := 3;
  While intContador <= 20 Do
  Begin
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesColunasExcel[intContador], cColunasExcel[3]));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesColunasExcel[intContador+1], cColunasExcel[intContador+1]));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cDesColunasExcel[intContador+2], cColunasExcel[intContador+2]));

    intContador := intContador
                 + 3;
  End;
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pValidaCampoVazio(strInfo: Variant);
begin
  If (strInfo = EmptyStr) Then
    raise Exception.Create('Campo não possui informação!');
end;

procedure TFrmImportCadFreteTranspCidadeFaixasPeso.pValidaTrueFalse(
  blnCampoEmBranco: Boolean);
begin
  If (blnCampoEmBranco) Then
    raise Exception.Create('Informação verdadeira!');
end;

end.
