unit untGatilhosImediatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untGatilhosImediatosAddParticipante,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxImageComboBox, Uni, UniClientDataSet,
  cxButtonEdit;

type
  TfrmGatilhosImediatos = class(TfrmPai)
    btnAddParticipantes: TBitBtnLocked;
    cxImageList: TcxImageList;
    gpbGatilhos: TGroupBox;
    cxGridGatilhos: TcxGridCitel;
    cxGridGatilhosDBTableViewCitel1: TcxGridDBTableViewCitel;
    GAT_STATUS: TcxGridDBColumn;
    GAT_CODIGO: TcxGridDBColumn;
    GAT_TITULO: TcxGridDBColumn;
    STATUS: TcxGridDBColumn;
    cxGridGatilhosLevel1: TcxGridLevel;
    gpbParticipantes: TGroupBox;
    cxGridParticipantes: TcxGridCitel;
    cxGridParticipantesDBTableViewCitel1: TcxGridDBTableViewCitel;
    NOMOPE: TcxGridDBColumn;
    NOMGRU: TcxGridDBColumn;
    NOMEMP: TcxGridDBColumn;
    REMOVER: TcxGridDBColumn;
    cxGridParticipantesLevel1: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure REMOVERPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnAddParticipantesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridParticipantesDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridGatilhosDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }

    cdsGatilhos,
    cdsParticipantes: TUniClientDataSet;

    dtsGatilhos,
    dtsParticipantes: TDataSource;

    procedure pCarregaDados;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pCriaClientDataSet;
    procedure pRemoverParticipante;
    procedure pAdicionaParticipante;
    function fParticipanteJahExisteNoCds(frmGatilhosImediatosAddParticipante: TfrmGatilhosImediatosAddParticipante; intCount: Integer): Boolean;
    procedure pAdicionarParticipante(frmGatilhosImediatosAddParticipante: TfrmGatilhosImediatosAddParticipante; intCount: Integer);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

{ TfrmGatilhosImediatos }

procedure TfrmGatilhosImediatos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F1: btnAddParticipantes.Click;
  end;

end;

procedure TfrmGatilhosImediatos.FormResize(Sender: TObject);
begin
  inherited;
  gpbGatilhos.Width := Self.Width div 2;
end;

procedure TfrmGatilhosImediatos.FormShow(Sender: TObject);
begin
  inherited;
  gpbGatilhos.Width := Self.Width div 2;

  pCarregaDados;
  cdsGatilhos.First;
  cdsParticipantes.First;
end;

procedure TfrmGatilhosImediatos.pCarregaDados;
var
  qryGatilhos,
  qryParticipantes: TUniQuery;
begin
  qryParticipantes := fCriaQuery(Self);
  qryGatilhos := fCriaQuery(Self);
  try
    qryParticipantes.Close;
    qryParticipantes.SQL.Text :=
    ' SELECT '+

    '   GATIME_PARTICIPANTES.AUTOINCREM, '+
    '   GAT_CODIGO, '+
    '   GAT_CODOPE, '+
    '   GAT_CODGPO, '+
    '   GAT_CODEMP, '+
    '   OPE_NOMOPE, '+
    '   GPO_DESCRI, '+
    '   IF(IFNULL(GAT_CODOPE, "") <> "", CONCAT(GAT_CODOPE, " - ", OPE_NOMOPE), "") AS NOMOPE, '+
    '   IF(IFNULL(GAT_CODGPO, "") <> "", CONCAT(GAT_CODGPO, " - ", GPO_DESCRI), "") AS NOMGRU, '+
    '   IF(IFNULL(GAT_CODEMP, "") <> "", CONCAT(GAT_CODEMP, " - ", EMP_NOMEMP), "TODAS") AS NOMEMP '+

    ' FROM '+
    '   GATIME_PARTICIPANTES '+

    ' LEFT JOIN CADOPE '+
    '   ON GAT_CODOPE = OPE_CODOPE '+
    ' LEFT JOIN CADGPO '+
    '   ON GAT_CODGPO = GPO_CODGPO '+
    ' LEFT JOIN CADEMP '+
    '   ON GAT_CODEMP = EMP_CODEMP ';

    qryParticipantes.Open;

    if Assigned(cdsParticipantes) then
    begin
      FreeAndNil(dtsParticipantes);
      FreeAndNil(cdsParticipantes);
    end;

    cdsParticipantes := fCriaClientDatset(qryParticipantes);

    qryGatilhos.Close;
    qryGatilhos.SQL.Text :=
    ' SELECT '+

    '   GATIME_GERAL.AUTOINCREM, '+
    '   GAT_CODIGO, '+
    '   GAT_TITULO, '+
    '   GAT_STATUS  '+

    ' FROM '+
    '   GATIME_GERAL ';

    qryGatilhos.Open;

    if Assigned(cdsGatilhos) then
    begin
      FreeAndNil(dtsGatilhos);
      FreeAndNil(cdsGatilhos);
    end;

    cdsGatilhos := fCriaClientDatset(qryGatilhos);

    pCriaClientDataSet;
  finally
    FreeAndNil(qryParticipantes);
    FreeAndNil(qryGatilhos);
  end;
