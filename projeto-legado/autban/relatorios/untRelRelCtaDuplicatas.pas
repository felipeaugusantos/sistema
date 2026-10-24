unit untRelRelCtaDuplicatas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, StdCtrls, EditFocus,
  QColorLabel, Buttons, ExtCtrls, StrUtils, Menus, Uni, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts, BitBtnLockedIncrem, untTypesSistema,
  frxExportCSVTestabilidade, Data.DB, MemDS, DBAccess;

type
  TfrmRelRelCtaDuplicatas = class(TfrmPaiRelatorio)
    pnlFundo: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    pnlTopo: TPanel;
    edtFornecedor: TEditFocus;
    edtEmpresa: TEditFocus;
    edtDesFornecedor: TEdit;
    edtDesEmpresa: TEdit;
    qryDuplicatasRem: TUniQuery;
    qryDuplicatasRemNUMDUP: TStringField;
    qryDuplicatasRemCODEMP: TStringField;
    qryDuplicatasRemCODFOR: TStringField;
    qryDuplicatasRemNOMFOR: TStringField;
    qryDuplicatasRemDTACAD: TDateField;
    qryDuplicatasRemDTAVEN: TDateField;
    qryDuplicatasRemPORCEN: TFloatField;
    qryDuplicatasRemVALDUP: TFloatField;
    qryDuplicatasRemVALTOT: TFloatField;
    qryDuplicatasRemFORPGTO: TStringField;
    qryDuplicatasRemDESCON: TFloatField;
    qryDuplicatasRemOUTENT: TFloatField;
    frxDBDataset1: TfrxDBDataset;
    frxDuplicatasRem: TfrxReport;
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure qryDuplicatasRemFORPGTOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
    {**************************************}
    {* PASSAR O NOME DO BANCO DA SEGUITE  *}
    {* FORMA 033 - BANESPA                *}
    {***********************************AF*}
    strNomBanco: String;
    blnMosPagto: Boolean;
    blnPGG : Boolean;
  end;

var
  frmRelRelCtaDuplicatas: TfrmRelRelCtaDuplicatas;

implementation

uses
  untFuncoesSimples, untConsultas, untCfgRel;

{$R *.dfm}

procedure TfrmRelRelCtaDuplicatas.edtEmpresaExit(Sender: TObject);
begin
  If fEmptyStr(edtEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresa(fStrZero(edtEmpresa.Text,3));

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text)) Then
  Begin
    fMensagem('','Código da empresa não encontrado.',['&O K']);
    pSetFocus(edtEmpresa);
  End;

  inherited;
end;

procedure TfrmRelRelCtaDuplicatas.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRelCtaDuplicatas.edtFornecedorExit(Sender: TObject);
begin
  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(fStrZero(edtFornecedor.Text,8));

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text)) Then
  Begin
    fMensagem('','Código do Fornecedor não encontrado.',['&O K']);
    pSetFocus(edtFornecedor);
  End;

  inherited;
end;

procedure TfrmRelRelCtaDuplicatas.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRelCtaDuplicatas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaConfImpr(qryCfgRel, Self.Name);
  pSetFocus(edtFornecedor);
end;

procedure TfrmRelRelCtaDuplicatas.qryDuplicatasRemFORPGTOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  If Sender.AsString = 'DEP' Then
    Text := 'DEPÓSITO'
  Else
    Text := 'BOLETO';
end;

procedure TfrmRelRelCtaDuplicatas.btnImprimirClick(Sender: TObject);
  Var
    strSQL    : String;
begin
  inherited;
  
  edtFornecedorExit(Sender);
  edtEmpresaExit(Sender);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(PGI_NUMDUP, PGI_PARCEL) AS NUMDUP, ';
  strSQL := strSQL + '  PGI_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  PGI_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '  PGI_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  PGI_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  ((IFNULL(PGI_VALDUP,0) * IFNULL(PGI_VALJUR,0)) /100) AS PORCEN, ';
  strSQL := strSQL + '  PGI_VALDUP AS VALDUP, ';
  strSQL := strSQL + '  PGI_VALDUP + IFNULL(PGI_OUTENT, 0) - IFNULL(PGI_VALDES, 0) AS VALTOT, ';
  strSQL := strSQL + '  PGI_FORPGT AS FORPGTO, ';
  strSQL := strSQL + '  IFNULL(PGI_VALDES, 0) AS DESCON, ';
  strSQL := strSQL + '  PGI_OUTENT AS OUTENT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPGI ';
  strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = PGI_CODFOR ';
  strSQL := strSQL + 'WHERE ';

  If blnPGG Then
    strSQL := strSQL + '  PGI_BCOPGG = PGI_CODBCO AND '
  Else
    strSQL := strSQL + '  PGI_BCOPGG IS NULL AND ';

  strSQL := strSQL + '  PGI_CODBCO = :CODBCO ';

  If Not fEmptyStr(edtFornecedor.Text) Then
    strSQL := strSQL + '  AND PGI_CODFOR = :CODFOR ';

  If Not fEmptyStr(edtEmpresa.Text) Then
    strSQL := strSQL + '  AND PGI_CODEMP = :CODEMP ';

  if MatchStr(LeftStr(strNomBanco,3), ['001']) then
  begin
    if ContainsText(rightStr(StrNomBanco, 8), 'Online') then
      strSQL := strSQL + '  AND PGI_CARTEI = "API" '
    else
      strSQL := strSQL + '  AND PGI_CARTEI = "CNAB" ';
  end;

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  NUMDUP, CODEMP ';

  With qryDuplicatasRem Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strNomBanco,3);

    If Not fEmptyStr(edtFornecedor.Text) Then
      ParamByName('CODFOR').AsString := edtFornecedor.Text;

    If Not fEmptyStr(edtEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtEmpresa.Text;

    Open;

    If Not IsEmpty Then
    Begin

      if blnMosPagto then
      begin
        frxDuplicatasRem.FindObject('frxDBDataset1FORPGTO').Visible := True;
        frxDuplicatasRem.FindObject('Memo7').Visible := True;
        frxDuplicatasRem.FindObject('frxDBDataset1NOMFOR').Width := 120;
      end
      else
      begin
        frxDuplicatasRem.FindObject('frxDBDataset1FORPGTO').Visible := False;
        frxDuplicatasRem.FindObject('Memo7').Visible := False;
        frxDuplicatasRem.FindObject('frxDBDataset1NOMFOR').Width := 180;
      end;

      TfrxMemoView(frxDuplicatasRem.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

      frxDuplicatasRem.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxDuplicatasRem.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
      frxDuplicatasRem.Script.Variables['NOMEFORM'] := '[frmRelRelCtaDuplicatas]';

      If edtFornecedor.Text = '' Then
        frxDuplicatasRem.Script.Variables['FORNECEDOR'] := 'FORNECEDOR: TODOS'
      Else
        frxDuplicatasRem.Script.Variables['FORNECEDOR'] := 'FORNECEDOR: ' + edtFornecedor.Text +  ' - ' + edtDesFornecedor.Text;

      If edtEmpresa.Text = '' Then
        frxDuplicatasRem.Script.Variables['EMPRESA'] := 'EMPRESA: TODAS'
      Else
        frxDuplicatasRem.Script.Variables['EMPRESA'] := 'EMPRESA: ' + edtEmpresa.Text + ' - ' + edtDesEmpresa.Text;

      pPreviewReport(Self.Name, Self.Caption, frxDuplicatasRem);

    End
    Else
    Begin
      fMensagem('','Não há dados para gerar relatório!',['&O K']);
    End;

  End;
  btnImprimir.Enabled := True;
end;

end.

