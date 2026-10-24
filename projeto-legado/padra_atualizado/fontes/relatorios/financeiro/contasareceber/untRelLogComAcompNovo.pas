unit untRelLogComAcompNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  UniDataSetProvider,   Uni, BitBtnLockedIncrem, cxGrid, UniClientDataSet, StrUtils,
  cxLookAndFeels, cxLookAndFeelPainters,
  cxNavigator, frxClass, frxExportCSVTestabilidade, System.UITypes,
  cxProgressBar, untClassPanelCx, System.ImageList,
  Vcl.ImgList, Datasnap.Provider, DBAccess, Datasnap.DBClient, untTypesSistema, untIFuncoes, untGravando,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxImageList;

type
  TfrmRelLogComAcompNovo = class(TfrmPai)
    pnlHeader: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label27: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCliente: TEditFocus;
    edtNomCliente: TEditFocus;
    EdtCodCom: TEditFocus;
    edtParcel: TEditFocus;
    dbgConsultaDBTableView1: TcxGridDBTableView;
    dbgConsultaLevel1: TcxGridLevel;
    dbgConsulta: TcxGrid;
    dbgConsultaDBTableView1COM_NUMDOC: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_CODPRO: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_CODEMP: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_CODCLI: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_OPEBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_DTACAD: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_HORBAI: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_VRVEND: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_VRCOMI: TcxGridDBColumn;
    dbgConsultaDBTableView1OBSERV: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_DTABAI: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_DTALOG: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_HORLOG: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_DESCRI: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_NOMFRM: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_OPELOG: TcxGridDBColumn;
    cxsrConsulta: TcxStyleRepository;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label2: TLabel;
    btnPadrao: TBitBtnLocked;
    btnGeraCSV: TBitBtnLocked;
    cxImageList: TcxImageList;
    cdsConsulta: TUniClientDataSet;
    dspConsulta: TUniDataSetProvider;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Shp_inferior: TShape;
    lblCampoAlterados2: TLabel;
    dtsConsulta: TDataSource;
    dbgConsultaDBTableView1COM_CREDEB: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_TCOPRO: TcxGridDBColumn;
    rdgData: TRadioGroup;
    pnlOperador: TPanel;
    Label7: TLabel;
    edtNomeOpe: TEditFocus;
    edtCodOpe: TEditFocus;
    Label6: TLabel;
    edtCodProfissional: TEditFocus;
    edtNomProfissional: TEditFocus;
    dbgConsultaDBTableView1CLI_NOMCLI: TcxGridDBColumn;
    dbgConsultaDBTableView1DIV_NOMDIV: TcxGridDBColumn;
    dbgConsultaDBTableView1Alteracoes: TcxGridDBColumn;
    dbgConsultaDBTableView1COM_CODCOM: TcxGridDBColumn;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgConsultaDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgConsultaDBTableView1CustomDrawGroupCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnPadraoClick(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProfissionalKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    intCor     : Integer;

    procedure pFechaConsulta;
    procedure pSetFilterDefault;
    procedure pMascaraValor;
    function fGetSql: String;

    function fAbreConsulta(cxProgress: TcxProgressBar = Nil): Boolean;
    function fSetParametros: Boolean;

    Function fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAjustaColunas;
    function fGeraCSV(cxProgress : TcxProgressBar): Boolean;
    function MouseShowCursor(const Show: boolean): boolean;
    procedure pDefineAlterações;
    function fCarregaCampos(pgbProgresso: TcxProgressBar): Boolean;
    procedure pInfoStatusGravacao(cxProgress: TcxProgressBar;
      strInformacao: String);
    procedure pStepStatusGravacao(cxProgress: TcxProgressBar);
  public
    { Public declarations }
    blnVeioManutencao: Boolean;
    qryConsulta: TUniQuery;

    procedure pCarregaCampos;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelLogComAcompNovo: TfrmRelLogComAcompNovo;

implementation

uses untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmRelLogComAcompNovo.btnConsultarClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.pgbStatus.Visible   := False;
      frmAguarde.blnDesabilitaMouse  := True;
      frmAguarde.lblGravando.Caption := 'Aguarde Carregando Títulos...';
      frmAguarde.fExecutarAcao := fAbreConsulta;
      frmAguarde.ShowModal;
      btnPadraoClick(Sender);
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'untRelLogComAcompNovo.fAbreConsulta');
  End;
end;

