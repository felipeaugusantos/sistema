unit DominioSistemas.View.ConsultarDocumentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untLibDominioSistemasPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  MaskEditFocus;

type
  TfrmDominioSistemasConsultarDocumentos = class(TfrmPaiDominioSistemasConfirma)
    gbFiltros: TGroupBox;
    TableView: TcxGridDBTableViewCitel;
    GridCitelLevel1: TcxGridLevel;
    GridCitel: TcxGridCitel;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnConsultar: TBitBtnLocked;
    dsConsulta: TDataSource;
    TableViewAUTOINCREM: TcxGridDBColumn;
    TableViewFIS_NUMDOC: TcxGridDBColumn;
    TableViewFIS_SERIE_: TcxGridDBColumn;
    TableViewFIS_ESPDOC: TcxGridDBColumn;
    TableViewFIS_FORCLI: TcxGridDBColumn;
    TableViewDOM_CODEMP: TcxGridDBColumn;
    TableViewEMP_NOMFAN: TcxGridDBColumn;
    TableViewDOM_TIPCON: TcxGridDBColumn;
    TableViewDOM_ACESSO: TcxGridDBColumn;
    TableViewDOM_TIP_FC: TcxGridDBColumn;
    TableViewDOM_CODOPE: TcxGridDBColumn;
    TableViewDOM_DTPROC: TcxGridDBColumn;
    TableViewDOM_HRPROC: TcxGridDBColumn;
    TableViewDOM_PROTOC: TcxGridDBColumn;
    TableViewDOM_DTADOC: TcxGridDBColumn;
    TableViewDOM_STATUS: TcxGridDBColumn;
    TableViewDOM_STATNF: TcxGridDBColumn;
    btnExportar: TBitBtnLocked;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
    FDadosConsulta: TDataSet ;
    function fConsultaDocumentos: Boolean ;
    procedure pProcessaConsulta ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untDominioSistemasFuncoes, untTypesSistema,
     DominioSistemas.Infra.Repository, untLibDominioSistemasFuncoes,
     untLibDominioSistemasExportarArquivo;

{$R *.dfm}

{ TfrmDominioSistemasConsultarDocumentos }

procedure TfrmDominioSistemasConsultarDocumentos.btnConsultarClick(
  Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  TLibDominioSistemasFuncoes.AguardeExecutarModalA(
    pProcessaConsulta,
    'Consultando...',
    ''
  );

end;

procedure TfrmDominioSistemasConsultarDocumentos.btnExportarClick(
  Sender: TObject);
begin
  inherited;

  TLibDominioSistemasExportarArquivo.fExportarGridParaArquivo(GridCitel);
end;

procedure TfrmDominioSistemasConsultarDocumentos.edtCodEmpKeyPress(
  Sender: TObject; var Key: Char);
var
  LarrEmp: TConsultasArray;
begin
  inherited;
  If VS_FuncoesExternas.fIPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, LarrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


function TfrmDominioSistemasConsultarDocumentos.fConsultaDocumentos: Boolean;
begin
  dsConsulta.Enabled := False ;
  try
    dsConsulta.DataSet := Nil ;

    if Assigned(FDadosConsulta) then
      FreeAndNil(FDadosConsulta) ;

    FDadosConsulta := TMySQLRepository.fConsultaPorPeriodo(StrToDate(mskDtaIni.Text),
                                                           StrToDate(mskDtaFin.Text),
                                                           edtCodEmp.Text) ;

    dsConsulta.DataSet := FDadosConsulta ;
    Result := True ;
  finally
    dsConsulta.Enabled := True ;
  end ;
end;

procedure TfrmDominioSistemasConsultarDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_FuncoesExternas.fIRetEmpresaLogada ;
  edtNomEmp.Text := VS_FuncoesExternas.fIRetNomeEmpresa;
  FDadosConsulta := Nil ;
end;

procedure TfrmDominioSistemasConsultarDocumentos.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FDadosConsulta) then
    FreeAndNil(FDadosConsulta) ;
end;

function TfrmDominioSistemasConsultarDocumentos.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin

    if (Sender = mskDtaIni) Then
    begin
      If Trim(VS_FuncoesExternas.fITiraCaracEspeciais(mskDtaIni.Text)).IsEmpty Then
      Begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      else if not VS_FuncoesExternas.fIDataValida(StrToDate(mskDtaIni.Text)) then
      begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Data Inicial inválida!', ['&O k']);
        Result := False;
      end;
    end

    else If (Sender = mskDtaFin) Then
    begin
      If Trim(VS_FuncoesExternas.fITiraCaracEspeciais(mskDtaFin.Text)).IsEmpty Then
      Begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not VS_FuncoesExternas.fIValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End
      else if not VS_FuncoesExternas.fIDataValida(StrToDate(mskDtaFin.Text)) then
      begin
        VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Data final inválida!', ['&O k']);
        Result := False;
      end;
    end

    Else If (Sender = edtCodEmp) Then
    Begin
      if edtCodEmp.Text <> '000' then
      begin
        If (Not Trim(edtCodEmp.Text).IsEmpty) Then
        Begin
          edtNomEmp.Text := VS_FuncoesExternas.fICampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
          If (Trim(edtNomEmp.Text).IsEmpty) Then
          Begin
            VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
          edtNomEmp.Clear;
      end ;
    End ;

  end ;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDominioSistemasConsultarDocumentos.pProcessaConsulta;
begin
  try
    if fConsultaDocumentos then
      GridCitel.Enabled := True ;

  except
    on E: Exception do
      VS_FuncoesExternas.fIMensagem('ATENÇÃO!', 'Erro: ' + E.Message, ['&O k']);
  end;
end;

end.
