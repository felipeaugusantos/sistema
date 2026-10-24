unit untConsControleProducao;

interface

uses
  Windows, Classes, Controls, Forms, untPaiConfirma, AppEvnts, Menus, StdCtrls,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, UniClientDataSet, Uni, EditFocus, MaskEditFocus, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, Mask, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsControleProducao = class(TfrmPaiConfirma)
    dbgHorariosDBTableView1: TcxGridDBTableView;
    dbgHorariosLevel1: TcxGridLevel;
    dbgHorarios: TcxGrid;
    pnlFiltro: TPanel;
    rdgFiltro: TRadioGroup;
    grbLegenda: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dtsHorarios: TDataSource;
    cdsHorarios: TUniClientDataSet;
    cdsHorariosFGO_PREVIS: TDateField;
    cdsHorariosFGO_HPREVI: TTimeField;
    cdsHorariosFGO_NUMDOC: TStringField;
    cdsHorariosFGO_NOMCLI: TStringField;
    cdsHorariosFGO_DISPON: TStringField;
    Label5: TLabel;
    Label6: TLabel;
    cdsHorariosFGO_SELECI: TStringField;
    dbgHorariosDBTableView1FGO_PREVIS: TcxGridDBColumn;
    dbgHorariosDBTableView1FGO_HPREVI: TcxGridDBColumn;
    dbgHorariosDBTableView1FGO_NUMDOC: TcxGridDBColumn;
    dbgHorariosDBTableView1FGO_NOMCLI: TcxGridDBColumn;
    dbgHorariosDBTableView1FGO_DISPON: TcxGridDBColumn;
    dbgHorariosDBTableView1FGO_SELECI: TcxGridDBColumn;
    dbgHorariosDBTableView1FGO_RESERV: TcxGridDBColumn;
    cdsHorariosFGO_ESPDOC: TStringField;
    dbgHorariosDBTableView1FGO_ESPDOC: TcxGridDBColumn;
    cdsHorariosFGO_CODEMP: TStringField;
    dbgHorariosDBTableView1FGO_CODEMP: TcxGridDBColumn;
    cdsHorariosFGO_RESERV: TStringField;
    pnlReserv: TPanel;
    lbl1: TLabel;
    edtReserv: TEditFocus;
    pnlDtaPPR: TPanel;
    lblPreVis: TLabel;
    mskDtaPPR: TMaskEditFocus;
    btnDisponivel: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rdgFiltroClick(Sender: TObject);
    procedure dbgHorariosDBTableView1DblClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgHorariosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cdsHorariosAfterScroll(DataSet: TDataSet);
    procedure btnDisponivelClick(Sender: TObject);
    procedure dbgHorariosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDtaPre: TDateTime;
    FNumDoc: String;
    FEspDoc: String;

    function fExisteProgramacaoProducao: Boolean;
    function fRetornaHoraProgramacao: TDateTime;
    function fExisteHorarioProgramado: Boolean;

    procedure pPreencheHorariosProgramados;
    procedure pFiltrar;
    procedure pMarcaDisponivel(blnMarcar: Boolean);
    procedure pDesmarcarDisponivel;
    procedure pMarcarHorario;
    procedure pProgramarHorario;
    procedure pAtualizaFatGor;
    procedure pAtualizaControleProducao;

  protected
    function getDtaPre: TDateTime;
    function getNumDoc: String;
    function getEspDoc: String;

    procedure setDtaPre(const Value: TDateTime);
    procedure setNumDoc(const Value: String);
    procedure setEspDoc(const Value: String);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  public
    { Public declarations }
    dtaHPrevi: TDateTime;
    blnAgendamento: Boolean;
    property dtaDtaPre: TDateTime read getDtaPre write setDtaPre;
    property strNumDoc: String read getNumDoc write setNumDoc;
    property strEspDoc: String read getEspDoc write setEspDoc;
  end;


implementation

uses SysUtils, Variants, Graphics, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsControleProducao.btnConfirmaClick(Sender: TObject);
begin
  dtaHPrevi := fRetornaHoraProgramacao;
  inherited;
end;

procedure TfrmConsControleProducao.btnDisponivelClick(Sender: TObject);
begin
  inherited;
  if fMensagem('ATENÇÃO!', 'Deseja realmente disponibilizar esse horário?', ['&Sim', '&Não']) = 1 then
  begin
    pDesmarcarDisponivel;
    pAtualizaFatGor;
    pAtualizaControleProducao;
  end;
end;

