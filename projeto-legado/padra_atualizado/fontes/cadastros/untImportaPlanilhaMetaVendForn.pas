unit untImportaPlanilhaMetaVendForn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxButtons, Vcl.Mask,
  MaskEditFocus, cxProgressBar, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus, untTValidaExcel, UniClientDataSet;

type
  TfrmImportaPlanilhaMetaVendForn = class(TfrmPai)
    pnlfundo: TPanel;
    lblPathArquivo: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnHlpImp: TcxButton;
    btnGravar: TBitBtnLocked;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FExcel: TValidadorExcel;
    FcdsRegistros : TUniClientDataSet;
    FcdsErros     : TUniClientDataSet;
    FOk: Boolean;

    const QTD_COLUNAS = 5;
      PERMES = 'A';
      PERANO = 'B';
      CODVEN = 'C';
      CODFOR = 'D';
      VALOR_ = 'E';

    procedure InsereRegistro(ALinha: integer);
    procedure ProcessaRegistros;
    function RetornaLinhaAposTitulo: Integer;
    procedure InsereErro(ALinha: Integer; AColuna, AMensagem: String; out AErro: Boolean);
    procedure ExibeTela;
    procedure CriaDataSets;
    function RetornaSeExiste(AMes: string; AAno: string; AVendedor: string; AFornecedor: string): String;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, System.StrUtils, untConfirmaImportaPlanilhaMetaVendForn,
  Data.DB, Uni;

{$R *.dfm}

procedure TfrmImportaPlanilhaMetaVendForn.btnGravarClick(
  Sender: TObject);
begin
  inherited;
  edtPath.Text := StringReplace(edtPath.Text, '"', '', [rfReplaceAll]);

  If (fEmptyStr(edtPath.Text)) Then
  Begin
    pMensagemOk('Selecione um arquivo!');
    Exit;
  End
  Else If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  Try
    Try
      btnHlpImp.Enabled     := False;
      btnGravar.Enabled     := False;
      btnSair.Enabled       := False;
      edtPath.Enabled       := False;

      FExcel := TValidadorExcel.Create(edtPath.text, QTD_COLUNAS, '', '', 0);

      Mouse.SettingChanged(10);
      pgbGeral.Visible := True;
      Application.ProcessMessages;

      ProcessaRegistros;

      SetForegroundWindow(Handle);
      edtPath.Clear;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportaPlanilhaMetaVendForn.btnGravarClick]');
      End;
    End;
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(FExcel);
    pgbGeral.Position     := 0;
    pgbGeral.Visible := False;
    pSetFocus(btnSair);
  End;
end;

procedure TfrmImportaPlanilhaMetaVendForn.btnHlpImpClick(
  Sender: TObject);
  procedure CarregaLayout(AName: string; AReport: TfrxReport);
  Var
    mmsLoad: TStream;
    LQuery: TUniQuery;
  begin
    LQuery := fCriaQuery();
    try
      LQuery.SQL.Text :=
        'SELECT * FROM LAYFR3 '+
        'WHERE LAY_NOMFOR = "TfrmImportaPlanilhaMetaVendForn" '+
        '  AND LAY_NOMLAY = "' + AName + '" ';
      LQuery.Open;
      if LQuery.IsEmpty then
        raise Exception.Create('Layout TfrmImportaPlanilhaMetaVendForn.' + AName +
          ' não foi encontrado na tabela LAYFR3');
      LQuery.Edit;
      mmsLoad := LQuery.CreateBlobStream(LQuery.FieldByName('LAY_ARQFR3'), bmReadWrite);
      try
        AReport.LoadFromStream(mmsLoad);
      finally
        FreeAndNil(mmsLoad);
      end;
    finally
      LQuery.Cancel;
      FreeAndNil(LQuery)
    end;
  end;
var
  LfrxHelp: TfrxReport;
begin
  inherited;
    LfrxHelp := Nil;
  try
    LfrxHelp := TfrxReport.Create(self);
    CarregaLayout('frxAjuda',LfrxHelp);
    LfrxHelp.DotMatrixReport           := False;
    LfrxHelp.PrintOptions.PrintMode    := pmScale;
    LfrxHelp.PrintOptions.PrintOnSheet := 9;
    pPreviewReport(Self.Name, Self.Caption + ' (Help)', LfrxHelp);
  finally
    FreeAndNil(LfrxHelp)
  end
end;

procedure TfrmImportaPlanilhaMetaVendForn.ExibeTela;
Var
  LfrmConfirmaImportaPlanilhaMetaVendForn : TfrmConfirmaImportaPlanilhaMetaVendForn;
