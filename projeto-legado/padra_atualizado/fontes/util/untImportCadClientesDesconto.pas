unit untImportCadClientesDesconto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, Data.DB,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxControls, cxContainer, cxEdit, cxProgressBar, Uni, UniClientDataSet,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus, cxButtons, untTValidaExcel,
  System.StrUtils;

type
  TfrmImportCadClientesDesconto = class(TfrmPai)
    btnGravar: TBitBtnLocked;
    btnHlpImp: TcxButton;
    pnlfundo: TPanel;
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    frxHelp: TfrxReport;
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objValidaExcel : TValidadorExcel;
    cdsRegistros   : TUniClientDataSet;
    procedure pProcessaRegistros;
    procedure pLimparCDS;
    procedure pExibeTela;
    function fValidaNumerico(strColuna, strTabela, strCampo, strValor: string;
      var strMensagem: String): boolean;
    procedure pVerificaJaCadastrados;

    const cQtdColunas = 4;
    const cNAO_ENCONTRADO = 'NÃO ENCONTRADO';

    const cCOL_CODCLI = 'A';
          cCOL_CODFOR = 'B';
          cCOL_PERDES = 'C';
          cCOL_PERCOM = 'D';

    const cTIT_CODCLI = 'Código Cliente';
          cTIT_CODFOR = 'Código Fornecedor';
          cTIT_PERDES = 'Percentual de Desconto';
          cTIT_PERCOM = 'Percentual de Comissão';

    procedure pPrepararValidador;
    procedure pCriarCds;
    function fTemTitulo: boolean;
    function fGetSQLConsulta: string;
    procedure pInsereRegistroCDS(intLinha: Integer);
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples,
  untTLog,
  untImportCadClientesDescontoConfirma,
  untGravando;

{$R *.dfm}

{ TfrmImportCadClientesDesconto }

procedure TfrmImportCadClientesDesconto.btnGravarClick(Sender: TObject);
begin
  If (fEmptyStr(edtPath.Text)) Then
  Begin
    pMensagemOk('Selecione o arquivo!');
    Exit;
  End
  Else If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  Try
   objValidaExcel := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCOL_CODCLI, '', 0);
    Try
      pPrepararValidador;
      pgbGeral.Visible := True;
      btnGravar.Enabled := True;

      If Not objValidaExcel.fValidaCampos(True, pgbGeral) Then
        Exit;
    Finally
      btnGravar.Enabled := False;
    End;

    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);
    pgbGeral.Visible := True;
    Application.ProcessMessages;
    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    pCriarCds;
    Try
      pProcessaRegistros;

      SetForegroundWindow(Handle);

      edtPath.Clear;
      btnHlpImp.Enabled     := True;
      btnGravar.Enabled     := True;
      btnSair.Enabled       := True;
      edtPath.Enabled       := True;
      pnlInfo.Caption       := '';
      pgbGeral.Position     := 0;
      pSetFocus(btnSair);
      cdsRegistros.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmImportCadClientesDesconto.btnGravarClick]');
        btnHlpImp.Enabled     := True;
        btnGravar.Enabled     := True;
        btnSair.Enabled       := True;
        edtPath.Enabled       := True;
        pnlInfo.Caption       := '';
        pgbGeral.Position     := 0;
        pSetFocus(btnSair);
      End;
    End;
  Finally
    btnSair.Enabled       := True;
    edtPath.Enabled       := True;

    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;
  End
end;

procedure TfrmImportCadClientesDesconto.pProcessaRegistros;
  Var
    intValIni : Integer;
    intContador : Integer;
begin
  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count -1;
  pgbGeral.Position := 0;

  pLimparCDS;
  intValIni := IIf(fTemTitulo, 1 , 0);
  pgbGeral.Position := 0;
  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando os dados...'+ IntToStr(intContador) +'/' +IntToStr(objValidaExcel.ArquivoCSV.Count-intValIni);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereRegistroCDS(intContador);
    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

  pVerificaJaCadastrados;

  If (Not cdsRegistros.IsEmpty) Then
    pExibeTela;
end;

procedure TfrmImportCadClientesDesconto.pVerificaJaCadastrados;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Text := fGetSQLConsulta;

    cdsRegistros.First;
    While (Not cdsRegistros.Eof) Do
    Begin
      qryGen.Close;
      qryGen.ParamByName('CODCLI').AsString := cdsRegistros.FieldByName('CDS_CODCLI').AsString;
      qryGen.ParamByName('CODFOR').AsString := cdsRegistros.FieldByName('CDS_CODFOR').AsString;
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.Open;

      If (Not qryGen.IsEmpty) Then
      Begin
        cdsRegistros.Edit;
        cdsRegistros.FieldByName('CADASTRADO').AsBoolean := True;
        cdsRegistros.Post;
      End;

      cdsRegistros.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmImportCadClientesDesconto.pLimparCDS;
begin
  cdsRegistros.EmptyDataSet;
end;

procedure TfrmImportCadClientesDesconto.pExibeTela;
  Var
    frmImportCadClientesDescontoConfirma : TfrmImportCadClientesDescontoConfirma;
