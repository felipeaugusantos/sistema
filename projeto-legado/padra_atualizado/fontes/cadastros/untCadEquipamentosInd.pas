unit untCadEquipamentosInd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, untConsultas, untFuncoesSimples, untTypesSistema;

type
  TfrmCadEquipamentosInd = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodEqp: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    dtsTabela: TDataSource;
    Label3: TLabel;
    dbeCapaci: TDBEditFocus;
    Label4: TLabel;
    dbeCusHor: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure pAfterScroll(Dataset: TDataset);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

{$R *.dfm}

procedure TfrmCadEquipamentosInd.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodEqp, dbeDescri, False);
end;

procedure TfrmCadEquipamentosInd.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEquipamentosInd.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEquipamentosInd.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[TfrmCadEquipamentosInd.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEquipamentosInd.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodEqp, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodEqp, dbeCodEqp, True);

end;

procedure TfrmCadEquipamentosInd.btnPesquisaClick(Sender: TObject);
  Var
    arrEQP : TConsultasArray;
    chrKey   : Char;
Begin
  chrKey := '/';
  if fPesqEquipamentosInd(Self, Nil, Nil, qryTabela, chrKey, arrEQP) then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadEquipamentosInd.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'CADEQP';
  strNomeCampo      := 'EQP_CODEQP';
  qryTabela         := fCriaQuery(Self);
  dtsTabela.DataSet := qryTabela;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodEqp;

  qryTabela.AfterScroll := pAfterScroll;
end;

procedure TfrmCadEquipamentosInd.pAfterScroll(Dataset: TDataset);
begin
  TFloatField(Dataset.FieldByName('EQP_CAPACI')).DisplayFormat := '#0.0000';
  TFloatField(Dataset.FieldByName('EQP_CUSHOR')).DisplayFormat := '#0.0000';
end;

procedure TfrmCadEquipamentosInd.FormShow(Sender: TObject);
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

function TfrmCadEquipamentosInd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodEqp) Then
    Begin
      If (fEmptyStr(dbeCodEqp.Text)) And (dbeCodEqp.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do Equipamento deve ser preenchido!', ['&Ok']);
      End
      Else If blnBuscaPorChave Then
      Begin

      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição do Equipamento deve ser preenchida!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeCapaci) Then
    Begin
      If fEmptyStr(dbeCapaci.Text) Then
      Begin
        dbeCapaci.Field.Value := 0;
      End;

      If fStrToFloat(dbeCapaci.Text) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A Capaciadde do Equipamento deve ser maior ou igual a zero!');
      End;

    End

    Else If (Sender = dbeCusHor) Then
    Begin
      If fEmptyStr(dbeCusHor.Text) Then
      Begin
        dbeCusHor.Field.Value := 0;
      End;

      If fStrToFloat(dbeCusHor.Text) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A Custo/Hora do Equipamento deve ser maior ou igual a zero!');
      End;

    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadEquipamentosInd.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

end.
