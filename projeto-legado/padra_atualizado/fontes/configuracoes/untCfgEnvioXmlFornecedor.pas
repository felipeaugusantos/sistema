unit untCfgEnvioXmlFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmCfgEnvioXmlFornecedor = class(TfrmPaiConfirma)
    lblDepartamento: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lblMarca: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtEmail: TEditFocus;
    lblEmail: TLabel;
    btnAdicionar: TBitBtnLocked;
    cxGridOpcoesDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridOpcoesLevel1: TcxGridLevel;
    cxGridOpcoes: TcxGridCitel;
    btnExcluir: TBitBtnLocked;
    cxGridOpcoesFOR_CODDEP: TcxGridDBColumn;
    cxGridOpcoesDEP_DESCRI: TcxGridDBColumn;
    cxGridOpcoesFOR_CODMAR: TcxGridDBColumn;
    cxGridOpcoesMAR_DESMAR: TcxGridDBColumn;
    cxGridOpcoesFOR_EMAIL_: TcxGridDBColumn;
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    qryXmlFor: TUniQuery;
    cdsXmlFor: TUniClientDataSet;
    dtsXmlFor: TDataSource;

    procedure pCarregaDados;
    procedure pLimpaCampos;
    procedure pAjustaGrid;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples;

procedure TfrmCfgEnvioXmlFornecedor.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    Exit;

  cdsXmlFor.Append;
  cdsXmlFor.FieldByName('FOR_CODDEP').AsString := edtCodDep.Text;
  cdsXmlFor.FieldByName('DEP_DESCRI').AsString := edtDesDep.Text;
  cdsXmlFor.FieldByName('FOR_CODMAR').AsString := edtCodMar.Text;
  cdsXmlFor.FieldByName('MAR_DESMAR').AsString := edtDesMar.Text;
  cdsXmlFor.FieldByName('FOR_EMAIL_').AsString := edtEmail.Text;
  cdsXmlFor.Post;

  pLimpaCampos;
  pAjustaGrid;
  pSetFocus(edtCodDep);
end;

procedure TfrmCfgEnvioXmlFornecedor.pAjustaGrid;
begin
  cxGridOpcoesDBTableViewCitel1.BeginUpdate;
  try
    cxGridOpcoesDBTableViewCitel1.ApplyBestFit();
  finally
    cxGridOpcoesDBTableViewCitel1.EndUpdate;
  end;
end;

procedure TfrmCfgEnvioXmlFornecedor.btnConfirmaClick(Sender: TObject);
var
  qryAux: TUniQuery;
begin
  inherited;

  ModalResult := mrNone;

  qryAux := fCriaQuery(Self);
  try
    try
      fStartTransaction;

      qryAux.SQL.Text :=
      ' DELETE FROM '+
      '   XMLFOR '+
      ' WHERE '+
      '   FOR_CODEMP = :CODEMP ';
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ExecSQL;

      cdsXmlFor.First;
      while not cdsXmlFor.Eof do
      begin
        qryAux.Close;
        qryAux.SQL.Text :=
        ' INSERT INTO XMLFOR '+
        '   (AUTOINCREM, '+
        '    FOR_CODEMP, '+
        '    FOR_CODDEP, '+
        '    FOR_CODMAR, '+
        '    FOR_EMAIL_) '+
        ' VALUES '+
        '   (:AUTINC, '+
        '    :CODEMP, '+
        '    :CODDEP, '+
        '    :CODMAR, '+
        '    :EMAIL_) ';

        qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('XMLFOR', VS_strCodEmp);
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryAux.ParamByName('CODDEP').AsString := cdsXmlFor.FieldByName('FOR_CODDEP').AsString;
        qryAux.ParamByName('CODMAR').AsString := cdsXmlFor.FieldByName('FOR_CODMAR').AsString;
        qryAux.ParamByName('EMAIL_').AsString := cdsXmlFor.FieldByName('FOR_EMAIL_').AsString;
        qryAux.ExecSQL;

        cdsXmlFor.Next;
      end;

      fCommit;
      fMensagem('ATENÇÃO!', 'Opções de envio gravadas com sucesso!', ['&Ok']);
    except
      on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCfgEnvioXmlFornecedor.btnConfirmaClick]');
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCfgEnvioXmlFornecedor.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not Assigned(cdsXmlFor) then
    Exit;

  if cdsXmlFor.IsEmpty then
    Exit;

  cdsXmlFor.Delete;
end;

procedure TfrmCfgEnvioXmlFornecedor.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrSel, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgEnvioXmlFornecedor.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrSel, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgEnvioXmlFornecedor.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsXmlFor);
  FreeAndNil(cdsXmlFor);
  FreeAndNil(qryXmlFor);
end;

procedure TfrmCfgEnvioXmlFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  pSetFocus(edtCodDep);
end;

procedure TfrmCfgEnvioXmlFornecedor.pCarregaDados;
begin
  if not Assigned(qryXmlFor) then
    qryXmlFor := fCriaQuery(Self);

  qryXmlFor.Close;
  qryXmlFor.SQL.Text :=
  ' SELECT '+
  '   FOR_CODDEP, '+
  '   DEP_DESCRI, '+
  '   FOR_CODMAR, '+
  '   MAR_DESMAR, '+
  '   FOR_EMAIL_  '+
  ' FROM '+
  '   XMLFOR '+
  ' INNER JOIN CADDEP ON '+
  '   FOR_CODDEP = DEP_CODIGO '+
  ' INNER JOIN CADMAR ON '+
  '   FOR_CODMAR = MAR_CODMAR '+
  ' WHERE '+
  '   FOR_CODEMP = :CODEMP';
  qryXmlFor.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryXmlFor.Open;

   if Assigned(cdsXmlFor) then
   begin
     FreeAndNil(dtsXmlFor);
     FreeAndNil(cdsXmlFor);
   end;

   cdsXmlFor := fCriaClientDatset(qryXmlFor);
   dtsXmlFor := fCriaDataSource(cdsXmlFor);
   cxGridOpcoesDBTableViewCitel1.DataController.DataSource := dtsXmlFor;
   pAjustaGrid;
end;

procedure TfrmCfgEnvioXmlFornecedor.pLimpaCampos;
begin
  edtCodDep.Clear;
  edtCodMar.Clear;
  edtDesDep.Clear;
  edtDesMar.Clear;
  edtEmail.Clear;
end;

function TfrmCfgEnvioXmlFornecedor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    If Sender = edtCodDep Then
    Begin
      if fEmptyStr(edtCodDep.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o Departamento do Produto!', ['&Ok']);
        Result := False;
      end
      else
      begin
        edtDesDep.Text := fRetDescDepartamento(edtCodDep.Text);
        if fEmptyStr(edtDesDep.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Departamento do Produto inválido!', ['&Ok']);
          Result := False;
        end;
      end;
    End

    Else

    If Sender = edtCodMar Then
    Begin
      if fEmptyStr(edtCodMar.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe a Marca do Produto!', ['&Ok']);
        Result := False;
      end
      else
      begin
        edtDesMar.Text := fRetNomeMarca(edtCodMar.Text);
        if fEmptyStr(edtDesMar.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Marca do Produto inválida!', ['&Ok']);
          Result := False;
        end;
      end;
    End

    Else

    If Sender = edtEmail Then
    Begin
      if fEmptyStr(edtEmail.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Informe o e-Mail do Fornecedor!', ['&Ok']);
        Result := False;
      end
      else if not fEnderecoEmailValido(edtEmail.Text) then
      begin
        fMensagem('ATENÇÃO!', 'e-Mail inválido!', ['&Ok']);
        Result := False;
      end;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
