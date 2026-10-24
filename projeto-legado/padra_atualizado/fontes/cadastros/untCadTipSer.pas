unit untCadTipSer;

interface

uses
  Windows, Classes, Controls, Dialogs, untPaiCad, StdCtrls, Mask, DBCtrls,
  DBEditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTipSer = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    lbl1: TLabel;
    dbeCorIde: TDBEditFocus;
    btnCorFun: TSpeedButton;
    dlgColor: TColorDialog;
    Label3: TLabel;
    dbeQtdPri: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCorFunClick(Sender: TObject);
    procedure dbeCorIdeChange(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryTipSer: TUniQuery;
    dtsDados: TDataSource;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, Graphics, Forms, untPai, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadTipSer.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'TIPSER';
  strNomeCampo  := 'TPS_CODIGO';
  qryTipSer      := fCriarQuery('SELECT * FROM TIPSER', Self);

  qryTipSer.FieldByName('TPS_CODIGO').DisplayLabel := 'Código';
  qryTipSer.FieldbyName('TPS_DESCRI').DisplayLabel := 'Descrição';
  qryTipSer.FieldbyName('TPS_QTDPRI').DisplayLabel := 'Qtd. Máx de Prisma';
  qryTipSer.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryTipSer);
  qryTabela := qryTipSer;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


function TfrmCadTipSer.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeQtdPri) Then
    Begin
      If StrToIntDef(dbeQtdPri.Text, -1) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade Máxima de Prismas deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCorIde) Then
    Begin
      If fEmptyStr(dbeCorIde.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Cor de Identificação deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadTipSer.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TPS_CODIGO');
  stlCampos.Add('TPS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TPS_DESCRI');
  stlCamInd.Add('TPS_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadTipSer.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  pSetFocus(btnIncluir);
end;


procedure TfrmCadTipSer.btnCancelaClick(Sender: TObject);
begin
  inherited;
  btnCorFun.Enabled := FALSE;
end;

procedure TfrmCadTipSer.btnCorFunClick(Sender: TObject);
begin
  inherited;

  dlgColor.Color := StrToIntDef(dbeCorIde.Text,0);
  If (dlgColor.Execute) Then
  Begin
    dbeCorIde.Text := IntToStr(dlgColor.Color);
  End;

end;

procedure TfrmCadTipSer.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTipSer.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  btnCorFun.Enabled := FALSE;
end;

procedure TfrmCadTipSer.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTipSer.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  btnCorFun.Enabled := FALSE;
end;

procedure TfrmCadTipSer.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  qryTipSer.FieldByName('TPS_QTDPRI').AsInteger := 0;

  btnCorFun.Enabled := TRUE;    

end;

procedure TfrmCadTipSer.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCor: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTipoServico(Self, Nil, Nil, qryTabela, chrKey, arrCor) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadTipSer.dbeCorIdeChange(Sender: TObject);
begin
  inherited;
  dbeCorIde.Color := StrToIntDef(dbeCorIde.Text, clWhite);
  dbeCorIde.NormalColor := StrToIntDef(dbeCorIde.Text, clWhite);
end;

procedure TfrmCadTipSer.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  If qryTabela.IsEmpty = False then
    btnCorFun.Enabled := TRUE;
end;

end.
