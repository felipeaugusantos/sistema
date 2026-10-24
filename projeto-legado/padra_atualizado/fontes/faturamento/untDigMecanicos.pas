unit untDigMecanicos;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Windows,
  ExtCtrls, EditFocus, QColorLabel, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, untFatDigServico;

type
  TfrmDigMecanicos = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    cdsMecanicos: TUniClientDataSet;
    dtsMecanicos: TDataSource;
    btnCancelaDados: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    cdsMecanicosCODMEC: TStringField;
    cdsMecanicosNOMMEC: TStringField;
    lbl1: TLabel;
    edtCodMec: TEditFocus;
    edtNomMec: TEditFocus;
    pnlAltMecGer: TPanel;
    chkAltMecGer: TCheckBox;
    dbgMecanicos: TDBGridCitel;
    lblObs: TLabel;
    cdsMecanicosOBSMEC: TStringField;
    edtObsMec: TEditFocus;
    cdsTempMec: TUniClientDataSet;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgMecanicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodMecKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure pCarregarMecanicos;
    procedure pInsereMecPadrao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnMecPadrao : Boolean;
    blnViaFatVendas : Boolean; {Devido a utilização dessa tela em outros processos!}
    stlMecanicos: TStringList;
    stlMecanicosDel: TStringList;
    stlMecanicosPadrao: TStringList;
    stlMecanicosObs: TStringList;
    blnUtilizaObs: Boolean;    {Devido a utilização dessa tela em outros processos!}
  end;

var
  frmDigMecanicos: TfrmDigMecanicos;

implementation

uses untConsultas, untfuncoesSimples, untFuncoesAutocenter, untTypesSistema;

{$R *.dfm}

procedure TfrmDigMecanicos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDigMecanicos.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  {Obrigatório preenchimento dos mecânicos}
  if fCfgSis('MECOBR', varBoolean) then
  begin
    if (blnViaFatVendas) and (cdsMecanicos.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!','É obrigatório o preenchimento do(s) mecânico(s)! Favor informa-lo(s)!',['&OK']);
      Self.ModalResult := mrNone;
      Exit;
    end;
  end;

  edtCodMec.Clear;
  edtNomMec.Clear;
  stlMecanicos.Clear;
  stlMecanicosPadrao.Clear;
  stlMecanicosObs.Clear;
  if blnMecPadrao then
  begin
    cdsMecanicos.First;

    While Not cdsMecanicos.Eof Do
    Begin
      stlMecanicosPadrao.Add(cdsMecanicosCODMEC.AsString);
      cdsMecanicos.Next;
    End;
    pInsereMecPadrao;
  end
  else
  begin
    cdsMecanicos.First;
    While Not cdsMecanicos.Eof Do
    Begin
      stlMecanicos.Add(cdsMecanicosCODMEC.AsString);

      if blnUtilizaObs then
        stlMecanicosObs.Add(cdsMecanicosOBSMEC.AsString);

      cdsMecanicos.Next;
    End;
  end;
end;

procedure TfrmDigMecanicos.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodMec.Text) And fValidaCampos(edtCodMec, True) Then
  Begin
    cdsMecanicos.Append;
    cdsMecanicosCODMEC.AsString := edtCodMec.Text;

    if blnUtilizaObs then
      cdsMecanicosOBSMEC.AsString := edtObsMec.Text;

    cdsMecanicosNOMMEC.AsString := edtNomMec.Text;
    cdsMecanicos.Post;
  End;

  edtCodMec.Clear;
  edtNomMec.Clear;

  if blnUtilizaObs then
    edtObsMec.Clear;

  pSetFocus(edtCodMec);
end;

procedure TfrmDigMecanicos.dbgMecanicosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And Not cdsMecanicos.IsEmpty Then
    If fPergunta('Deseja excluir o mecânico "'+cdsMecanicosNOMMEC.AsString + '"?') Then
    begin
      if blnMecPadrao then
        stlMecanicosDel.add(cdsMecanicosCODMEC.AsString);
      cdsMecanicos.Delete;
    end;

  If Key = VK_RETURN Then
    SelectNext(ActiveControl, True, True);

  If Key = VK_ESCAPE Then
    pSetFocus(edtCodMec);
end;

procedure TfrmDigMecanicos.edtCodMecKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self,
                   edtCodMec,
                   edtNomMec,
                   Nil,
                   Key,
                   arrOperador,
                   True,
                   True,
                   False,
                   True) Then
  Begin
    If fValidaCampos(edtCodMec, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigMecanicos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodMec);
end;

procedure TfrmDigMecanicos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMecanicos.CreateDataSet;
  stlMecanicos    := TStringList.Create;
  stlMecanicosPadrao := TStringList.Create;
  stlMecanicosDel    := TStringList.Create;
  stlMecanicosObs    := TStringList.Create;
  blnViaFatVendas    := False;
  blnUtilizaObs      := False;
end;

