unit untFatManApontamentoHoras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, MemoFocus,
  ComboBoxFocus, Uni, UniClientDataSet, untConsertoEquipamento, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons;

type
  TfrmFatManApontamentoHoras = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    GroupBox1: TGroupBox;
    pnlNOSCli: TPanel;
    lblNumero: TLabel;
    lblClient: TLabel;
    edtNumero: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlDadEqu: TPanel;
    lblEquipa: TLabel;
    lblMarca_: TLabel;
    lblVoltag: TLabel;
    lblNSerie: TLabel;
    lblNumPat: TLabel;
    lblDadFab: TLabel;
    lblDefeit: TLabel;
    edtCodEqu: TEditFocus;
    edtDesEqu: TEditFocus;
    edtDesMar: TEditFocus;
    edtVoltag: TEditFocus;
    edtNumPat: TEditFocus;
    edtDadFab: TEditFocus;
    edtNSerie: TEditFocus;
    edtDefeit: TMemoFocus;
    edtCodMar: TEditFocus;
    GroupBox2: TGroupBox;
    pnlTecnic: TPanel;
    lblTecnic: TLabel;
    edtSenTec: TEditFocus;
    edtNomTec: TEditFocus;
    pnlFase: TPanel;
    lblEstPrd: TLabel;
    cmbFases: TComboBoxFocus;
    btnInicio: TcxButton;
    btnTermino: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbFasesExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnInicioClick(Sender: TObject);
    procedure btnTerminoClick(Sender: TObject);
    procedure cmbFasesChange(Sender: TObject);
  private
    { Private declarations }
    qryConOpe: TUniQuery;
    procedure pCarregaTecnico;
    procedure pCarregaComboFases;
    procedure pCarregaDadosOS;
    function fVerificaApontamentoAberto(aCodApo: String = ''): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNumero,
    strCodEmp: String;
    objConEquOS: TConEqu;
  end;

implementation

uses  untFuncoesSimples, untConsultas, untPesqAux;

{$R *.dfm}

{ TfrmFatManApontamentoHoras }

procedure TfrmFatManApontamentoHoras.cmbFasesChange(Sender: TObject);
begin
  inherited;
  if fEmptyStr(fVerificaApontamentoAberto(fCampoTabela('APO_CODAPO', 'CADAPO', ['APO_DESCRI'], [cmbFases.Text], False))) then
  begin
    btnInicio.TabOrder  := 1;
    btnTermino.TabOrder := 2;
  end
  else
  begin
    btnInicio.TabOrder  := 2;
    btnTermino.TabOrder := 1;
  end;
end;

procedure TfrmFatManApontamentoHoras.cmbFasesExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(cmbFases, True);
end;

procedure TfrmFatManApontamentoHoras.btnInicioClick(Sender: TObject);
var
  LCodFase,
  LApontamentoAberto: String;
begin
  inherited;
  if (not fVerificaCampos) then
  begin
    pSetFocus(edtSenTec);
    Exit;
  end;

  if (not fValidaCampos(cmbFases, True)) then
  begin
    pSetFocus(cmbFases);
    Exit;
  end;

  LApontamentoAberto := fVerificaApontamentoAberto;

  if not fEmptyStr(LApontamentoAberto) then
  begin
    if (cmbFases.Text = LApontamentoAberto) then
      fMensagem('ATENÇÃO!', 'Não é possível iniciar o apontamento da fase ' + cmbFases.Text + ' pois há um apontamento ainda não finalizado para esta fase.', ['&Ok'])
    else
      fMensagem('ATENÇÃO!', 'Não é possível iniciar o apontamento da fase ' + cmbFases.Text + ' pois o apontamento da fase ' + LApontamentoAberto + ' ainda não foi finalizado.', ['&Ok']);

    Exit;
  end;

  LCodFase := fCampoTabela('APO_CODAPO', 'CADAPO', ['APO_DESCRI'], [cmbFases.Text], False);
  if (objConEquOS.fGravaApontamento(qryConOpe.FieldByName('OPE_CODOPE').AsString, LCodFase, 'I')) then
    Close;
end;

procedure TfrmFatManApontamentoHoras.btnTerminoClick(Sender: TObject);
var
  LCodFase,
  LCodTec,
  LNomTec: String;
begin
  inherited;
  if (not fVerificaCampos) then
  begin
    pSetFocus(edtSenTec);
    Exit;
  end;

  if (not fValidaCampos(cmbFases, True)) then
  begin
    pSetFocus(cmbFases);
    Exit;
  end;

  LCodFase := fCampoTabela('APO_CODAPO', 'CADAPO', ['APO_DESCRI'], [cmbFases.Text], False);
  LCodTec := fVerificaApontamentoAberto(LCodFase);

  if fEmptyStr(LCodTec) then
  begin
    fMensagem('ATENÇÃO!', 'O apontamento da fase ' + cmbFases.Text + ' ainda não foi iniciado.', ['&Ok']);
    Exit;
  end;

  if (LCodTec <> qryConOpe.FieldByName('OPE_CODOPE').AsString) then
  begin
    LNomTec := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [LCodTec], False);
    fMensagem('ATENÇÃO!', 'Técnico sem permissão para finalizar o apontamento da fase ' + cmbFases.Text + ' pois o mesmo foi iniciado pelo técnico ' + LNomTec + '.', ['&Ok']);
    Exit;
  end;

  if (objConEquOS.fGravaApontamento(qryConOpe.FieldByName('OPE_CODOPE').AsString, LCodFase, 'T')) then
    Close;
end;

