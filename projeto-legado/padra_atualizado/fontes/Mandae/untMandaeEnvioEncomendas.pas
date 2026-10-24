unit untMandaeEnvioEncomendas;

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
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Mandae.Classes, UniClientDataSet,
  cxProgressBar;

type
  TfrmMandaeEnvioEncomendas = class(TfrmPai)
    Panel3: TPanel;
    grdDocumentos: TcxGridCitel;
    grdDbDocumentos: TcxGridDBTableViewCitel;
    grdDbDocumentosColumn1: TcxGridDBColumn;
    grdDbDocumentosColumn2: TcxGridDBColumn;
    grdDocumentosLevel1: TcxGridLevel;
    grdDbDocumentosColumn3: TcxGridDBColumn;
    grdDbDocumentosColumn4: TcxGridDBColumn;
    grdDbDocumentosColumn5: TcxGridDBColumn;
    dtsDocumentos: TDataSource;
    btnEnviarDocumentos: TBitBtnLocked;
    grdDbDocumentosColumn6: TcxGridDBColumn;
    btnConsultarEnviados: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEnviarDocumentosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarEnviadosClick(Sender: TObject);
  private
    { Private declarations }
    FObjMandaeRepositorio      : TMandaeRepositorio;
    FcdsDocumentos             : TUniClientDataSet;
    FblnIntegracaoPeloRomaneio : Boolean;
    FstrMensagemRetornoErro    : String;

    procedure pCarregarDocumentos;
    Function fIntegrarComMandae(pgbProgresso: TcxProgressBar): Boolean;

  Public
    property cdsDocumentos : TUniClientDataSet   read FcdsDocumentos write FcdsDocumentos;
    property blnIntegracaoPeloRomaneio : Boolean read FblnIntegracaoPeloRomaneio write FblnIntegracaoPeloRomaneio;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, MandaeJSON.Classes, MandaeWS.Classes, untGravando,
     untMandaeDocumentosIntegrados;

{$R *.dfm}

procedure TfrmMandaeEnvioEncomendas.btnConsultarEnviadosClick(Sender: TObject);
  Var
    frmMandaeDocumentosIntegrados: TfrmMandaeDocumentosIntegrados;
begin
  Try
    pCriarFormularios(TfrmMandaeDocumentosIntegrados, frmMandaeDocumentosIntegrados);
    frmMandaeDocumentosIntegrados.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConsultarEnviadosClick]');
      Exit;
    End;
  End;
  pFreeAndNil(frmMandaeDocumentosIntegrados);
end;

procedure TfrmMandaeEnvioEncomendas.btnEnviarDocumentosClick(Sender: TObject);
begin
  Try
    frmGravando := TfrmGravando.Create(Self);
    frmGravando.fExecutarAcao := fIntegrarComMandae;
    frmGravando.lblGravando.Caption := 'Aguarde, integrando com Mandaê...';
    frmGravando.ShowModal;
  Finally
    If Assigned(frmGravando) Then
      FreeAndNil(frmGravando);
  End;

  if FblnIntegracaoPeloRomaneio then
    Close;
end;

function TfrmMandaeEnvioEncomendas.fIntegrarComMandae(pgbProgresso: TcxProgressBar): Boolean;
  var
    LObjMandaeWS             : TMandaeWS;
    LObjMandaeJSONBuilder    : TMandaeJSONBuilder;
    LintCodigoRetorno        : Integer;
    LstrMensagemRetorno      : string;
    LbnlIntegracaoComSucesso : Boolean;
