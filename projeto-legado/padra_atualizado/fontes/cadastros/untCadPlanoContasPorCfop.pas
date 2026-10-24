unit untCadPlanoContasPorCfop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  MaskEditFocus, EditFocus, untTypesSistema, Vcl.DBCtrls, DBEditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.Menus, Vcl.ComCtrls, BitBtnLockedIncrem, Uni, DBGridCitel,
  MemDS, DBAccess;

type
  TfrmCadPlanoContasPorCfop = class(TfrmPaiCad)
    dtsCfoPla: TDataSource;
    dtsCfoPlaGrid: TDataSource;
    pnlCentral: TPanel;
    lbl1: TLabel;
    lblTipo: TLabel;
    Label1: TLabel;
    edtCodClaFis: TDBEditFocus;
    edtPcComIncidencia: TDBEditFocus;
    edtPcSemIncidencia: TDBEditFocus;
    edtDesClaFis: TEditFocus;
    Panel1: TPanel;
    grdCfoPla: TDBGridCitel;
    procedure edtCodClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClaFisExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPcComIncidenciaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPcSemIncidenciaKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure grdCfoPlaKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCfoPla,
    qryCfoPlaGrid: TUniQuery;
    blnUsaPlanco: Boolean;

    procedure qryCfoPlaGridAfterScroll(DataSet: TDataSet);
    procedure pLocateCfoPlaGrid;
    function fRetornaPlanoContabil(strPlaCon: string): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadPlanoContasPorCfop: TfrmCadPlanoContasPorCfop;

implementation

uses untFuncoesSimples, untConsultas, untFuncoes, untFuncoesConsulta,
  Contabilidade.Funcoes;

{$R *.dfm}

function TfrmCadPlanoContasPorCfop.fRetornaPlanoContabil(strPlaCon: string): string;
begin
  if blnUsaPlanco then
    Result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['REPLACE(REPLACE(REPLACE(REPLACE(NCO_CODCON, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False)
  else
    Result := fCampoTabela('CON_CODCTA', 'PLACON', ['REPLACE(REPLACE(REPLACE(REPLACE(CON_CODCTA, " ", ""), ".", ""), ":", ""), "\t", "")'], [fSemMascaraPlaNco(strPlaCon)], False);
end;

function TfrmCadPlanoContasPorCfop.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtPcComIncidencia) Then
    Begin
      If fEmptyStr(edtPcComIncidencia.Text) Then
      Begin
        edtPcComIncidencia.Clear;
      End
      Else
      Begin
        If fEmptyStr(fRetornaPlanoContabil(edtPcComIncidencia.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano ' + IIF(blnUsaPlanco, '', 'de contas ') + 'contábil inexistente!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtPcSemIncidencia) Then
    Begin
      If fEmptyStr(edtPcSemIncidencia.Text) Then
      Begin
        edtPcSemIncidencia.Clear;
      End
      Else
      Begin
        If fEmptyStr(fRetornaPlanoContabil(edtPcSemIncidencia.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano ' + IIF(blnUsaPlanco, '', 'de contas ') + 'contábil inexistente!', ['&OK']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadPlanoContasPorCfop.qryCfoPlaGridAfterScroll(DataSet: TDataSet);
begin

  if not qryCfoPlaGrid.IsEmpty then
  begin
    qryCfoPla.Close;
    qryCfoPla.SQL.Text := 'SELECT * FROM CFOPLA WHERE AUTOINCREM = :AUTOINCREM';
    qryCfoPla.ParamByName('AUTOINCREM').AsString := qryCfoPlaGrid.FieldByName('AUTOINCREM').AsString;
    qryCfoPla.Open;
  end;

end;

procedure TfrmCadPlanoContasPorCfop.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodClaFis);
  grdCfoPla.Enabled := False;
end;

procedure TfrmCadPlanoContasPorCfop.btnCancelaClick(Sender: TObject);
begin
  inherited;
  qryCfoPlaGrid.Refresh;
  grdCfoPla.Enabled := True;
end;

procedure TfrmCadPlanoContasPorCfop.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFornecedores.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLocateCfoPlaGrid;
end;

procedure TfrmCadPlanoContasPorCfop.pLocateCfoPlaGrid;
var
  strAutInc: string;
begin

  if not qryCfoPla.IsEmpty then
    strAutInc := qryCfoPla.FieldByName('AUTOINCREM').AsString;

  qryCfoPlaGrid.Refresh;
  if not qryCfoPla.IsEmpty then
    qryCfoPlaGrid.Locate('AUTOINCREM', strAutInc, []);

end;

procedure TfrmCadPlanoContasPorCfop.btnGravarClick(Sender: TObject);
begin

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.FieldByName('PLA_CODEMP').AsString := VS_strCodEmp;
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPlanoContasPorCfop.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    pLocateCfoPlaGrid;
    grdCfoPla.Enabled := True;
    fCommit;
  End
  Else
    fRollBack;

end;

procedure TfrmCadPlanoContasPorCfop.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodClaFis);
  grdCfoPla.Enabled := False;
end;

procedure TfrmCadPlanoContasPorCfop.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqPlanoContabilCFOP(Self, qryTabela, chrKey, arrConsulta) Then
  Begin
    edtCodClaFisExit(Sender);
    pSetFocus(btnAlterar);
    pLocateCfoPlaGrid;
  End;
end;

procedure TfrmCadPlanoContasPorCfop.grdCfoPlaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    if not qryCfoPlaGrid.IsEmpty then
      btnAlterarClick(Sender);
end;

procedure TfrmCadPlanoContasPorCfop.edtCodClaFisExit(Sender: TObject);
var
  arrClasFiscal: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodClaFis, edtDesClaFis, arrClasFiscal, fRetNatOpe, Nil, 'da Classificação Fiscal');