begin
  LfrmConfirmaImportaPlanilhaMetaVendForn := nil;
  pCriarFormularios(TfrmConfirmaImportaPlanilhaMetaVendForn, LfrmConfirmaImportaPlanilhaMetaVendForn);
  Try
    if Assigned(LfrmConfirmaImportaPlanilhaMetaVendForn) then
    begin
      LfrmConfirmaImportaPlanilhaMetaVendForn.cdsDados := FcdsRegistros;
      LfrmConfirmaImportaPlanilhaMetaVendForn.cdsErros := FcdsErros;
      LfrmConfirmaImportaPlanilhaMetaVendForn.ShowModal;
      FOk := LfrmConfirmaImportaPlanilhaMetaVendForn.Ok;
    end;
  Finally
    if Assigned(LfrmConfirmaImportaPlanilhaMetaVendForn) then
      pFreeAndNil(LfrmConfirmaImportaPlanilhaMetaVendForn);
  End;
end;

procedure TfrmImportaPlanilhaMetaVendForn.FormCreate(Sender: TObject);
begin
  inherited;
  CriaDataSets;
end;

procedure TfrmImportaPlanilhaMetaVendForn.InsereErro(ALinha: Integer; AColuna,
  AMensagem: String; out AErro: Boolean);
begin
  FcdsErros.Open;
  FcdsErros.Insert;
  FcdsErros.FieldByName('LINHA').AsInteger := ALinha;
  FcdsErros.FieldByName('COLUNA').AsString := AColuna;
  FcdsErros.FieldByName('MENSAG').AsString := AMensagem;
  FcdsErros.Post;

  AErro := True;
end;

procedure TfrmImportaPlanilhaMetaVendForn.InsereRegistro(ALinha: integer);
  function ValidaValor(AValor: string): Boolean;
  var
    LValor: string;
    LNum: Double;
    LFS: TFormatSettings;
  begin
    Result := False;

    LValor := Trim(AValor);
    if fEmptyStr(LValor) then
      Exit;

    LFS := TFormatSettings.Create;
    LFS.DecimalSeparator := '.';

    Result := TryStrToFloat(LValor, LNum, LFS);
  end;
Var
  LErro : Boolean;
  LAno: Integer;
  LVendedor: string;
  LFornecedor: string;
  LValorAjustado: string;
begin
  LErro := False;

  LVendedor := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [FExcel.fGetValueCSV(ALinha, CODVEN)], False);
  LFornecedor := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [FExcel.fGetValueCSV(ALinha, CODFOR)], False);

  LValorAjustado := FExcel.fGetValueCSV(ALinha, VALOR_);
  LValorAjustado := StringReplace(LValorAjustado, '.', '', [rfReplaceAll]);
  LValorAjustado := StringReplace(LValorAjustado, ',', '.', [rfReplaceAll]);

  FcdsRegistros.Open;
  FcdsRegistros.Insert;
  FcdsRegistros.FieldByName('PERMES').AsString    := FExcel.fGetValueCSV(ALinha, PERMES);
  FcdsRegistros.FieldByName('PERANO').AsString    := FExcel.fGetValueCSV(ALinha, PERANO);
  FcdsRegistros.FieldByName('CODVEN').AsString    := FExcel.fGetValueCSV(ALinha, CODVEN);
  FcdsRegistros.FieldByName('NOMVEN').AsString    := LVendedor;
  FcdsRegistros.FieldByName('CODFOR').AsString    := FExcel.fGetValueCSV(ALinha, CODFOR);
  FcdsRegistros.FieldByName('NOMFOR').AsString    := LFornecedor;
  FcdsRegistros.FieldByName('VALOR_').AsString    := LValorAjustado;
  FcdsRegistros.FieldByName('EXISTE').AsString    := RetornaSeExiste(FcdsRegistros.FieldByName('PERMES').AsString,
                                                                     FcdsRegistros.FieldByName('PERANO').AsString,
                                                                     FcdsRegistros.FieldByName('CODVEN').AsString,
                                                                     FcdsRegistros.FieldByName('CODFOR').AsString);

  If Not fEmptyStr(FcdsRegistros.FieldByName('PERMES').AsString) Then
  Begin
    if (StrToIntDef(FcdsRegistros.FieldByName('PERMES').AsString,0) < 1) or (StrToIntDef(FcdsRegistros.FieldByName('PERMES').AsString,0) > 12) then
      InsereErro(Succ(ALinha), 'A', 'Mes inválido!', LErro);
  End
  Else
    InsereErro(Succ(ALinha), 'A', 'Campo obrigatório!', LErro);

  LAno := StrToIntDef(FcdsRegistros.FieldByName('PERANO').AsString,0);
  If Not fEmptyStr(FcdsRegistros.FieldByName('PERANO').AsString) Then
  Begin
    If (Length(Trim(FcdsRegistros.FieldByName('PERANO').AsString)) <> 4) or (LAno = 0) Then
      InsereErro(Succ(ALinha), 'B', 'Ano inválido!', LErro);
  End
  Else
    InsereErro(Succ(ALinha), 'B', 'Campo obrigatório!', LErro);

  If fEmptyStr(FcdsRegistros.FieldByName('CODVEN').AsString) Then
    InsereErro(Succ(ALinha), 'C', 'Campo obrigatório!', LErro)
  Else If fEmptyStr(LVendedor) Then
      InsereErro(Succ(ALinha), 'C', 'Vendedor não encontrado!', LErro);

  If fEmptyStr(FcdsRegistros.FieldByName('CODFOR').AsString) Then
    InsereErro(Succ(ALinha), 'D', 'Campo obrigatório!', LErro)
  Else If fEmptyStr(LFornecedor) Then
      InsereErro(Succ(ALinha), 'D', 'Fornecedor não encontrado!', LErro);

  If fEmptyStr(FcdsRegistros.FieldByName('VALOR_').AsString) Then
    InsereErro(Succ(ALinha), 'E', 'Campo obrigatório!', LErro)
  Else If (Not ValidaValor(FcdsRegistros.FieldByName('VALOR_').AsString)) Then
    InsereErro(Succ(ALinha), 'E', 'Valor inválido!', LErro);

  if FcdsRegistros.FieldByName('EXISTE').AsString = 'E' then
    InsereErro(Succ(ALinha), '0', 'Erro ao validar registro!', LErro);

  If LErro Then
    FcdsRegistros.Cancel
  Else
    FcdsRegistros.Post;
