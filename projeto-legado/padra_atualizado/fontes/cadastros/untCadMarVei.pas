unit untCadMarVei;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadMarVei = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDesMar: TDBEditFocus;
    dbeCodMar: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryMarVei: TUniQuery;
    dtsDados: TDataSource;
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses Forms, untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadMarVei.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'MARVEI';
  strNomeCampo  := 'MAR_CODMAR';
  qryMarVei      := fCriarQuery('SELECT * FROM MARVEI', Self);

  qryMarVei.FieldByName('MAR_CODMAR').DisplayLabel := 'Código';
  qryMarVei.FieldbyName('MAR_DESMAR').DisplayLabel := 'Descrição';
  qryMarVei.FieldByName('AUTOINCREM').Visible := False;

  dtsDados  := fCriaDataSource(qryMarVei);
  qryTabela := qryMarVei;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMar;
end;


function TfrmCadMarVei.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodMar) Then
    Begin
      If (fEmptyStr(dbeCodMar.Text)) And (dbeCodMar.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Marca deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesMar) Then
    Begin
      If fEmptyStr(dbeDesMar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Marca deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadMarVei.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MAR_CODMAR');
  stlCampos.Add('MAR_DESMAR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MAR_DESMAR');
  stlCamInd.Add('MAR_CODMAR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Marca');
end;

procedure TfrmCadMarVei.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMarVei.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMarVei.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadMarVei.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMarVei.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMar, dbeDesMar, False)
  Else
    pHabilitaCodigo(dbeCodMar, dbeCodMar, True);

end;

procedure TfrmCadMarVei.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrMarca: TConsultasArray;
begin
  chrKey := '/';
  If fPesqMarcaVeiculo(Self, Nil, Nil, qryTabela, chrKey, arrMarca) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadMarVei.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMar, dbeDesMar, False);
end;

end.