end;

procedure TfrmGatilhosImediatos.pCriaClientDataSet;
begin
  cdsGatilhos.AfterScroll := pAfterScroll;
  cdsGatilhos.AfterPost := pAfterPost;

  dtsParticipantes := fCriaDataSource(cdsParticipantes);
  dtsGatilhos := fCriaDataSource(cdsGatilhos);

  cxGridGatilhosDBTableViewCitel1.DataController.DataSource := dtsGatilhos;
  cxGridParticipantesDBTableViewCitel1.DataController.DataSource := dtsParticipantes;

  cxGridGatilhosDBTableViewCitel1.OptionsView.DataRowHeight := 25;

  cdsGatilhos.IndexFieldNames := 'GAT_STATUS;GAT_TITULO';
  cdsParticipantes.IndexFieldNames := 'OPE_NOMOPE;GPO_DESCRI';
end;

procedure TfrmGatilhosImediatos.REMOVERPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  pRemoverParticipante;
end;

procedure TfrmGatilhosImediatos.pRemoverParticipante;
var
  qryParticipante: TUniQuery;
begin
  inherited;
  if not Assigned(cdsParticipantes) then
    Exit;

  if cdsParticipantes.IsEmpty then
    Exit;

  if not fPergunta(IIF(not fEmptyStr(cdsParticipantes.FieldByName('NOMOPE').AsString), 'Operador: '+cdsParticipantes.FieldByName('NOMOPE').AsString+sLineBreak, '')+
                   IIF(not fEmptyStr(cdsParticipantes.FieldByName('NOMGRU').AsString), 'Grupo: '+cdsParticipantes.FieldByName('NOMGRU').AsString+sLineBreak, '')+
                   'Empresa: '+cdsParticipantes.FieldByName('NOMEMP').AsString+sLineBreak+sLineBreak+
                   'Deseja remover o participante?') then
    Exit;

  qryParticipante := fCriaQuery(Self);
  try
    qryParticipante.Close;
    qryParticipante.SQL.Text :=
    ' DELETE FROM '+
    '   GATIME_PARTICIPANTES '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryParticipante.ParamByName('AUTINC').AsString := cdsParticipantes.FieldByName('AUTOINCREM').AsString;
    qryParticipante.ExecSQL;

    cdsParticipantes.Delete;
  finally
    FreeAndNil(qryParticipante);
  end;
end;

procedure TfrmGatilhosImediatos.pAfterPost(DataSet: TDataSet);
var
  qryGatilhos: TUniQuery;
