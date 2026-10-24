unit untImpEtiLocalArmazenamentoWms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, cxProgressBar, untGravando,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, untZClient, UniClientDataSet, EditFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCheckBox;

type

  TTipoMarca = (tmMarcar, tmDesmarcar, tmInverter);

  TfrmImpEtiLocalArmazenamentoWms = class(TfrmPai)
    cxgLocalArmazenamentoWmsLevel1: TcxGridLevel;
    cxgLocalArmazenamentoWmsTableView: TcxGridDBTableViewCitel;
    cxgLocalArmazenamentoWms: TcxGridCitel;
    cxgLocalArmazenamentoWmsCODLAR: TcxGridDBColumn;
    cxgLocalArmazenamentoWmsDESLAR: TcxGridDBColumn;
    cxgLocalArmazenamentoWmsQTDETI: TcxGridDBColumn;
    Panel1: TPanel;
    btnAplicarQtde: TBitBtnLocked;
    edtQtdEti: TEditFocus;
    Label2: TLabel;
    cxgLocalArmazenamentoWmsIMPRIMIR: TcxGridDBColumn;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnInverter: TBitBtnLocked;
    btnLazer: TBitBtnLocked;
    btnArgox: TBitBtnLocked;
    Label13: TLabel;
    edtCodLar: TEditFocus;
    edtDesLar: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnLazerClick(Sender: TObject);
    procedure btnAplicarQtdeClick(Sender: TObject);
    procedure edtCodLarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLarExit(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
  private
    cdsLocArm: TZClient;
    cdsRegistros: TUniClientDataSet;
    arrCodLar: TConsultasArray;
    FTipoMarca: TTipoMarca;
    function fGetSQL: String;
    function fGeraRegistros(cxProgress : TcxProgressBar): Boolean;
    function fMarcarProgresso(cxProgress: TcxProgressBar): Boolean;
    function fCdsLocalArmazenamentoVazio: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  end;


implementation

{$R *.dfm}

uses TypesRel, untFuncoesSimples, untFuncoesEtiquetas,
  untFuncoesConsulta, untConsultas, untHelperCitel;

{ TfrmImpEtiLocalArmazenamentoWms }

procedure TfrmImpEtiLocalArmazenamentoWms.btnAplicarQtdeClick(Sender: TObject);
  Var
    strCodLar : String;
begin
  inherited;

  cdsLocArm.qryQuery.Close;
  cdsLocArm.qryQuery.SQL.Clear;
  cdsLocArm.qryQuery.SQL.Add( fGetSQL );
  cdsLocArm.qryQuery.ParamByName('QTDETI').AsInteger := StrToIntDef(edtQtdEti.Text, 1);
  pSetaParam(edtCodLar.Text, arrCodLar, strCodLar, 'CODLAR', cdsLocArm.qryQuery);
  cdsLocArm.fAbreClient(True, 'TfrmImpEtiLocalArmazenamentoWms.FormCreate');

  pSetFocus(cxgLocalArmazenamentoWms);
end;

procedure TfrmImpEtiLocalArmazenamentoWms.btnLazerClick(Sender: TObject);
  Var
    prmDllEtq: TParamDllEtiquetas;
begin
  Try
    cdsLocArm.CheckBrowseMode;
    prmDllEtq := TParamDllEtiquetas.Create;
    cdsRegistros := fCriaClientDatset(cdsLocArm, True, Self);

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGeraRegistros;
    frmGravando.lblGravando.Caption := 'Gerando registros...';
    frmGravando.ShowModal;

    If cdsRegistros.IsEmpty Then
    Begin
      fMensagem('','Marque a quantidade de etiquetas para imprimir!', ['&Ok']);
      Exit;
    End;

    Case TBitBtnLocked(Sender).Tag Of
      0 :  prmDllEtq.tpeTipEtq := tpeLocalArmazenamentoWmsLaser;
      1 :  prmDllEtq.tpeTipEtq := tpeLocalArmazenamentoWmsArgox;
    End;

    prmDllEtq.dtsImpres := cdsRegistros;

    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

  Finally
    cdsLocArm.EnableControls;
    FreeAndNil(frmGravando);
    FreeAndNil(prmDllEtq);
    FreeAndNil(cdsRegistros);
  End;
  cdsLocArm.fAbreClient(True, 'TfrmImpEtiLocalArmazenamentoWms.btnLazerClick');
end;

procedure TfrmImpEtiLocalArmazenamentoWms.btnMarcarClick(Sender: TObject);
begin
  inherited;

  If fCdsLocalArmazenamentoVazio Then
  Begin
    fMensagem('', 'Não existe registro para efetuar essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    Case TBitBtnLocked(Sender).Tag Of
      0: FTipoMarca := tmMarcar;
      1: FTipoMarca := tmDesmarcar;
      2: FTipoMarca := tmInverter;
    End;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fMarcarProgresso;
    frmGravando.lblGravando.Caption := 'Aguarde...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmImpEtiLocalArmazenamentoWms.edtCodLarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLar, edtDesLar, arrCodLar, nil, fRetLocalArmazenamentoWms, 'do local de armazenamento WMS');
end;

procedure TfrmImpEtiLocalArmazenamentoWms.edtCodLarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqLocalArmazenamentoWms(Self, edtCodLar, edtDesLar, nil, key, arrCodLar, False) Then
  Begin
    If fValidaCampos(edtCodLar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmImpEtiLocalArmazenamentoWms.fCdsLocalArmazenamentoVazio: Boolean;
begin
  Result := True;

  If (not cdsLocArm.Active) Then
    Exit;

  If (cdsLocArm.RecordCount = 0) Then
    Exit;

  Result := False;
end;

function TfrmImpEtiLocalArmazenamentoWms.fGeraRegistros(cxProgress: TcxProgressBar): Boolean;
  Var
    intRegis : Integer;
begin
  Result := True;
  cdsLocArm.DisableControls;

  intRegis := 0;
  cdsLocArm.First;
  While not cdsLocArm.Eof Do
  Begin
    If cdsLocArm.FieldByName('IMPRIMIR').AsString = 'S' Then
      intRegis := intRegis + cdsLocArm.FieldByName('QTDETI').AsInteger;
    cdsLocArm.Next;
  End;

  cxProgress.Properties.Max := intRegis;

  cdsLocArm.First;
  While not cdsLocArm.Eof Do
  Begin
    If cdsLocArm.FieldByName('IMPRIMIR').AsString = 'S' Then
    Begin
      For intRegis := 1 to cdsLocArm.FieldByName('QTDETI').AsInteger Do
      Begin
        cdsRegistros.Append;
        cdsRegistros.FieldByName('CODLAR').Value := cdsLocArm.FieldByName('CODLAR').Value;
        cdsRegistros.FieldByName('DESLAR').Value := cdsLocArm.FieldByName('DESLAR').Value;
        cdsRegistros.FieldByName('BARLAR').Value := cdsLocArm.FieldByName('BARLAR').Value;
        cdsRegistros.FieldByName('QTDETI').Value := cdsLocArm.FieldByName('QTDETI').Value;
        cdsRegistros.Post;

        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;
      End;
    End;
    cdsLocArm.Next;
  End;
end;

function TfrmImpEtiLocalArmazenamentoWms.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT "N"        AS IMPRIMIR, ';
  Result := Result + '        LAR_CODLAR AS CODLAR,   ';
  Result := Result + '        LAR_DESLAR AS DESLAR,   ';
  Result := Result + '        LAR_CODLAR AS BARLAR,   ';
  Result := Result + '        :QTDETI    AS QTDETI    ';
  Result := Result + '   FROM CADLAR                  ';
  Result := Result + '  WHERE (1=1)                   ';
  Result := Result + fStrLocate(edtCodLar, arrCodLar, 'LAR_CODLAR', 'CODLAR');
  Result := Result + '  ORDER BY LAR_CODLAR           ';
end;

function TfrmImpEtiLocalArmazenamentoWms.fMarcarProgresso(
  cxProgress: TcxProgressBar): Boolean;
begin
  Try
    Result := True;
    cdsLocArm.DisableControls;
    cdsLocArm.First;
    cxProgress.Properties.Max := cdsLocArm.RecordCount;

    While Not cdsLocArm.Eof Do
    Begin
      cdsLocArm.Edit;

      Case FTipoMarca Of
        tmMarcar    : cdsLocArm.FieldByName('IMPRIMIR').AsString := 'S';
        tmDesmarcar : cdsLocArm.FieldByName('IMPRIMIR').AsString := 'N';
        tmInverter  : cdsLocArm.FieldByName('IMPRIMIR').AsString := IIF(cdsLocArm.FieldByName('IMPRIMIR').AsString = 'S', 'N', 'S');
      End;

      cdsLocArm.Post;

      cdsLocArm.Next;
      cxProgress.pStep;
    End;

  Finally
    cdsLocArm.First;
    cdsLocArm.EnableControls;
  End;
end;

procedure TfrmImpEtiLocalArmazenamentoWms.FormCreate(Sender: TObject);
begin
  inherited;
  cdsLocArm := TZClient.Create(Self);
  cxgLocalArmazenamentoWmsTableView.DataController.DataSource := cdsLocArm.dtsSource;
end;

function TfrmImpEtiLocalArmazenamentoWms.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodLar) Then
    Begin
      pDesmarcaLista(edtCodLar, arrCodLar);
    End
  End;

  If not Result Then
    pSetFocus(Sender);
end;

end.














