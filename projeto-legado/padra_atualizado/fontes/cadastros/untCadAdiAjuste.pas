unit untCadAdiAjuste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, EditFocus, Uni, StrUtils;

type
  TfrmCadAdiAjuste = class(TfrmPaiCad)
    Label2: TLabel;
    dbeDesAju: TDBEditFocus;
    dtsTabela: TDataSource;
    pnlGeral: TPanel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodAju: TDBEditFocus;
    edtDesAju: TEditFocus;
    Label5: TLabel;
    dbeMesAno: TDBEditFocus;
    Label6: TLabel;
    dbeValAju: TDBEditFocus;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodAjuKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpExit(Sender: TObject);
    procedure dbeCodAjuExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

Var
  frmCadAdiAjuste : TfrmCadAdiAjuste;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untFuncoesConsulta;

{ TfrmCadAdiAjuste }

procedure TfrmCadAdiAjuste.btnCancelaClick(Sender: TObject);
begin
  inherited;
  edtDesAju.Text := fRetDescricaoAjuIcm(dbeCodAju.Text);
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadAdiAjuste.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAdiAjuste.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  edtDesAju.Text := fRetDescricaoAjuIcm(dbeCodAju.Text);
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadAdiAjuste.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadAdiAjuste.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadAdiAjuste.btnIncluirClick(Sender: TObject);
begin
  inherited;
  edtDesAju.Text := '';
  edtNomEmp.Text := '';
end;

procedure TfrmCadAdiAjuste.btnPesquisaClick(Sender: TObject);
var
  arrAjuste : TConsultasArray;
  chrKey : Char;
begin
  chrKey := '/';
  If fPesqAdiAjuste(Self, qryTabela, chrKey, arrAjuste) Then
    pSetFocus(btnAlterar);

  edtDesAju.Text := fRetDescricaoAjuIcm(dbeCodAju.Text);
  edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
end;

procedure TfrmCadAdiAjuste.dbeCodAjuExit(Sender: TObject);
var
  arrAjuste: TConsultasArray;
begin
  pEdtCodSelectExit(dbeCodAju, edtDesAju, arrAjuste, Nil, fRetDescricaoAjuIcm, 'do Ajuste');
end;

procedure TfrmCadAdiAjuste.dbeCodAjuKeyPress(Sender: TObject; var Key: Char);
var
  arrAjuste: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Try
      qryConsulta := fCriaQuery;
      Try
        If fPesqTabelaAjuste(Self, qryConsulta, Key, arrAjuste) Then
        Begin
          dbeCodAju.Text := qryConsulta.FieldByName('AJU_CODAJU').AsString;
          edtDesAju.Text := qryConsulta.FieldByName('AJU_DESAJU').AsString;
          if fEmptyStr(dbeDesAju.Text) then
            dbeDesAju.Field.Text := qryConsulta.FieldByName('AJU_DESAJU').AsString;
          If fValidaCampos(dbeCodAju, True) Then
            SelectNext(ActiveControl, True, True);
          Key := Char(0);
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message,'');
      End;
    Finally
      FreeAndNil(qryConsulta);
    End;
  End;
end;

procedure TfrmCadAdiAjuste.dbeCodEmpExit(Sender: TObject);
var
  arrEmpresa: TConsultasArray;
begin
  pEdtCodSelectExit(dbeCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmCadAdiAjuste.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
var
  arrEmpresa: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(dbeCodEmp, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadAdiAjuste.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadAdiAjuste.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'ADIAPU';
  strNomeCampo        := 'AUTOINCREM';
  qryTabela           := fCriaQuery(Self);
  dtsTabela.DataSet   := qryTabela;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeCodEmp;
  arrCamposChave[1] := dbeCodAju;
  arrCamposChave[2] := dbeMesAno;
end;

function TfrmCadAdiAjuste.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodEmp) Then
    Begin
      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&Ok']);
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(dbeCodEmp.Text);
      End;
    End
    Else If (Sender = dbeCodAju) Then
    Begin
      If fEmptyStr(dbeCodAju.Text) Then
      Begin
      Result := False;
        fMensagem('ATENÇÃO!', 'O Código do Ajuste deve ser preenchido!', ['&Ok']);
      End
      Else
      Begin
        dbeCodAju.Text := dbeCodAju.Text;
        edtDesAju.Text := fRetDescricaoAjuIcm(dbeCodAju.Text);
        if fEmptyStr(dbeDesAju.Text) then
          dbeDesAju.Field.Text := fRetDescricaoAjuIcm(dbeCodAju.Text);
      End;
    End
    Else If (Sender = dbeMesAno) Then
    Begin
      If fEmptyStr(dbeMesAno.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Mês/Ano deve ser preenchido!', ['&Ok']);
      End
      Else
      Begin
        Try
          StrToDate('01/' + LeftStr(dbeMesAno.Text, 2) + '/' + RightStr(dbeMesAno.Text, 4));
        Except
          Result := False;
          fMensagem('ATENÇÃO!', 'Mês/Ano inválido! Formato correto: MMAAAA.', ['&Ok']);
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadAdiAjuste.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('APU_CODEMP');
  stlCampos.Add('APU_CODAJU');
  stlCampos.Add('APU_MESANO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('APU_CODEMP');
  stlCamInd.Add('APU_CODAJU');
  stlCamInd.Add('APU_MESANO');

  stlDesInd.Add('Empresa');
  stlDesInd.Add('Ajuste');
  stlDesInd.Add('Mês/Ano');
end;

end.