procedure TfrmRelLogComAcompNovo.btnGeraCSVClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;
  Try
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.lblGravando.Caption := 'Gerando Arquivo...';
      frmAguarde.fExecutarAcao := fGeraCSV;
      frmAguarde.ShowModal;
    Finally
      FreeAndNil(frmAguarde);
    End;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, 'TGeraExcel.fGerarRelatorio');
  End;
end;

procedure TfrmRelLogComAcompNovo.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;

  If dtsConsulta.DataSet.IsEmpty Then
  begin
    MouseShowCursor(True);
    fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k']);
    Exit;
  end;
  pAjustaColunas;
  // manter grupos fechados (abas colapsada)
  dbgConsultaDBTableView1.ViewData.Collapse(True);
  dbgConsultaDBTableView1.DataController.FocusedRowIndex := 0;
  btnPadrao.Enabled := True;
end;

procedure TfrmRelLogComAcompNovo.dbgConsultaDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (AViewInfo.GridRecord.Values[dbgConsultaDBTableView1Alteracoes.Index] <> null) And
     (Pos(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName,
          AViewInfo.GridRecord.Values[dbgConsultaDBTableView1Alteracoes.Index]) > 0) then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Brush.Color := $4433CC
    Else
      ACanvas.Brush.Color := $8070FF;
  end
  Else
  Begin
    If (not AViewInfo.Selected) Then
    Begin
      If Odd(AViewInfo.GridRecord.Index) Then
        ACanvas.Brush.Color := intCor
      Else
        ACanvas.Brush.Color := clWindow;
    End;
  End;

  ACanvas.Font.Color := clBlack;
end;

procedure TfrmRelLogComAcompNovo.dbgConsultaDBTableView1CustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Brush.Color := clSkyBlue;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
end;

procedure TfrmRelLogComAcompNovo.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtNomCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelLogComAcompNovo.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
Var
arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodOpe, edtNomeOpe, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelLogComAcompNovo.edtCodProfissionalKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrDiversos : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodProfissional, edtNomProfissional, Nil, Key, arrDiversos) Then
  Begin
    If fValidaCampos(edtCodProfissional, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmRelLogComAcompNovo.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, True, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelLogComAcompNovo.fAbreConsulta(cxProgress: TcxProgressBar): Boolean;
begin
  Try
    dspConsulta.DataSet := qryConsulta;

    qryConsulta.Close;
    cdsConsulta.Close;
    qryConsulta.SQL.Clear;

    qryConsulta.SQL.Add(fGetSql);
    If Not fSetParametros Then
    Begin
      Result := False;
      Exit;
    End;

    qryConsulta.Open;

    If Assigned(dspConsulta.DataSet) Then
      pSetaClient(dspConsulta.DataSet);

    cdsConsulta.Open;

    pSetFilterDefault;

    pMascaraValor;

    pDefineAlterações;

    dbgConsultaDBTableView1.DataController.DataSource := dtsConsulta;
    pSetFocus(dbgConsulta);

    Result := qryConsulta.RecordCount > 0;

    blnMudarFoco := FALSE;
  Except

    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmRelLogComAcompNovo.fAbreConsulta]');
      Result := False;
    End;

  End;
end;