end;

procedure TfrmCadPlanoContasPorCfop.edtCodClaFisKeyPress(Sender: TObject; var Key: Char);
var
  arrClasFiscal: TConsultasArray;
begin
  inherited;
  If fPesqCFOP(Self, edtCodClaFis, edtDesClaFis, Nil, Key, arrClasFiscal, False) Then
  Begin
    If fValidaCampos(edtCodClaFis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPlanoContasPorCfop.edtPcComIncidenciaKeyPress(Sender: TObject; var Key: Char);
var
  arrPlaCon: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      try
        if blnUsaPlanco then
        begin
          if fPesqPlanoContabil(Self, edtPcComIncidencia, nil, nil, Key, arrPlaCon) then
          begin
            If fValidaCampos(edtPcComIncidencia, True) Then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end
        else
        begin
          if fPesqPlanoContasContabil(Self, nil, nil, qryConsulta, Key, arrPlaCon) then
          begin
            edtPcComIncidencia.Text := qryConsulta.FieldByName('CON_CODCTA').AsString;
            if fValidaCampos(edtPcComIncidencia, True) then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end;
      except
        on E: Exception do
          pMensagensErro(E.Message,'');
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCadPlanoContasPorCfop.edtPcSemIncidenciaKeyPress(Sender: TObject; var Key: Char);
var
  arrPlaCon: TConsultasArray;
  qryConsulta: TUniQuery;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    try
      qryConsulta := fCriaQuery;
      try
        if blnUsaPlanco then
        begin
          if fPesqPlanoContabil(Self, edtPcSemIncidencia, nil, nil, Key, arrPlaCon) then
          begin
            If fValidaCampos(edtPcSemIncidencia, True) Then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end
        else
        begin
          if fPesqPlanoContasContabil(Self, nil, nil, qryConsulta, Key, arrPlaCon) then
          begin
            edtPcSemIncidencia.Text := qryConsulta.FieldByName('CON_CODCTA').AsString;
            if fValidaCampos(edtPcSemIncidencia, True) then
              SelectNext(ActiveControl, True, True);
            Key := Char(0);
          end;
        end;
      except
        on E: Exception do
          pMensagensErro(E.Message,'');
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

procedure TfrmCadPlanoContasPorCfop.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela := 'CFOPLA';
  strNomeCampo  := 'AUTOINCREM';

  strSQL            := 'SELECT * FROM CFOPLA WHERE PLA_CODEMP = ' + QuotedStr(VS_strCodEmp);
  qryCfoPla         := fCriarQuery(strSQL, Self);
  qryTabela         := qryCfoPla;
  dtsCfoPla.DataSet := qryCfoPla;

  qryCfoPlaGrid     := fCriarQuery(strSQL, Self);
  qryCfoPlaGrid.AfterScroll := qryCfoPlaGridAfterScroll;
  qryCfoPlaGrid.Open;

  dtsCfoPlaGrid.DataSet := qryCfoPlaGrid;

  blnUsaPlanco := fCfgSpd('USAR_ABREVIACAO_CONTABIL_REG_0500') = 'S';
end;

procedure TfrmCadPlanoContasPorCfop.FormDestroy(Sender: TObject);
begin
  stlCampos.Free;
  stlCamInd.Free;
  stlDesInd.Free;

  inherited;
end;

procedure TfrmCadPlanoContasPorCfop.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PLA_CODCFO');
  stlCampos.Add('PLA_CONCIN');
  stlCampos.Add('PLA_CONSIN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PLA_CODCFO');
  stlDesInd.Add('Class. Fiscal');
end;

end.