procedure TfrmConsControleProducao.cdsHorariosAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (not fEmptyStr(FNumDoc)) and (not fEmptyStr(FEspDoc)) then
    btnDisponivel.Enabled := (cdsHorariosFGO_NUMDOC.AsString = FNumDoc) and
                             (cdsHorariosFGO_ESPDOC.AsString = FEspDoc);

  edtReserv.Text := cdsHorariosFGO_RESERV.AsString;
  edtReserv.Enabled := fEmptyStr(cdsHorariosFGO_NUMDOC.AsString);
end;

procedure TfrmConsControleProducao.dbgHorariosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strSeleci,
  strDispon,
  strReserv: String;
begin
  inherited;
  strSeleci := VarAsType( dbgHorariosDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgHorariosDBTableView1FGO_SELECI.Index], varString );
  strDispon := VarAsType( dbgHorariosDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgHorariosDBTableView1FGO_DISPON.Index], varString );
  strReserv := VarAsType( dbgHorariosDBTableView1.ViewData.Records[AViewInfo.GridRecord.Index].Values[ dbgHorariosDBTableView1FGO_RESERV.Index], varString );

  If (strDispon = 'N') Or
     ((Not fEmptyStr(strReserv)) And (strSeleci = 'N')) Then
  Begin
    If (Not AViewInfo.Selected) Then
    Begin
      ACanvas.Brush.Color := clBlue;
      ACanvas.Font.Color  := clWhite;
    End
    Else
      ACanvas.Font.Color := clWhite;
  End
  else If strSeleci = 'S' Then // Selecionado
  Begin
    If (Not AViewInfo.Selected) Then
    Begin
      ACanvas.Brush.Color := clGreen;
      ACanvas.Font.Color  := clWhite;
    End
    Else
      ACanvas.Font.Color := clWhite;
  End
end;

procedure TfrmConsControleProducao.dbgHorariosDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  pProgramarHorario;
end;

procedure TfrmConsControleProducao.dbgHorariosDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pProgramarHorario;
  End;
end;

function TfrmConsControleProducao.fExisteHorarioProgramado: Boolean;
var
  blnFiltrado: Boolean;
begin
  Result := False;
  blnFiltrado := rdgFiltro.ItemIndex = 1;

  if blnFiltrado then
    rdgFiltro.ItemIndex := 0;

  if cdsHorarios.Locate('FGO_NUMDOC;FGO_ESPDOC;FGO_CODEMP',VarArrayOf([FNumDoc,FEspDoc,VS_strCodEmp]),[]) then
    Result := True;

  if blnFiltrado then
    rdgFiltro.ItemIndex := 1;    
end;

function TfrmConsControleProducao.fExisteProgramacaoProducao: Boolean;
var
  qryConsulta: TUniQuery;
begin
  Result := false;

  Try
    Try
      qryConsulta := fCriaQuery(Self);
      with qryConsulta do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT SQL_NO_CACHE ');
        SQL.Add('   PPR_HORPPR,');
        SQL.Add('   PPR_RESERV ');
        SQL.Add(' FROM CONPPR ');
        SQL.Add(' WHERE PPR_CODEMP = :CODEMP AND ');
        SQL.Add('       PPR_DTAPPR = :DTAPPR ');
        SQL.Add(' ORDER BY PPR_HORPPR');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('DTAPPR').AsDate   := FDtaPre;        
        Open;
        First;

        cdsHorarios.DisableControls;
        while not Eof do
        begin
          cdsHorarios.Append;
          cdsHorariosFGO_PREVIS.AsDateTime := FDtaPre;
          cdsHorariosFGO_HPREVI.AsDateTime := FieldByName('PPR_HORPPR').AsDateTime;
          cdsHorariosFGO_RESERV.AsString   := FieldByName('PPR_RESERV').AsString;
          cdsHorariosFGO_DISPON.AsString   := IIF(FieldByName('PPR_RESERV').IsNull Or (Not blnAgendamento), 'S', 'N');
          cdsHorariosFGO_SELECI.AsString   := IIF(FieldByName('PPR_RESERV').IsNull Or (Not blnAgendamento), 'N', 'S');
          cdsHorarios.Post;

          qryConsulta.Next
        end;

        Result := Not IsEmpty;
      end;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fExisteProgramacaoProducao]');
      end;
    End;
  Finally
    FreeAndNil(qryConsulta);
    cdsHorarios.EnableControls;
  End;
end;

procedure TfrmConsControleProducao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsHorarios.Close;
end;

procedure TfrmConsControleProducao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsHorarios.CreateDataSet;
  rdgFiltro.ItemIndex := 0;
  dtaHPrevi := 0;
  blnAgendamento := True;  
end;