begin
  inherited;
  qryGatilhos := fCriaQuery(Self);
  try
    qryGatilhos.Close;
    qryGatilhos.SQL.Text :=
    ' UPDATE '+
    '   GATIME_GERAL '+
    ' SET '+
    '   GAT_STATUS = :STATUS '+
    ' WHERE '+
    '   GAT_CODIGO = :CODIGO ';

    qryGatilhos.ParamByName('STATUS').AsString := cdsGatilhos.FieldByName('GAT_STATUS').AsString;
    qryGatilhos.ParamByName('CODIGO').AsString := cdsGatilhos.FieldByName('GAT_CODIGO').AsString;
    qryGatilhos.ExecSQL;
  finally
    FreeAndNil(qryGatilhos);
  end;
end;

procedure TfrmGatilhosImediatos.pAfterScroll(DataSet: TDataSet);
begin
  if cdsGatilhos.IsEmpty then
  begin
    btnAddParticipantes.Enabled := False;
    Exit;
  end;

  btnAddParticipantes.Enabled := True;

  cdsParticipantes.Filtered := False;
  cdsParticipantes.Filter := ' GAT_CODIGO = '+cdsGatilhos.FieldByName('GAT_CODIGO').AsString;
  cdsParticipantes.Filtered := True;
end;

procedure TfrmGatilhosImediatos.btnAddParticipantesClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(pAdicionaParticipante, 'Adicionando Participante', '');
end;

procedure TfrmGatilhosImediatos.pAdicionaParticipante;
var
  frmGatilhosImediatosAddParticipante: TfrmGatilhosImediatosAddParticipante;
  intCount: Integer;
begin
  inherited;

  if not Assigned(cdsGatilhos) then
    Exit;

  if cdsGatilhos.IsEmpty then
    Exit;

  pCriarFormularios(TfrmGatilhosImediatosAddParticipante, frmGatilhosImediatosAddParticipante);
  try
    frmGatilhosImediatosAddParticipante.cdsParticipantes := cdsParticipantes;
    frmGatilhosImediatosAddParticipante.strGatCodigo := cdsGatilhos.FieldByName('GAT_CODIGO').AsString;
    frmGatilhosImediatosAddParticipante.ShowModal;

    if frmGatilhosImediatosAddParticipante.ModalResult = mrOk then
    begin
      for intCount:=0 to Length(frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes)-1 do
      begin
        if fParticipanteJahExisteNoCds(frmGatilhosImediatosAddParticipante, intCount) then
          Continue;

        pAdicionarParticipante(frmGatilhosImediatosAddParticipante, intCount);
      end;
    end;
  finally
    pFreeAndNil(frmGatilhosImediatosAddParticipante);
  end;
end;

procedure TfrmGatilhosImediatos.pAdicionarParticipante(
  frmGatilhosImediatosAddParticipante: TfrmGatilhosImediatosAddParticipante;
  intCount: Integer);
var
  qryParticipante: TUniQuery;
  strAutInc: String;