end;

procedure TfrmImportaPlanilhaMetaVendForn.CriaDataSets;
begin
  FcdsRegistros := TUniClientDataSet.Create(Self);

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PERMES';
    DataType := ftString;
    Size     := 2;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PERANO';
    DataType := ftString;
    Size     := 4;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODVEN';
    DataType := ftString;
    Size     := 3;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMVEN';
    DataType := ftString;
    Size     := 60;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODFOR';
    DataType := ftString;
    Size     := 8;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMFOR';
    DataType := ftString;
    Size     := 60;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALOR_';
    DataType := ftString;
    Size     := 30;
  End;

  With FcdsRegistros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'EXISTE';
    DataType := ftString;
    Size     := 1;
  End;

  FcdsRegistros.CreateDataSet;

  FcdsErros := TUniClientDataSet.Create(Self);

  With FcdsErros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'LINHA';
    DataType := ftInteger;
    Required := True;
  End;

  With FcdsErros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'COLUNA';
    DataType := ftString;
    Size     := 1;
    Required := True;
  End;

  With FcdsErros.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'MENSAG';
    DataType := ftString;
    Size     := 150;
    Required := True;
  End;

  FcdsErros.CreateDataSet;
end;

procedure TfrmImportaPlanilhaMetaVendForn.ProcessaRegistros;
Var
  LValIni : Integer;
  LContador : Integer;
begin
  pgbGeral.Properties.Max := FExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  If FcdsRegistros.Active Then
    FcdsRegistros.EmptyDataSet;

  If FcdsErros.Active Then
    FcdsErros.EmptyDataSet;

  LValIni := RetornaLinhaAposTitulo;
  pgbGeral.Position := 0;
  For LContador := LValIni To (FExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando registros...'+ IntToStr(LContador) +'/' +IntToStr(FExcel.ArquivoCSV.Count-LValIni);

    InsereRegistro(LContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  ExibeTela;
end;

function TfrmImportaPlanilhaMetaVendForn.RetornaLinhaAposTitulo: Integer;
var
  LTestador : Integer;
  LContador : Integer;
begin
  Result := 0;
  For LContador := 0 To Pred(FExcel.ArquivoCSV.Count) Do
  Begin
    If TryStrToInt(Trim(FExcel.fGetValueCSV(LContador, PERMES)), LTestador) Then
      Exit(LContador);
  End;
end;

function TfrmImportaPlanilhaMetaVendForn.RetornaSeExiste(AMes, AAno, AVendedor,
  AFornecedor: string): String;
begin
  Result := 'N';
  try
    if not fEmptyStr(fCampoTabela('AUTOINCREM', 'VALGER',
      ['VAL_CODEMP','VAL_NUMMES','VAL_NUMANO','VAL_CODVEN','VAL_CODFOR'],
      [VS_strCodEmp, AMes, AAno, AVendedor, AFornecedor], False)) then
      Result := 'S';
  except
    On E: Exception Do
    Begin
      Result := 'E';
      pMensagensErro(E.Message, '[TfrmImportaPlanilhaMetaVendForn.RetornaSeExiste]');
    End;
  end;
end;

end.
