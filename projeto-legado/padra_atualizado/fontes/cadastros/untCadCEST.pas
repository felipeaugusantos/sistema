unit untCadCEST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, DBCtrls, DBMemoFocus, Mask, DBEditFocus, DB,
  frxClass, frxExportCSVTestabilidade, Uni, EditFocus;

type
  TfrmCadCest = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodCest: TDBEditFocus;
    dbeNCM: TDBEditFocus;
    Label2: TLabel;
    dbeDescr: TDBMemoFocus;
    Label3: TLabel;
    dtsDados: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeNCMKeyPress(Sender: TObject; var Key: Char);
    function dbeNCMChamaCadastro(Key: Word): string;
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodCestExit(Sender: TObject);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    qryCadNcm: TUniQuery;
  public
    strNCM: string;
    strCest: String;
    procedure pInicializaDescricaoCEST;
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncIns;

{$R *.dfm}

procedure TfrmCadCest.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodCest);
end;

procedure TfrmCadCest.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCest.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCest.btnGravarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If fValidacoesBotaoGravarPai Then
  Begin
    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadCest.btnGravarClick]');
      End;
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCest.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodCest);
end;

procedure TfrmCadCest.btnPesquisaClick(Sender: TObject);
var
  chrKey         : Char;
  arrCest        : TConsultasArray;
begin
  {*************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTOS *}
  {**********************************DP*}
  chrKey := '/';
  fPesqCest(Self, Nil, Nil, qryTabela, chrKey, arrCest);
end;

procedure TfrmCadCest.dbeCodCestExit(Sender: TObject);
begin
  inherited;
  pInicializaDescricaoCEST;
end;

procedure TfrmCadCest.pInicializaDescricaoCEST;
begin
  If (qryTabela.State = dsInsert) and fEmptyStr(dbeDescr.Text) Then
    dbeDescr.Text := fCampoTabela('CES_DESCRI', 'CDCEST', ['CES_CDCEST'], [dbeCodCest.Field.AsString])
end;

function TfrmCadCest.dbeNCMChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := TFuncIns.fChamaCadNcm(Key);
end;

procedure TfrmCadCest.dbeNCMKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqNCM(Self.Name, qryCadNcm, Key, arrSel) Then
  Begin
    dbeNCM.Text := qryCadNcm.FieldByName('NCM_CODNCM').AsString;
    If fValidaCampos(dbeNCM) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCest.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela        := 'CDCEST';
  strNomeCampo         := 'CES_CDCEST';
  qryTabela            := fCriaQuery(Self);
  qryCadNcm            := fCriaQuery(Self);
  dtsDados.DataSet     := qryTabela;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodCest;
  arrCamposChave[1] := dbeNCM;
end;

procedure TfrmCadCest.FormShow(Sender: TObject);
begin
  inherited;
  if (strNCM <> '') Or (strCest <> '') Then
  Begin
    btnIncluirClick(Sender);
    If strNCM <> ''  Then
      dbeNCM.Field.AsString := strNCM;
    If strCest <> '' Then
      dbeCodCest.Field.AsString := strCest;
  End;
end;

function TfrmCadCest.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
   Var
    qryAux : TUniQuery;

  function fExisteCestOuNcm : Boolean;
  begin
    qryAux := fCriaQuery(Self);
    Result := False;
    With qryAux, SQL Do
    Begin
      Add(' SELECT CES_CDCEST, CES_CODNCM');
      Add(' FROM CDCEST ');
      Add(' WHERE CES_CDCEST = :CDCEST AND ');
      Add(' CES_CODNCM =:CODNCM ');
      ParamByName('CODNCM').AsString := dbeNCM.Text;
      ParamByName('CDCEST').AsString := dbeCodCest.Text;
      Open;
      If Not isEmpty Then
        Result := True;
    End;
  end;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeCodCest Then
    Begin
      If fEmptyStr(dbeCodCest.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código CEST deve ser preenchido!', ['&Ok']);
      End
      Else If (qryTabela.State = dsEdit) Then
      Begin
        With qryTabela Do
        Begin
          If((FieldByName('CES_CDCEST').OldValue <> FieldByName('CES_CDCEST').NewValue) Or
            (FieldByName('CES_CODNCM').OldValue <> FieldByName('CES_CODNCM').NewValue)) And
            (fExisteCestOuNcm)  Then
            Begin
              fMensagem('ATENÇÃO!', 'Já existe um registro com esses dados! Favor verificar.', ['&Ok']);
              Result := False;
            End;
        End;
      End;
    End
    Else If Sender = dbeNCM Then
    Begin
      If fEmptyStr(dbeNCM.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código NCM deve ser preenchido!', ['&Ok']);
      End
      Else If fEmptyStr(fRetDescricaoNcm(dbeNCM.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi encontrado cadastro de NCM com o Código informado. '+
          'Verifique o "Cadastro de Nomenclatura Comum do Mercosul (NCM)"!', ['&Ok']);
        Result := False;
      End;
    End
    Else If Sender = dbeDescr Then
    Begin
      If fEmptyStr(dbeDescr.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
      End;
    End;
  End;
  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCest.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CES_CDCEST');
  stlCampos.Add('CES_CODNCM');
  stlCampos.Add('CES_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CES_DESCRI');
  stlCamInd.Add('CES_CDCEST');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