begin
  inherited;

  LObjMandaeWS          := TMandaeWS.Create;
  LObjMandaeJSONBuilder := TMandaeJSONBuilder.Create;

  Try
    Try
      LbnlIntegracaoComSucesso := True;

      pgbProgresso.Properties.Max := FcdsDocumentos.RecordCount;
      pgbProgresso.Position := 0;

      FcdsDocumentos.DisableControls;
      FcdsDocumentos.First;
      while not FcdsDocumentos.Eof do
      Begin
        LObjMandaeJSONBuilder.strDocumento        := FcdsDocumentos.FieldByName('MAN_NUMDOC').AsString;
        LObjMandaeJSONBuilder.strEspecieDocumento := FcdsDocumentos.FieldByName('MAN_ESPDOC').AsString;
        LObjMandaeJSONBuilder.strCodigoEmpresa    := FcdsDocumentos.FieldByName('MAN_CODEMP').AsString;
        LObjMandaeJSONBuilder.strCodigoRastreio   := FcdsDocumentos.FieldByName('MAN_CODRAS').AsString;

        LObjMandaeWS.fComunicar(tsAdicionarEncomenda, LintCodigoRetorno, LstrMensagemRetorno, LObjMandaeJSONBuilder.fGerarJSONParaEnvioEncomendas);

        FcdsDocumentos.Edit;
        FcdsDocumentos.FieldByName('MAN_CODINT').AsInteger := LintCodigoRetorno;

        if LintCodigoRetorno <> 201 then
          LbnlIntegracaoComSucesso := False;

        FcdsDocumentos.FieldByName('MAN_MENINT').AsString  := LstrMensagemRetorno;
        FcdsDocumentos.Post;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        FcdsDocumentos.Next;
      End;

      pgbProgresso.Position := 0;

      fStartTransaction;
      FcdsDocumentos.First;
      while not FcdsDocumentos.Eof do
      Begin
        FObjMandaeRepositorio.pAtualizaRetornoDaIntegracao(FcdsDocumentos.FieldByName('AUTOINCREM').AsString,
                                                           FcdsDocumentos.FieldByName('MAN_CODINT').AsInteger ,
                                                           FcdsDocumentos.FieldByName('MAN_MENINT').AsString);

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

        FcdsDocumentos.Next;
      End;
      fCommit;

      FcdsDocumentos.EnableControls;
    Finally
      FreeAndNil(LObjMandaeJSONBuilder);
      FreeAndNil(LObjMandaeWS);
    End;

    pCarregarDocumentos;

    if LbnlIntegracaoComSucesso then
      fMensagem('', 'Integrações realizadas com sucesso!', ['&Ok'])
    else
      fMensagem('', FstrMensagemRetornoErro, ['&Ok']);

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message,'');
    End;
  End;

end;

procedure TfrmMandaeEnvioEncomendas.FormCreate(Sender: TObject);
begin
  inherited;
  FObjMandaeRepositorio      := TMandaeRepositorio.Create;
  FcdsDocumentos             := TUniClientDataSet.Create(nil);
  FblnIntegracaoPeloRomaneio := False;
end;

procedure TfrmMandaeEnvioEncomendas.FormDestroy(Sender: TObject);
begin
  if Assigned(FObjMandaeRepositorio) then
    FreeAndNil(FObjMandaeRepositorio);

  if Assigned(FcdsDocumentos) then
    FreeAndNil(FcdsDocumentos);

  inherited;
end;

procedure TfrmMandaeEnvioEncomendas.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    btnEnviarDocumentos.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    btnConsultarEnviados.Click;
  End;
end;

procedure TfrmMandaeEnvioEncomendas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarDocumentos;
end;

procedure TfrmMandaeEnvioEncomendas.pCarregarDocumentos;
begin
  if not FblnIntegracaoPeloRomaneio then
  Begin
    FcdsDocumentos          := FObjMandaeRepositorio.fListarDocumentosPendentes(VS_strCodEmp);
    FstrMensagemRetornoErro := 'Ocorreu algum problema na integração!';
  End
  Else
    FstrMensagemRetornoErro := 'Ocorreu algum problema na integração. Para rever os documentos com problemas vá até '+
        'Relatórios > Relatórios de Cadastros > Etiquetas > Despacho de Mercadorias - Envio de Encomendas Mandaê!';

  dtsDocumentos.DataSet := FcdsDocumentos;
end;

end.