procedure TfrmDigMecanicos.FormDestroy(Sender: TObject);
begin
  cdsMecanicos.Close;
  stlMecanicos.Destroy;
  stlMecanicosPadrao.Destroy;
  stlMecanicosDel.Destroy;
  stlMecanicosObs.Destroy;
  inherited;
end;

procedure TfrmDigMecanicos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And ((ActiveControl) <> edtCodMec) Then
    pSetFocus(edtCodMec)
  Else
    inherited;
end;

procedure TfrmDigMecanicos.FormShow(Sender: TObject);
begin
  inherited;
  edtObsMec.Visible := blnUtilizaObs;
  lblObs.Visible    := blnUtilizaObs;
  fFindColumnByName(dbgMecanicos,'OBSMEC').Visible := blnUtilizaObs;

  if not blnUtilizaObs then
  begin
    pnlFundo.Height := pnlFundo.Height - edtObsMec.Height - lblObs.Height;
  end;

  pCarregarMecanicos;
end;

function TfrmDigMecanicos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If Sender = edtCodMec Then
    Begin
      If Not fEmptyStr(edtCodMec.Text) Then
      Begin
        If Not fExisteMecanico(edtCodMec.Text) Then
        Begin
          Result := False;
          pMensagemOk('Nenhum mecânico encontrado com este código!');
        End
        Else If (cdsMecanicos.Locate('CODMEC',edtCodMec.Text,[])) Then
        Begin
          Result := False;
          fMensagem('', 'Mecânico já foi adicionado!', ['&Ok']);
        End
        Else
        Begin
          If fMecanicoInativo(edtCodMec.Text) then
          Begin
            Result := False;
            fMensagem('', 'Este mecânico está inativo! Verifique o Cadastro de Operadores.', ['&Ok']);
          End
          Else
            edtNomMec.Text := fRetNomeOperador(edtCodMec.Text);
        End;
      End
      Else
      Begin
        pSetFocus(dbgMecanicos);
        blnMudarFoco := False;
      End;

      If Not Result Then
      Begin
        edtCodMec.Clear;
        edtNomMec.Clear;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigMecanicos.pCarregarMecanicos;
Var
  intCnt : Integer;
begin
  cdsMecanicos.EmptyDataSet;
  if blnMecPadrao then
  begin
    For intCnt := 0 To stlMecanicosPadrao.Count -1 Do
    Begin
      cdsMecanicos.Append;
      cdsMecanicosCODMEC.AsString := stlMecanicosPadrao[intCnt];
      cdsMecanicosNOMMEC.AsString := fRetNomeOperador(stlMecanicosPadrao[intCnt]);
      cdsMecanicos.Post;
    End;
  end
  else
  begin
    For intCnt := 0 To stlMecanicos.Count -1 Do
    Begin
      cdsMecanicos.Append;
      cdsMecanicosCODMEC.AsString := stlMecanicos[intCnt];
      cdsMecanicosNOMMEC.AsString := fRetNomeOperador(stlMecanicos[intCnt]);

      if (stlMecanicosObs.Count = stlMecanicos.Count) and blnUtilizaObs then
        cdsMecanicosOBSMEC.AsString := Copy(stlMecanicosObs[intCnt],1,100);

      cdsMecanicos.Post;
    End;
  end;
end;

procedure TfrmDigMecanicos.pInsereMecPadrao;
var
  intServico, intCount: integer;
  strCodMec: String;
  stlTempMecanico: TStringList;
begin

  stlTempMecanico := TStringList.Create;
  For intServico := 1 To 30 Do
  begin
    stlTempMecanico.Clear;
    cdsTempMec.EmptyDataSet;

    strCodMec := frmFatDigServico.fGetMecanico(intServico.tostring);
    stlTempMecanico.CommaText := strCodMec;

    cdsMecanicos.First;
    While not cdsMecanicos.eof Do
    Begin
      cdsTempMec.Append;
      cdsTempMec.FieldByName('CODMEC').AsString := cdsMecanicosCODMEC.AsString;
      cdsTempMec.Post;
      cdsMecanicos.next;
    End;

    For intCount := 0 To stlTempMecanico.Count -1 Do
    Begin
      if not cdsTempMec.Locate('CODMEC',stlTempMecanico[intCount],[]) then
      begin
        cdsTempMec.Append;
        cdsTempMec.FieldByName('CODMEC').AsString := stlTempMecanico[intCount];
        cdsTempMec.Post;
      end;
    End;

    For intCount := 0 To stlMecanicosDel.Count -1 Do
    Begin
      if cdsTempMec.Locate('CODMEC', stlMecanicosDel[intCount],[]) then
        cdsTempMec.delete;
    End;

    stlTempMecanico.clear;
    cdsTempMec.First;
    While Not cdsTempMec.Eof Do
    Begin
      stlTempMecanico.Add(cdsTempMec.FieldByName('CODMEC').AsString);
      cdsTempMec.Next;
    End;

    frmFatDigServico.pSetMecanico(intServico.tostring, stlTempMecanico.CommaText);
  end;
   FreeAndNil(stlTempMecanico);
end;

end.

