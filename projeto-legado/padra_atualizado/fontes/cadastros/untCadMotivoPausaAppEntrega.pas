unit untCadMotivoPausaAppEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, DBEditFocus,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCadMotivoPausaAppEntrega = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

procedure TfrmCadMotivoPausaAppEntrega.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadMotivoPausaAppEntrega.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  inherited;

  if blnExcluiu then
    fCommit
  else
    fRollback;

  pLimparCampos;
  qryTabela.Close;
end;

procedure TfrmCadMotivoPausaAppEntrega.btnGravarClick(Sender: TObject);
begin
  blnGravou := False;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    if blnGravou then
    begin
      qryTabela.Edit;
      qryTabela.FieldByName('OCR_MOTPAR').AsString := 'S';
      qryTabela.Post;

      fCommit;
    end
    else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[untCadMotivoPausaAppEntrega.btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadMotivoPausaAppEntrega.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimparCampos;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadMotivoPausaAppEntrega.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrOcr: TConsultasArray;
begin
  chrKey := '/';
  If fPesqMotivoPausa(Self, Nil, Nil, qryTabela, chrKey, arrOcr) Then
    pSetFocus(btnAlterar);

end;

function TfrmCadMotivoPausaAppEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If Sender = dbeCodigo Then
    Begin
      If Not blnUsaProCodigo Then
      Begin
        If fEmptyStr(dbeCodigo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o Código do Motivo.', ['&Ok']);
          Result := False;
        End
        Else If (fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) And
                (Not fCodigoOcoRomDisponivel(dbeCodigo.Text, 'S')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este código de motivo já está sendo utilizado em outro cadastro.', ['&Ok']);
          Result := False;
        End
        Else If Length(dbeCodigo.Text) < 5 Then
        Begin
          fMensagem('ATENÇÃO!', 'Quantidade de caracteres inválida no campo Código.', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If Sender = dbeDescri Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a Descrição do Motivo.', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

End;


procedure TfrmCadMotivoPausaAppEntrega.FormCreate(Sender: TObject);
begin
  qryTabela := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  inherited;

  strNomeTabela := 'OCOROM';
  strNomeCampo  := 'OCR_CODIGO';
end;

procedure TfrmCadMotivoPausaAppEntrega.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabela);
  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
end;

procedure TfrmCadMotivoPausaAppEntrega.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('OCR_CODIGO');
  stlCampos.Add('OCR_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('OCR_DESCRI');
  stlCamInd.Add('OCR_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