function TfrmRelLogComAcompNovo.fGetSql: String;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT LOGCOM.*, ';
  strSQL := strSQL + ' REPLACE(IFNULL(COM_OBSERV, ""), "<<csq>>" , " ") AS OBSERV,  ';
  strSQL := strSQL + '  REPLACE(IFNULL(COM_DESCRI, ""), "<<csq>>" , " ") AS DESCRI,  ';
  strSQL := strSQL + '  CADCLI.CLI_NOMCLI,  ';
  strSQL := strSQL + '  CADDIV.DIV_NOMDIV,  ';
  strSQL := strSQL + '  '''' AS ALTERACOES  ';
  strSQL := strSQL + ' FROM LOGCOM  ';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON COM_CODCLI = CLI_CODCLI  ';
  strSQL := strSQL + ' LEFT JOIN CADDIV ON COM_CODPRO = DIV_CODDIV   ';

  if Not blnVeioManutencao then
  begin
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   COM_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
  end
  else
    strSQL := strSQL + ' WHERE TRUE ';

  If Not fEmptyStr(edtCodCliente.Text) Then
    strSQL := strSQL + '  AND COM_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodProfissional.Text) Then
    strSQL := strSQL + '  AND COM_CODPRO = :CODPRO ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND COM_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodCom.Text) Then
    strSQL := strSQL + '  AND COM_CODCOM = :CODCOM ';


  strSQL := strSQL + ' ORDER BY COM_CODCOM, COM_DTALOG, COM_HORLOG ';

  Result := strSQL;

end;

procedure TfrmRelLogComAcompNovo.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery(Nil);
end;

procedure TfrmRelLogComAcompNovo.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConsulta);
end;

procedure TfrmRelLogComAcompNovo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE:Begin
                If Assigned(cdsConsulta) Then
                Begin
                  If Not cdsConsulta.Active Then
                    Close
                  Else
                   pFechaConsulta;
                End
                Else
                  Close;
              end;
    Else       inherited;
  End;
end;

procedure TfrmRelLogComAcompNovo.FormShow(Sender: TObject);
begin
  inherited;
  intCor    := StrToIntDef(fCfgSis('CORZEB'), clWhite);
  
  If fEmptyStr(mskDtaIni.Text) then
    mskDtaIni.Text := DateToStr(VS_Date);

  If fEmptyStr(mskDtaFin.Text) then
    mskDtaFin.Text := DateToStr(VS_Date);

  fValidaCampos(edtCodOpe,False);
  fValidaCampos(edtCodEmpresa,False);
  fValidaCampos(edtCodProfissional,False);
  fValidaCampos(edtCodCliente,False);

  pSetFocus(edtCodCom);
  WindowState:= wsMaximized;
  edtCodCom.MaxLength := fTamDocCadPag;
  edtCodCom.TamCampo  := edtCodCom.MaxLength;

  if blnVeioManutencao then
  Begin
    pSetFocus(dbgConsulta);
    pnlHeader.Visible := False;
    lblCampoAlterados2.Visible := True;
    Shp_inferior.Visible := True;
    btnPadraoClick(Sender);
  end;

end;


function TfrmRelLogComAcompNovo.fSetParametros: Boolean;
begin
  Try
      if Not blnVeioManutencao then
      begin
        qryConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        qryConsulta.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      end;

      If Not fEmptyStr(edtCodCliente.Text) Then
        qryConsulta.ParamByName('CODCLI').AsString := edtCodCliente.Text;

      If Not fEmptyStr(edtCodProfissional.Text) Then
        qryConsulta.ParamByName('CODPRO').AsString := edtCodProfissional.Text;

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        qryConsulta.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodCom.Text) Then
        qryConsulta.ParamByName('CODCOM').AsString := edtCodCom.Text;

    Result := True;
  Except
    Result := False;
  End;
end;

function TfrmRelLogComAcompNovo.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End
    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        edtNomCliente.Text := 'TODOS';
      End Else
      Begin
        edtNomCliente.Text := fRetNomCliente(edtCodCliente.Text);
        If fEmptyStr(edtNomCliente.Text) Then
        Begin
          Result := False;
          pMensagemOk('Cliente não encontrado!');
        End;
      End;

    End
    Else If (Sender = edtCodProfissional) Then
    Begin

      If fEmptyStr(edtCodProfissional.Text) Then
      Begin
        edtNomProfissional.Text := 'TODOS';
      End Else
      Begin
        edtNomProfissional.Text := fRetNomProfissional(edtCodProfissional.Text);
        If fEmptyStr(edtCodProfissional.Text) Then
        Begin
          Result := False;
          pMensagemOk('Profissional não encontrado!');
        End;
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        edtDesEmpresa.Text := 'TODAS';
      End Else
      Begin
        edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          Result := False;
          pMensagemOk('Empresa não encontrada!');
        End

        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtCodOpe) Then
    Begin
      If fEmptyStr(edtCodOpe.Text) Then
      Begin
        edtNomeOpe.Text := 'TODOS';
      End Else
      Begin
        edtNomeOpe.Text := fRetNomeOperador(edtCodOpe.Text);
        If fEmptyStr(edtNomeOpe.Text) Then
        Begin
          Result := False;
          pMensagemOk('Operador não encontrado!');
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelLogComAcompNovo.pDefineAlterações;
var
  arrRef: Array of String;
  strCodCom: String;
  strCamposDif: String;
  intIndex: Integer;
begin
  {**************************************************************************}
  {********** ESSE COMANDO FAZ A MESMA FUNÇÃO DO DISABLECONTROLS, ***********}
  {* SÓ QUE O DISABLECONTROLS NESSE CASO NÃO É VIÁVEL POR CAUSA DOS GRUPOS. *}
  {* PRECISO QUE QUANDO CARREGUE AS INFORMAÇÕES OS GRUPOS FIQUEM ABERTOS E **}
  {************ O USANDO O DISABLECONTROLS ELES FICAM FECHADOS. *************}
  {***********************************************************************MO*}
  dbgConsulta.BeginUpdate;

  SetLength(arrRef, cdsConsulta.Fields.Count);

  cdsConsulta.First;
  strCodCom := '';
  While not cdsConsulta.Eof Do
  Begin
    If (strCodCom <> cdsConsulta.FieldByName('COM_CODCOM').AsString) Then
    Begin
      strCodCom := cdsConsulta.FieldByName('COM_CODCOM').AsString;
      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        arrRef[intIndex] := cdsConsulta.Fields[intIndex].AsString;
    End
    Else
    Begin
      strCamposDif := '/';
      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        If (arrRef[intIndex] <> cdsConsulta.Fields[intIndex].AsString) And
           (cdsConsulta.Fields[intIndex].FieldName <> 'AUTOINCREM') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'COM_DTALOG') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'COM_HORLOG') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'COM_DESCRI') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'COM_NOMFRM') And
           (cdsConsulta.Fields[intIndex].FieldName <> 'COM_OPELOG') Then
          strCamposDif := strCamposDif + cdsConsulta.Fields[intIndex].FieldName + '/';

      cdsConsulta.Edit;
      cdsConsulta.FieldByName('ALTERACOES').AsString := strCamposDif;
      cdsConsulta.Post;

      for intIndex := 0 to cdsConsulta.Fields.Count - 1 do
        arrRef[intIndex] := cdsConsulta.Fields[intIndex].AsString;
    End;
    cdsConsulta.Next;
  End;

  dbgConsulta.EndUpdate;
  cdsConsulta.First;

end;

procedure TfrmRelLogComAcompNovo.pFechaConsulta;
begin
  cdsConsulta.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtNomCliente.Clear;
  edtCodProfissional.Clear;
  edtNomProfissional.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtCodCom.Clear;
  edtParcel.Clear;

  pSetFocus(edtCodCom);
end;

procedure TfrmRelLogComAcompNovo.pMascaraValor;
  Var
    intIndex: integer;
begin
  If cdsConsulta.Active Then
    For intIndex := 1 To cdsConsulta.Fields.Count - 1 Do
      Case cdsConsulta.Fields[intIndex].DataType Of
        ftFloat: TFloatField(cdsConsulta.Fields[intIndex]).DisplayFormat := fMskDigitos(2); //'#0.00';
        ftDate : TFloatField(cdsConsulta.Fields[intIndex]).EditMask      := '99/99/9999;1;_';
      End;
end;

procedure TfrmRelLogComAcompNovo.pSetFilterDefault;
begin
  cdsConsulta.Filter := '';
  If cdsConsulta.Filtered Then
    cdsConsulta.Filtered := FALSE;
end;

function TfrmRelLogComAcompNovo.fAjustaColunas(pgbProgresso: TcxProgressBar): Boolean;
begin
  Application.ProcessMessages;
  If Not dtsConsulta.DataSet.IsEmpty Then
    dbgConsultaDBTableView1.ApplyBestFit;

  frmGravando.lblGravando.Caption := 'Ajustando pesquisa...';
  Application.ProcessMessages;

  Result := True;
end;

function TfrmRelLogComAcompNovo.fCarregaCampos(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Application.ProcessMessages;
  dbgConsultaDBTableView1.ApplyBestFit();
  Application.ProcessMessages;
  fAbreConsulta;
  Application.ProcessMessages;
  pSetFocus(dbgConsulta);
  Result := True;
end;

procedure TfrmRelLogComAcompNovo.pAjustaColunas;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Ajustando tamanho das colunas...';
    frmGravando.fExecutarAcao := fAjustaColunas;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaCxGridNova.pAjustaColunas]');
    End;
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmRelLogComAcompNovo.pCarregaCampos;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.blnDesabilitaMouse  := True;
    frmGravando.lblGravando.Caption := 'Carregando Campos...';
    frmGravando.fExecutarAcao := fCarregaCampos;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelLogComAcompNovo.pCarregaCampos]');
  End;
  pFreeAndNil(frmGravando);
end;

procedure TfrmRelLogComAcompNovo.pStepStatusGravacao(cxProgress: TcxProgressBar);
Begin
    If Assigned(cxProgress) Then
    Begin
      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
End;

procedure TfrmRelLogComAcompNovo.pInfoStatusGravacao(cxProgress: TcxProgressBar; strInformacao: String);
Begin
  If Assigned(cxProgress) And (GetParentForm(cxProgress).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(cxProgress).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
End;

function TfrmRelLogComAcompNovo.fGeraCSV(cxProgress: TcxProgressBar): Boolean;
  Var
    svdCsv: TSaveDialog;
    strLinha,
    strNomArq: String;
    stlCsv: TStringList;

begin
  Result := True;

  pInfoStatusGravacao(cxProgress, 'Gerando arquivo CSV. Aguarde...');

  cxProgress.Position := 0;
  cxProgress.Properties.Max := qryConsulta.RecordCount;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin
    strNomArq := svdCsv.FileName;

    If Not fEmptyStr(strNomArq) Then
    Begin
      stlCsv := TStringList.Create;

      stlCsv.Clear;

      cdsConsulta.First;

      strLinha := 'DATA CADASTRO;NUM DOC;CÓD. PROFISSIONAL;NOME PROFISSIONAL;CRED. / DEB.;VALOR DOCTO.;VALOR COMISSÃO;' +
                  'CÓD. EMPRESA;CÓD. CLIENTE;NOME CLIENTE;DATA DA BAIXA;HORA DA BAIXA;OP. DA BAIXA;OBSERVAÇÃO;' +
                  'DATA LOG.;HORA LOG.;DESCRIÇÃO;NOME DO FORMULÁRIO;CÓD. OPERADOR LOG';

      stlCsv.Add(strLinha);

      While Not cdsConsulta.Eof Do
      Begin
        strLinha := FormatDateTime('dd/mm/yyyy', cdsConsulta.FieldByName('COM_DTACAD').AsDateTime) + ';' +
                                                 cdsConsulta.FieldByName('COM_NUMDOC').AsString    + ';' +
                                                 cdsConsulta.FieldByName('COM_CODPRO').AsString    + ';' +
                                                 cdsConsulta.FieldByName('DIV_NOMDIV').AsString    + ';' +
                                                 cdsConsulta.FieldByName('COM_CREDEB').AsString    + ';' +
                          FormatFloat('#,##0.00',cdsConsulta.FieldByName('COM_VRVEND').AsFloat)    + ';' +
                          FormatFloat('#,##0.00',cdsConsulta.FieldByName('COM_VRCOMI').AsFloat)    + ';' +
                                                 cdsConsulta.FieldByName('COM_CODEMP').AsString    + ';' +
                                                 cdsConsulta.FieldByName('COM_CODCLI').AsString    + ';' +
                                                 cdsConsulta.FieldByName('CLI_NOMCLI').AsString    + ';' +
                    IfThen(cdsConsulta.FieldByName('COM_DTABAI').Value <= 0, '', FormatDateTime('dd/mm/yyyy', cdsConsulta.FieldByName('COM_DTABAI').AsDateTime)) + ';' +
                    IfThen(cdsConsulta.FieldByName('COM_HORBAI').Value <= 0, '', FormatDateTime('HH:mm:ss',   cdsConsulta.FieldByName('COM_HORBAI').AsDateTime)) + ';' +
                                                 cdsConsulta.FieldByName('COM_OPEBAI').AsString    + ';' +
                    ReplaceStr((ReplaceStr(cdsConsulta.FieldByName('OBSERV').AsString, '<<csq>>', ' ')), #13#10, ' ') + ';' +
                    FormatDateTime('dd/mm/yyyy', cdsConsulta.FieldByName('COM_DTALOG').AsDateTime) + ';' +
                    FormatDateTime('HH:mm:ss'  , cdsConsulta.FieldByName('COM_HORLOG').AsDateTime) + ';' +
                                                 cdsConsulta.FieldByName('COM_DESCRI').AsString    + ';' +
                                                 cdsConsulta.FieldByName('COM_NOMFRM').AsString    + ';' +
                                                 cdsConsulta.FieldByName('COM_OPELOG').AsString;

        stlCsv.Add(strLinha);
        pStepStatusGravacao(cxProgress);

        cdsConsulta.Next;
      End;

      stlCsv.SaveToFile(strNomArq);
      FreeAndNil(stlCsv);

      fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
    End;
  End;

  FreeAndNil(svdCsv);
end;

function TfrmRelLogComAcompNovo.MouseShowCursor(const Show: boolean): boolean;
var
  I: integer;
begin
  I := ShowCursor(LongBool(true));
  if Show then
  begin
    Result := I >= 0;
    while I < 0 do begin
      Result := ShowCursor(LongBool(true)) >= 0;
      Inc(I);
    end;
  end
  else
  begin
    Result := I < 0;
    while I >= 0 do
    begin
      Result := ShowCursor(LongBool(false)) < 0;
      Dec(I);
    end;
  end;
end;

end.
