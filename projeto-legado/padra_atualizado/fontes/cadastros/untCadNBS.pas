unit untCadNBS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, DBMemoFocus, Vcl.Mask, DBEditFocus, Uni, Data.DB;

type
  TfrmCadNBS = class(TfrmPaiCad)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodNBS: TDBEditFocus;
    dbeDescr: TDBMemoFocus;
    dtsDados: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure dtsDadosDataChange(Sender: TObject; Field: TField);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    qryCadNBS: TUniQuery;
  public
    { Public declarations }
  end;

var
  frmCadNBS: TfrmCadNBS;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untFuncIns;

{$R *.dfm}

procedure TfrmCadNBS.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela       := 'CADNBS';
  strNomeCampo        := 'NBS_CODIGO';
  qryTabela           := fCriaQuery(Self);
  qryCadNBS           := fCriaQuery(Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsDados.DataSet    := qryTabela;
  dbeCodNBS.Enabled   := False;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNBS;
end;

procedure TfrmCadNBS.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NBS_CODIGO');
  stlCampos.Add('NBS_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NBS_CODIGO');
  stlCamInd.Add('NBS_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadNBS.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNBS.Enabled := False;
  pSetFocus(dbeDescr);
end;

procedure TfrmCadNBS.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadNBS.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadNBS.btnGravarClick(Sender: TObject);
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
        pMensagensErro(E.Message, '[untCadNBS.btnGravarClick]');
      End;
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadNBS.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodNBS);
end;

procedure TfrmCadNBS.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
  arrNBS: TConsultasArray;
begin
  chrKey := '/';
  fPesqNomenclaturaDeServicos(Self, nil, nil, qryTabela, chrKey, arrNBS);
end;

procedure TfrmCadNBS.dtsDadosDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbeCodNBS.Enabled := (qryTabela.State = dsInsert);
end;

function TfrmCadNBS.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  qryAux : TUniQuery;

  function fExisteCodNBS: Boolean;
  begin
    Result := False;

    If (qryTabela.FieldByName('NBS_CODIGO').OldValue = qryTabela.FieldByName('NBS_CODIGO').NewValue) Then
      Exit;

    qryAux := fCriaQuery(Self);

    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT NBS_CODIGO FROM CADNBS ');
      qryAux.SQL.Add('WHERE NBS_CODIGO = :CODIGO ');
      qryAux.ParamByName('CODIGO').AsString := dbeCodNBS.Text;
      qryAux.Open;

      Result := (qryAux.RecordCount > 0);

    Finally
      FreeAndNil(qryAux);
    End;
  end;

begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodNBS) And (dbeCodNBS.Enabled) Then
    Begin
      If fEmptyStr(dbeCodNBS.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código NBS deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If not (Length(Trim(dbeCodNBS.Text)) = 9) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código NBS incompleto!', ['&Ok']);
        Result := False;
      End
      Else If fExisteCodNBS Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um registro com esses código. Verifique !', ['&Ok']);
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

procedure TfrmCadNBS.pAfterOpen(DataSet: TDataSet);
begin
  If DataSet.FindField('NBS_CODIGO') <> nil Then
    TStringField(DataSet.FieldByName('NBS_CODIGO')).EditMask := '9.9999.99.99;0;_';
end;

end.
