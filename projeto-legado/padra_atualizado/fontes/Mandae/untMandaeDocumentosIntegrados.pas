unit untMandaeDocumentosIntegrados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask, MaskEditFocus,
  EditFocus, Mandae.Classes;

type
  TfrmMandaeDocumentosIntegrados = class(TfrmPai)
    grdDocumentos: TcxGridCitel;
    grdDbDocumentos: TcxGridDBTableViewCitel;
    grdDbDocumentosColumn1: TcxGridDBColumn;
    grdDbDocumentosColumn2: TcxGridDBColumn;
    grdDbDocumentosColumn3: TcxGridDBColumn;
    grdDbDocumentosColumn6: TcxGridDBColumn;
    grdDbDocumentosColumn4: TcxGridDBColumn;
    grdDbDocumentosColumn5: TcxGridDBColumn;
    grdDocumentosLevel1: TcxGridLevel;
    Panel1: TPanel;
    lblDatEnt: TLabel;
    edtDataDocumento: TMaskEditFocus;
    Label1: TLabel;
    edtDataEnvio: TMaskEditFocus;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    Label3: TLabel;
    edtEspDoc: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnListar: TBitBtnLocked;
    dtsDocumentos: TDataSource;
    btnConsultarTracking: TBitBtnLocked;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarTrackingClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FObjMandaeRepositorio  : TMandaeRepositorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untMandaeConsultarTracking;

{$R *.dfm}

procedure TfrmMandaeDocumentosIntegrados.btnListarClick(Sender: TObject);
  var
    LObjMandaeFiltro: TMandaeFiltro;
begin
  inherited;
  LObjMandaeFiltro := TMandaeFiltro.Create;
  Try
    LObjMandaeFiltro.strNumeroDocumento  := edtNumDoc.Text;
    LObjMandaeFiltro.strEspecieDocumento := edtEspDoc.Text;
    LObjMandaeFiltro.strCodigoEmpresa    := edtCodEmp.Text;
    LObjMandaeFiltro.dtaDocumento        := StrToDateDef(edtDataDocumento.Text,0);
    LObjMandaeFiltro.dtaEnvio            := StrToDateDef(edtDataEnvio.Text,0);

    dtsDocumentos.DataSet := FObjMandaeRepositorio.fListarDocumentosIntegrados(LObjMandaeFiltro);

  Finally
    if Assigned(LObjMandaeFiltro) then
      FreeAndNil(LObjMandaeFiltro);
  End;
end;

procedure TfrmMandaeDocumentosIntegrados.btnConsultarTrackingClick(Sender: TObject);
  Var
    frmMandaeConsultarTracking: TfrmMandaeConsultarTracking;
begin
  Try
    pCriarFormularios(TfrmMandaeConsultarTracking, frmMandaeConsultarTracking);
    frmMandaeConsultarTracking.strCodigoDeRastreio := dtsDocumentos.DataSet.FieldByName('MAN_CODRAS').AsString;
    frmMandaeConsultarTracking.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConsultarTrackingClick]');
      Exit;
    End;
  End;
  pFreeAndNil(frmMandaeConsultarTracking);
end;

procedure TfrmMandaeDocumentosIntegrados.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
end;

procedure TfrmMandaeDocumentosIntegrados.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMandaeDocumentosIntegrados.FormCreate(Sender: TObject);
begin
  inherited;
  FObjMandaeRepositorio := TMandaeRepositorio.Create;
end;

procedure TfrmMandaeDocumentosIntegrados.FormDestroy(Sender: TObject);
begin
  if Assigned(FObjMandaeRepositorio) then
    FreeAndNil(FObjMandaeRepositorio);
  inherited;
end;

procedure TfrmMandaeDocumentosIntegrados.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F6 Then
  Begin
    btnConsultarTracking.Click;
  End;
end;

procedure TfrmMandaeDocumentosIntegrados.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  pSetFocus(edtDataDocumento);

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;
end;

function TfrmMandaeDocumentosIntegrados.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin
      If not fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        if fEmptyStr(edtNomEmp.Text)  then
        begin
          fMensagem('ATENÇÃO!', 'Empresa inválida.!', ['&O k']);
          Result := False;
        end;

        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
     End;

  End;
end;

end.
