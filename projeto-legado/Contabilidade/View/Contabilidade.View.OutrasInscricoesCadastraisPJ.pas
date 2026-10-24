unit Contabilidade.View.OutrasInscricoesCadastraisPJ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ComCtrls, Vcl.CheckLst, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxProgressBar,
  Uni, Contabilidade.View.TfrmPaiContabilidade, EditFocus;

type
  TfrmOutrasInscricoesCadastraisPJ = class(TfrmPaiContabilidade)
    pgcDados: TPageControl;
    tbsDados: TTabSheet;
    cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDados: TcxGridCitel;
    cxgDadosDBTableViewCitelCPJ_CODEMP: TcxGridDBColumn;
    cxgDadosDBTableViewCitelEMP_NOMEMP: TcxGridDBColumn;
    cxgDadosDBTableViewCitelCPJ_CODINS: TcxGridDBColumn;
    cxgDadosDBTableViewCitelINS_DESCRI: TcxGridDBColumn;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDesIns: TEditFocus;
    edtCodIns: TEditFocus;
    Label4: TLabel;
    btnAdicionar: TBitBtnLocked;
    dtsDados: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodInsKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDadosDBTableViewCitelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
    qryDados : TUniQuery;
    procedure pInsereDados(strCodEmp, strCodIns: string);
    procedure pDeletaDados(strCodEmp, strCodIns: string);
    procedure pCarregaDados;
    function fInscJaInformadaNaEmpresa(strCodEmp, strCodIns: string): boolean;
  public
    { Public declarations }
  end;

var
  frmOutrasInscricoesCadastraisPJ: TfrmOutrasInscricoesCadastraisPJ;

implementation

uses
  StrUtils, untFuncoesSimples, untConsultas, untTypesSistema, Contabilidade.Consultas;

{$R *.dfm}

procedure TfrmOutrasInscricoesCadastraisPJ.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos then
    exit;

  if fInscJaInformadaNaEmpresa(edtCodEmp.Text, edtCodIns.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Inscrição e empresa já cadastradas!', ['&Ok']);
    exit;
  end;

  pInsereDados(edtCodEmp.Text, edtCodIns.Text);

  pCarregaDados;

  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodIns.Clear;
  edtDesIns.Clear;
  pSetFocus(edtCodEmp);
end;

procedure TfrmOutrasInscricoesCadastraisPJ.cxgDadosDBTableViewCitelKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Delete) and (not qryDados.IsEmpty) then
  begin
    if (fMensagem('', 'Deseja remover o registro selecionado?', ['&Sim', '&Não'], 2) = 1) Then
    begin
      pDeletaDados(qryDados.FieldByName('CPJ_CODEMP').AsString, qryDados.FieldByName('CPJ_CODINS').AsString);
      pCarregaDados;
    end;
  end;
end;

procedure TfrmOutrasInscricoesCadastraisPJ.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmOutrasInscricoesCadastraisPJ.edtCodInsKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCon: TConsultasArray;
begin
  inherited;
  If fPesqInscricoesCadastrais(Self, edtCodIns, edtDesIns, Nil, Key, arrCon) Then
  Begin
    If fValidaCampos(edtCodIns) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmOutrasInscricoesCadastraisPJ.fInscJaInformadaNaEmpresa(strCodEmp,
  strCodIns: string): boolean;
  var
    qryExists : TUniQuery;
begin
  qryExists := fCriaQuery(Self);
  try
    qryExists.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryExists.SQL.Add('   FROM OUICPJ ');
    qryExists.SQL.Add('  WHERE CPJ_CODINS = :CODINS ');
    qryExists.SQL.Add('    AND CPJ_CODEMP = :CODEMP ');
    qryExists.ParamByName('CODINS').AsString := strCodIns;
    qryExists.ParamByName('CODEMP').AsString := strCodEmp;
    qryExists.Open;
    Result := qryExists.FieldByName('CNT').AsInteger > 0;
    qryExists.Close;
  finally
    FreeAndNil(qryExists);
  end;
end;

procedure TfrmOutrasInscricoesCadastraisPJ.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEmp);
end;

procedure TfrmOutrasInscricoesCadastraisPJ.FormCreate(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  qryDados := fCriaQuery(Self);
end;

procedure TfrmOutrasInscricoesCadastraisPJ.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryDados);
  inherited;
end;

procedure TfrmOutrasInscricoesCadastraisPJ.FormShow(Sender: TObject);
begin
  inherited;
  dtsDados.DataSet := qryDados;
  pCarregaDados;
end;

function TfrmOutrasInscricoesCadastraisPJ.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      begin
        fMensagem('ATENÇÃO!', 'A empresa deve ser preenchida!', ['&OK']);
        Result := False;
      end;
    End
    else if (Sender = edtCodIns) then
    begin
      If (Not fEmptyStr(edtCodIns.Text)) Then
      Begin
        edtDesIns.Text := fCampoTabela('INS_DESCRI', 'OUTINS', ['INS_CODINS'], [edtCodIns.Text], False);
        If (fEmptyStr(edtDesIns.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa inscrição não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      begin
        fMensagem('ATENÇÃO!', 'A inscrição deve ser preenchida!', ['&OK']);
        Result := False;
      end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmOutrasInscricoesCadastraisPJ.pCarregaDados;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(' SELECT CPJ_CODEMP, EMP_NOMEMP, CPJ_CODINS, INS_DESCRI ');
  qryDados.SQL.Add('   FROM OUICPJ ');
  qryDados.SQL.Add('   JOIN CADEMP ON EMP_CODEMP = CPJ_CODEMP ');
  qryDados.SQL.Add('   JOIN OUTINS ON INS_CODINS = CPJ_CODINS ');
  qryDados.SQL.Add('  ORDER BY CPJ_CODEMP, CPJ_CODINS ');
  qryDados.Open;
end;

procedure TfrmOutrasInscricoesCadastraisPJ.pDeletaDados(strCodEmp,
  strCodIns: string);
  var
    qryDelete : TUniQuery;
begin
  qryDelete := fCriaQuery(Self);
  try
    qryDelete.SQL.Text := 'DELETE FROM OUICPJ WHERE CPJ_CODEMP = :CODEMP AND CPJ_CODINS = :CODINS';
    qryDelete.ParamByName('CODEMP').AsString := strCodEmp;
    qryDelete.ParamByName('CODINS').AsString := strCodIns;
    qryDelete.ExecSQL;
  finally
    FreeAndNil(qryDelete);
  end;
end;

procedure TfrmOutrasInscricoesCadastraisPJ.pInsereDados(strCodEmp, strCodIns: string);
  var
    qryInsert : TUniQuery;
begin
  qryInsert := fCriaQuery(Self);
  try
    qryInsert.SQL.Text := 'SELECT * FROM OUICPJ WHERE FALSE';
    qryInsert.Open;
    qryInsert.Insert;
    qryInsert.FieldByName('CPJ_CODEMP').AsString := strCodEmp;
    qryInsert.FieldByName('CPJ_CODINS').AsString := strCodIns;
    qryInsert.Post;
  finally
    FreeAndNil(qryInsert);
  end;
end;

end.