procedure TfrmConsControleProducao.FormShow(Sender: TObject);
begin
  inherited;
  pnlDtaPPR.Visible := blnAgendamento;
  pnlReserv.Visible := blnAgendamento;
  btnConfirma.Visible := Not blnAgendamento;

  If blnAgendamento Then
    FDtaPre := VS_Date;

  mskDtaPPR.Text := DateToStr(FDtaPre);

  cdsHorarios.EmptyDataSet;

  If fExisteProgramacaoProducao Then
    pPreencheHorariosProgramados;

  If blnAgendamento Then
    pSetFocus(mskDtaPPR);
end;

function TfrmConsControleProducao.fRetornaHoraProgramacao: TDateTime;
begin
  Result := 0;
  if cdsHorarios.Locate('FGO_SELECI', 'S', []) then
    Result := cdsHorariosFGO_HPREVI.AsDateTime;
end;

function TfrmConsControleProducao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnMarcar: Boolean; 
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = mskDtaPPR) And blnBuscaPorChave Then
    Begin
      If StrToDateDef(mskDtaPPR.Text, 0) = 0 Then
      Begin
        pMensagemOk('Informe uma data válida!');
        Result := False;
      End
      Else
      Begin
        FDtaPre := StrToDateDef(mskDtaPPR.Text, 0);

        cdsHorarios.EmptyDataSet;

        If Not fExisteProgramacaoProducao Then
        Begin
          pMensagemOk('Não há produção programada para a data informada!');
          Result := False;
        End
        Else
        Begin
          pPreencheHorariosProgramados;
          blnMudarFoco := False;
          pSetFocus(dbgHorarios);
        End;
      End;
    End

    Else If (Sender = edtReserv) And blnAgendamento And blnBuscaPorChave Then
    Begin
      blnMarcar := Not fEmptyStr(edtReserv.Text);

      cdsHorarios.Edit;
      cdsHorariosFGO_DISPON.AsString := IIF(blnMarcar, 'N', 'S');
      cdsHorariosFGO_SELECI.AsString := IIF(blnMarcar, 'S', 'N');
      cdsHorariosFGO_RESERV.AsString := edtReserv.Text;      
      cdsHorarios.Post;

      pAtualizaControleProducao;

      blnMudarFoco := False;

      pSetFocus(dbgHorarios);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmConsControleProducao.getDtaPre: TDateTime;
begin
  Result := FDtaPre;
end;

function TfrmConsControleProducao.getEspDoc: String;
begin
  Result := FEspDoc;
end;

function TfrmConsControleProducao.getNumDoc: String;
begin
  Result := FNumDoc;
end;

procedure TfrmConsControleProducao.pAtualizaFatGor;
var
  qryUpdate: TUniQuery;
begin
  Try
    Try
      qryUpdate := fCriaQuery(Self);

      with qryUpdate do
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE FATGOR               ');
        SQL.Add('   SET FGO_HPREVI = NULL    ');
        SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC ');
        SQL.Add('   AND FGO_ESPDOC = :ESPDOC ');
        SQL.Add('   AND FGO_CODEMP = :CODEMP ');
        ParamByName('NUMDOC').AsString := FNumDoc;
        ParamByName('ESPDOC').AsString := FEspDoc;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
      end;

    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[pAtualizaFatGor]');
      end;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TfrmConsControleProducao.pAtualizaControleProducao;
var
  qryUpdate: TUniQuery;
begin
  Try
    Try
      qryUpdate := fCriaQuery(Self);

      with qryUpdate do
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE CONPPR               ');
        SQL.Add('   SET PPR_RESERV = :RESERV ');
        SQL.Add(' WHERE PPR_CODEMP = :CODEMP ');
        SQL.Add('   AND PPR_HORPPR = :HORPPR ');
        SQL.Add('   AND PPR_DTAPPR = :DTAPPR ');
        ParamByName('HORPPR').AsDateTime := cdsHorariosFGO_HPREVI.AsDateTime;
        ParamByName('DTAPPR').AsDateTime := cdsHorariosFGO_PREVIS.AsDateTime;
        ParamByName('CODEMP').AsString   := VS_strCodEmp;

       If Not fEmptyStr(cdsHorariosFGO_RESERV.AsString) Then
         ParamByName('RESERV').AsString := cdsHorariosFGO_RESERV.AsString
       Else
         ParamByName('RESERV').Value := Null;

        ExecSQL;
      end;

    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[pAtualizaControleProducao]');
      end;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure TfrmConsControleProducao.pDesmarcarDisponivel;
begin
  cdsHorarios.Edit;
  cdsHorariosFGO_DISPON.AsString := 'S';
  cdsHorariosFGO_NUMDOC.AsString := '';
  cdsHorariosFGO_NOMCLI.AsString := '';
  cdsHorariosFGO_ESPDOC.AsString := '';
  cdsHorariosFGO_RESERV.AsString := '';
  cdsHorarios.Post;
end;