begin
  qryParticipante := fCriaQuery(Self);
  try
    qryParticipante.Close;
    qryParticipante.SQL.Text :=
    ' INSERT INTO GATIME_PARTICIPANTES '+
    '   (AUTOINCREM, '+
    '    GAT_CODIGO, '+
    '    GAT_CODOPE, '+
    '    GAT_CODGPO, '+
    '    GAT_CODEMP) '+
    ' VALUES '+
    '   (:AUTINC, '+
    '    :CODIGO, '+
    '    :CODOPE, '+
    '    :CODGPO, '+
    '    :CODEMP)';

    strAutInc := fRetAutoIncrem('GATIME_PARTICIPANTES', '001');
    qryParticipante.ParamByName('AUTINC').AsString := strAutInc;
    qryParticipante.ParamByName('CODIGO').AsString := frmGatilhosImediatosAddParticipante.strGatCodigo;

    if frmGatilhosImediatosAddParticipante.paticipantesSelecionados.tipParticipantes = tipOperador then
      qryParticipante.ParamByName('CODOPE').AsString := frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo
    else
      qryParticipante.ParamByName('CODOPE').Value := Null;

    if frmGatilhosImediatosAddParticipante.paticipantesSelecionados.tipParticipantes = tipGrupo then
      qryParticipante.ParamByName('CODGPO').AsString := frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo
    else
      qryParticipante.ParamByName('CODGPO').Value := Null;

    if fEmptyStr(frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text) then
      qryParticipante.ParamByName('CODEMP').Value := Null
    else
      qryParticipante.ParamByName('CODEMP').AsString := frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text;

    qryParticipante.ExecSQL;

    cdsParticipantes.Append;

    cdsParticipantes.FieldByName('AUTOINCREM').AsString := strAutInc;
    cdsParticipantes.FieldByName('GAT_CODIGO').AsString := frmGatilhosImediatosAddParticipante.strGatCodigo;

    if frmGatilhosImediatosAddParticipante.paticipantesSelecionados.tipParticipantes = tipOperador then
    begin
      cdsParticipantes.FieldByName('GAT_CODOPE').AsString := frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo;
      cdsParticipantes.FieldByName('NOMOPE').AsString := frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo + ' - ' +
                                                           fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo]);
    end;

    if frmGatilhosImediatosAddParticipante.paticipantesSelecionados.tipParticipantes = tipGrupo then
    begin
      cdsParticipantes.FieldByName('GAT_CODGPO').AsString := frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo;
      cdsParticipantes.FieldByName('NOMGRU').AsString := frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo + ' - ' +
                                                           fCampoTabela('GPO_DESCRI', 'CADGPO', ['GPO_CODGPO'], [frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo]);
    end;

    if not fEmptyStr(frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text) then
      cdsParticipantes.FieldByName('GAT_CODEMP').AsString := frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text;

    cdsParticipantes.FieldByName('NOMEMP').AsString := IIF(fEmptyStr(frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text),
                                                                     'TODAS',
                                                                     frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text + ' - ' +
                                                                       fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text]));


    cdsParticipantes.Post;
  finally
    FreeAndNil(qryParticipante);
  end;
end;

function TfrmGatilhosImediatos.fParticipanteJahExisteNoCds(frmGatilhosImediatosAddParticipante: TfrmGatilhosImediatosAddParticipante; intCount: Integer): Boolean;
var
  strFiltro: String;
  strFiltroParticipante: String;
begin
  if cdsParticipantes.IsEmpty then
    Exit(False);

  try
    strFiltroParticipante :=
      ' GAT_CODIGO = '+QuotedStr(frmGatilhosImediatosAddParticipante.strGatCodigo)+' AND '+
      ' GAT_CODEMP = '+QuotedStr(frmGatilhosImediatosAddParticipante.edtCodEmpresa.Text);

    if (frmGatilhosImediatosAddParticipante.paticipantesSelecionados.tipParticipantes = tipOperador) and
       (not fEmptyStr(frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo)) then
      strFiltroParticipante := strFiltroParticipante + ' AND GAT_CODOPE = '+QuotedStr(frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo);

    if (frmGatilhosImediatosAddParticipante.paticipantesSelecionados.tipParticipantes = tipGrupo) and
       (not fEmptyStr(frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo)) then
      strFiltroParticipante := strFiltroParticipante + ' AND GAT_CODGPO = '+QuotedStr(frmGatilhosImediatosAddParticipante.paticipantesSelecionados.arrParticipantes[intCount].strCodigo);

    strFiltro := cdsParticipantes.Filter;
    cdsParticipantes.DisableControls;
    cdsParticipantes.Filtered := False;
    cdsParticipantes.Filter := strFiltroParticipante;
    cdsParticipantes.Filtered := True;

    Result := not cdsParticipantes.Isempty;
  finally
    cdsParticipantes.Filtered := False;
    cdsParticipantes.Filter   := strFiltro;
    cdsParticipantes.Filtered := True;
    cdsParticipantes.EnableControls;
  end;
end;

procedure TfrmGatilhosImediatos.cxGridGatilhosDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.Selected then
    ACanvas.Brush.Color := clHighlight;
end;

procedure TfrmGatilhosImediatos.cxGridParticipantesDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.Selected then
    ACanvas.Brush.Color := clHighlight;
end;

end.