procedure TfrmFatManApontamentoHoras.FormCreate(Sender: TObject);
begin
  inherited;
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

procedure TfrmFatManApontamentoHoras.FormDestroy(Sender: TObject);
begin
  inherited;
  pFreeAndNil(qryConOpe);
end;

procedure TfrmFatManApontamentoHoras.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDadosOS;
  pCarregaComboFases;
end;

function TfrmFatManApontamentoHoras.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtSenTec) and (edtSenTec.Visible) then
  begin
    if fEmptyStr(edtSenTec.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O técnico deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else
    begin
      pCarregaTecnico;

      if qryConOpe.FieldByName('OPE_CODOPE').IsNull then
      begin
        fMensagem('ATENÇÃO!', 'Técnico não está cadastrado!', ['&Ok']);
        Result := False;
      end
      else if qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' then
      begin
        fMensagem('ATENÇÃO!', 'Técnico inativo!', ['&Ok']);
        Result := False;
      end;
    end;
  end
  else if (Sender = cmbFases) and (cmbFases.Visible) then
  Begin
    if (fEmptyStr(cmbFases.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'Selecione uma fase!', ['&OK']);
      Result := False;
    end;
  End;
end;

function TfrmFatManApontamentoHoras.fVerificaApontamentoAberto(aCodApo: String = ''): String;
var
  strSQL,
  LCampo: String;
  qryVerifica: TUniQuery;
begin
  Result := '';

  if fEmptyStr(aCodApo) then
    LCampo := 'APO_DESCRI'
  else
    LCampo := 'EQU_CODTEC';

  strSQL := '';
  strSQL := strSQL + ' SELECT ' + LCampo;
  strSQL := strSQL + ' FROM EQUAPO ';
  strSQL := strSQL + ' INNER JOIN CADAPO ON EQUAPO.EQU_CODAPO = CADAPO.APO_CODAPO ';
  strSQL := strSQL + ' WHERE EQU_SEQGER = :SEQGER ';

  if not fEmptyStr(aCodApo) then
    strSQL := strSQL + '     AND EQU_CODAPO = :CODAPO ';

  strSQL := strSQL + '     AND EQU_TIPOPE = "I" ';
  strSQL := strSQL + '     AND NOT EXISTS ( ';
  strSQL := strSQL + '         SELECT E.EQU_SEQGER FROM EQUAPO E ';
  strSQL := strSQL + '         WHERE EQUAPO.EQU_SEQGER = E.EQU_SEQGER ';
  strSQL := strSQL + '             AND EQUAPO.EQU_CODAPO = E.EQU_CODAPO ';
  strSQL := strSQL + '             AND E.EQU_TIPOPE = "T" ';
  strSQL := strSQL + '             AND E.EQU_DTAAPO > EQUAPO.EQU_DTAAPO) ';

  qryVerifica := fCriaQuery;

  try
    qryVerifica.SQL.Text := strSQL;
    qryVerifica.ParamByName('SEQGER').AsString := objConEquOS.strAutInc;

    if not fEmptyStr(aCodApo) then
      qryVerifica.ParamByName('CODAPO').AsString := aCodApo;

    qryVerifica.Open;

    Result := qryVerifica.FieldByName(LCampo).AsString;
  finally
    pFreeAndNil(qryVerifica);
  end;
end;

procedure TfrmFatManApontamentoHoras.pCarregaComboFases;
const
  strSQL: String = 'SELECT APO_CODAPO, APO_DESCRI FROM CADAPO ORDER BY APO_DESCRI';
var
  qryFases: TUniQuery;
begin
  qryFases := fCriaQuery;

  try
    qryFases.SQL.Text := strSQL;
    qryFases.Open;

    cmbFases.Items.Clear;

    while not qryFases.Eof do
    begin
      cmbFases.Items.Add(qryFases.FieldByName('APO_DESCRI').AsString);

      qryFases.Next;
    end;
  finally
    pFreeAndNil(qryFases);
  end;
end;

procedure TfrmFatManApontamentoHoras.pCarregaDadosOS;
Var
  cdsDados: TUniClientDataSet;
begin
  edtNumero.Text := objConEquOS.strNumero;
  edtCodCli.Text := objConEquOS.strCodCli;
  edtNomCli.Text := fRetNomCliente(objConEquOS.strCodCli);
  edtCodEqu.Text := objConEquOS.strCodEqu;
  edtDesEqu.Text := fRetNomEquipamentoOs(edtCodEqu.Text);
  edtCodMar.Text := fCampoTabela('EQU_CODMAR', 'CADEQU', ['EQU_CODIGO'], [edtCodEqu.Text], False);
  edtDesMar.Text := fRetNomMarca(edtCodMar.Text);
  edtVoltag.Text := fCampoTabela('EQU_VOLTAG', 'CADEQU', ['EQU_CODIGO'], [edtCodEqu.Text], False);
  edtNSerie.Text := objConEquOS.strNSerie;
  edtNumPat.Text := objConEquOS.strNumPat;
  edtDadFab.Text := objConEquOS.strDadFab;

  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, objConEquOS.cdsDfeEqu);

  cdsDados.First;

  while not cdsDados.Eof do
  begin
    edtDefeit.Lines.Add(cdsDados.FieldByName('CODDFE').AsString + ' - ' + cdsDados.FieldByName('DESDFE').AsString);

    cdsDados.Next;
  end;

  pFreeAndNil(cdsDados);
end;

procedure TfrmFatManApontamentoHoras.pCarregaTecnico;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenTec.Text, True);
  edtNomTec.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
end;

end.