procedure TfrmConsControleProducao.pFiltrar;
begin
  with cdsHorarios do
  begin
    Filtered := False;
    Filter   := '';
    Filter   := IIF(rdgFiltro.ItemIndex = 1,'FGO_DISPON = ' + QuotedStr('S'),Filter);
    Filtered := True;
  end;  
end;

procedure TfrmConsControleProducao.pMarcaDisponivel(blnMarcar: Boolean);
var
  blnSelecionado: Boolean;
begin
  blnSelecionado := cdsHorarios.Locate('FGO_SELECI','S',[]);

  cdsHorarios.Edit;
  cdsHorariosFGO_SELECI.AsString := IIF(blnMarcar and (not blnSelecionado) ,'S','N');
  cdsHorarios.Post;
end;

procedure TfrmConsControleProducao.pMarcarHorario;
begin
  if (cdsHorariosFGO_DISPON.AsString = 'S') and (cdsHorariosFGO_SELECI.AsString = 'N') then
    pMarcaDisponivel(True)
  else if (cdsHorariosFGO_DISPON.AsString = 'S') and (cdsHorariosFGO_SELECI.AsString = 'S') then
    pMarcaDisponivel(False);
end;

procedure TfrmConsControleProducao.pPreencheHorariosProgramados;
var
  qryConsulta: TUniQuery;
begin
  Try
    Try
      qryConsulta := fCriaQuery(Self);
      with qryConsulta do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT FGO_NUMDOC, ');
        SQL.Add('       FGO_ESPDOC, ');
        SQL.Add('       FGO_PREVIS, ');
        SQL.Add('       FGO_HPREVI, ');
        SQL.Add('       FGO_CODEMP, ');
        SQL.Add('       CONCAT(FGO_CODCLI," - ",CLI_NOMCLI) AS FGO_NOMCLI ');
        SQL.Add('  FROM FATGOR ');
        SQL.Add('  INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
        SQL.Add(' WHERE FGO_PREVIS = :PREVIS ');
        SQL.Add('   AND FGO_CODEMP = :CODEMP ');
        ParamByName('PREVIS').AsDateTime := FDtaPre;
        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        Open;
        First;

        cdsHorarios.DisableControls;
        while not Eof do
        begin
          if (FieldByName('FGO_HPREVI').AsDateTime > 0) and (cdsHorarios.Locate('FGO_HPREVI',FieldByName('FGO_HPREVI').AsDateTime,[])) then
          begin
            cdsHorarios.Edit;
            cdsHorariosFGO_DISPON.AsString := 'N';
            cdsHorariosFGO_NUMDOC.AsString := FieldByName('FGO_NUMDOC').AsString;
            cdsHorariosFGO_ESPDOC.AsString := FieldByName('FGO_ESPDOC').AsString;
            cdsHorariosFGO_NOMCLI.AsString := FieldByName('FGO_NOMCLI').AsString;
            cdsHorariosFGO_CODEMP.AsString := FieldByName('FGO_CODEMP').AsString;
            cdsHorarios.Post;
          end;

          qryConsulta.Next
        end;

      end;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[pPreencheHorariosProgramados]');
      end;
    End;
  Finally
    FreeAndNil(qryConsulta);
    cdsHorarios.EnableControls;
  End;
end;

procedure TfrmConsControleProducao.pProgramarHorario;
  Var
    horLocate: TDateTime;
begin
  If Not blnAgendamento Then
  Begin
    horLocate := cdsHorariosFGO_HPREVI.AsDateTime;

    if not fExisteHorarioProgramado then
    begin
      cdsHorarios.Locate('FGO_HPREVI', horLocate, []);//A funcao fExisteHorarioProgramado esta desposicionando o registro
      pMarcarHorario;
    end
    else
      fMensagem('ATENÇÃO!', 'Já existe um horário programado para esse documento.' + #13#10 +
                            'Se quiser marcar esse horário você precisa desprogramar o horário ' + #13#10 +
                            'anteriormente programado!' , ['&Ok']);
  End
  Else
    pSetFocus(edtReserv);
end;

procedure TfrmConsControleProducao.rdgFiltroClick(Sender: TObject);
begin
  inherited;
  pFiltrar;
end;

procedure TfrmConsControleProducao.setDtaPre(const Value: TDateTime);
begin
  If (FDtaPre <> Value) Then
    FDtaPre := Value;
end;

procedure TfrmConsControleProducao.setEspDoc(const Value: String);
begin
  If (FEspDoc <> Value) Then
    FEspDoc := Value;
end;

procedure TfrmConsControleProducao.setNumDoc(const Value: String);
begin
  If (FNumDoc <> Value) Then
    FNumDoc := Value;
end;

end.