begin
  If (Not cdsRegistros.IsEmpty) Then
  Begin
    pCriarFormularios(TfrmImportCadClientesDescontoConfirma, frmImportCadClientesDescontoConfirma);
    Try
      frmImportCadClientesDescontoConfirma.cdsRegistros := cdsRegistros;
      frmImportCadClientesDescontoConfirma.ShowModal;
    Finally
      pFreeAndNil(frmImportCadClientesDescontoConfirma);
    End;
  End;
end;

procedure TfrmImportCadClientesDesconto.btnHlpImpClick(Sender: TObject);
begin
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportCadClientesDesconto.FormCreate(Sender: TObject);
begin
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';
  pCriarCds;
end;

function TfrmImportCadClientesDesconto.fGetSQLConsulta: string;
begin
  Result := '';
  Result := Result + ' SELECT CLIDES.AUTOINCREM   ';
  Result := Result + ' FROM CLIDES                ';
  Result := Result + ' WHERE CDS_CODCLI = :CODCLI ';
  Result := Result + '   AND CDS_CODFOR = :CODFOR ';
  Result := Result + '   AND CDS_CODEMP = :CODEMP ';
end;

function TfrmImportCadClientesDesconto.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cCOL_CODCLI) <> '' Then
    Result := Not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCOL_CODCLI)), intValDef)
  Else
    Result := False;
end;

procedure TfrmImportCadClientesDesconto.pInsereRegistroCDS(intLinha: Integer);
  Var
    strCodFor : String;
    strCodCli : String;
    strNomFor : String;
    strNomCli : String;
begin
  strCodFor := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cCOL_CODFOR), 8);
  strNomFor := fRetNomFornecedor(strCodFor);

  strCodCli := fStrZero(objValidaExcel.fGetValueCSV(intLinha, cCOL_CODCLI), VS_intTamCodCli);
  strNomCli := fRetNomCliente(strCodCli);

  If (fEmptyStr(strNomFor)) Then
    strNomFor := cNAO_ENCONTRADO;

  If (fEmptyStr(strNomCli)) Then
    strNomCli := cNAO_ENCONTRADO;

  cdsRegistros.Insert;
  cdsRegistros.FieldByName('CDS_CODFOR').AsString := strCodFor;
  cdsRegistros.FieldByName('FOR_NOMFOR').AsString := strNomFor;
  cdsRegistros.FieldByName('CDS_CODCLI').AsString := strCodCli;
  cdsRegistros.FieldByName('CLI_NOMCLI').AsString := strNomCli;
  cdsRegistros.FieldByName('CDS_PERDES').AsFloat  := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, cCOL_PERDES), 0);
  cdsRegistros.FieldByName('CDS_PERCOM').AsFloat  := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, cCOL_PERCOM), 0);
  cdsRegistros.FieldByName('CDS_CODEMP').AsString := VS_strCodEmp;
  cdsRegistros.FieldByName('CADASTRADO').AsBoolean := False;
  cdsRegistros.Post;
end;

procedure TfrmImportCadClientesDesconto.pCriarCds;
begin
  cdsRegistros := TUniClientDataSet.Create(Self);

  cdsRegistros.Close;
  cdsRegistros.FieldDefs.Clear;
  cdsRegistros.FieldDefs.Add('CDS_CODCLI', ftString, 8);
  cdsRegistros.FieldDefs.Add('CLI_NOMCLI', ftString, 60);
  cdsRegistros.FieldDefs.Add('CDS_CODFOR', ftString, 8);
  cdsRegistros.FieldDefs.Add('FOR_NOMFOR', ftString, 60);
  cdsRegistros.FieldDefs.Add('CDS_PERDES', ftFloat);
  cdsRegistros.FieldDefs.Add('CDS_PERCOM', ftFloat);
  cdsRegistros.FieldDefs.Add('CDS_CODEMP', ftString, 3);
  cdsRegistros.FieldDefs.Add('CADASTRADO', ftBoolean);
  cdsRegistros.CreateDataSet;
  cdsRegistros.Open;

  cdsRegistros.EmptyDataSet;
end;

procedure TfrmImportCadClientesDesconto.pPrepararValidador;
begin
  If (Not Assigned(objValidaExcel)) Then
    Exit;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cTIT_CODCLI, cCOL_CODCLI, VS_intTamCodCli, False, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(cTIT_CODFOR, cCOL_CODFOR, 8,  True, True, fValidaNumerico));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cTIT_PERDES,  cCOL_PERDES));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(cTIT_PERCOM,  cCOL_PERCOM));
end;

function TfrmImportCadClientesDesconto.fValidaNumerico(strColuna, strTabela, strCampo,
  strValor: string; var strMensagem: String): boolean;
begin
  Try
    StrToInt(strValor);
    Result := True;
  Except On
    E:Exception Do
    Begin
      strMensagem := 'O campo informado não é um valor em formato númerico válido';
      Result := False;
    End;
  End;
end;

end.
