unit untCadLocFisSelecao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxProgressBar,
  cxLookAndFeelPainters, cxStyles, StrUtils, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, EditFocus, Vcl.Mask, Vcl.DBCtrls, untZClient,
  untTypesSistema, cxCheckBox,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TTipoConsulta = (tcCodigo, tcAutoincrem);


  TRecLotSel = record
    strCODLOC:String;
    strDESCRI:String;
    fltALTURA:Double;
    fltLARGUR:Double;
    fltPROFUN:Double;
    fltCAPACI:Double;
    fltPESMAX:Double;
    strPICKIN:String;
  End;

  TArrLotSel = array of TRecLotSel;
  TTipoMarca = (tmMarcar, tmDesmarcar, tmInverter);
  TfrmCadLocFisSelecao = class(TfrmPaiConfirma)
    pnlTop: TPanel;
    cxgLocFisLevel: TcxGridLevel;
    cxgLocFisTableView: TcxGridDBTableViewCitel;
    cxgLocFis: TcxGridCitel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtRuaIni: TEditFocus;
    edtPredioIni: TEditFocus;
    edtAndarIni: TEditFocus;
    edtApartamentoIni: TEditFocus;
    edtCodLse: TEditFocus;
    edtDesLse: TEditFocus;
    Label1: TLabel;
    topLine: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtRuaFin: TEditFocus;
    edtPredioFin: TEditFocus;
    edtAndarFin: TEditFocus;
    edtApartamentoFin: TEditFocus;
    btnBuscar: TBitBtnLocked;
    cxgLocFisTableViewCodigo: TcxGridDBColumn;
    cxgLocFisTableViewDescricao: TcxGridDBColumn;
    cxgLocFisTableViewAltura: TcxGridDBColumn;
    cxgLocFisTableViewLargura: TcxGridDBColumn;
    cxgLocFisTableViewProdundidade: TcxGridDBColumn;
    cxgLocFisTableViewCapacidade: TcxGridDBColumn;
    cxgLocFisTableViewPeso: TcxGridDBColumn;
    cxgLocFisTableViewPickin: TcxGridDBColumn;
    cxgLocFisTableViewMarca: TcxGridDBColumn;
    Label6: TLabel;
    btnInverter: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    rdgAssociacaoClasse: TRadioGroup;
    Label7: TLabel;
    edtCodLoc: TEditFocus;
    edtDesLoc: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLseExit(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgLocFisTableViewPickinGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure btnMarcarClick(Sender: TObject);
    procedure edtCodLocKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLocExit(Sender: TObject);
  private
    FTipoConsulta : TTipoConsulta;
    FTipoMarca    : TTipoMarca;
    cdsCadLoc : TZClient;
    arrCodLse: TConsultasArray;
    arrCodLoc: TConsultasArray;

    function fGetSQL : String;
    procedure pMontaResult(var arrConsulta: TConsultasArray); overload;
    procedure pMontaResult(var arrLotSel: TArrLotSel); overload;
    procedure pSetaCampos;
    function fMarcarProgresso(cxProgress: TcxProgressBar): Boolean;
  public
    Class Function fSelecaoCadLoc(tcTipoConsulta : TTipoConsulta):TConsultasArray;
    Class function fSelecaoCadArrLotSel(tcTipoConsulta : TTipoConsulta): TArrLotSel;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; override;
  end;



implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas, untCfgLocFis,
  untGravando, untHelperCitel;

{ TfrmCadLocFisSelecao }

procedure TfrmCadLocFisSelecao.btnBuscarClick(Sender: TObject);
  Var
    strCodLse : String;
    strCodLoc : String;
begin
  inherited;
  With cdsCadLoc.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add(fGetSQL);

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    pSetaParam(edtCodLse.Text, arrCodLse, strCodLse, 'CODLSE', cdsCadLoc.qryQuery);
    pSetaParam(edtCodLoc.Text, arrCodLoc, strCodLoc, 'CODLOC', cdsCadLoc.qryQuery);

    If FindParam('RUAINI') <> Nil Then
      ParamByName('RUAINI').AsString := edtRuaIni.Text;

    If FindParam('RUAFIN') <> Nil Then
      ParamByName('RUAFIN').AsString := edtRuaFin.Text;

    If FindParam('PREINI') <> Nil Then
      ParamByName('PREINI').AsString := edtPredioIni.Text;

    If FindParam('PREFIN') <> Nil Then
      ParamByName('PREFIN').AsString := edtPredioFin.Text;

    If FindParam('ANDINI') <> Nil Then
      ParamByName('ANDINI').AsString := edtAndarIni.Text;

    If FindParam('ANDFIN') <> Nil Then
      ParamByName('ANDFIN').AsString := edtAndarFin.Text;

    If FindParam('APTINI') <> Nil Then
      ParamByName('APTINI').AsString := edtApartamentoIni.Text;

    If FindParam('APTFIN') <> Nil Then
      ParamByName('APTFIN').AsString := edtApartamentoFin.Text;

  End;

  cdsCadLoc.fAbreClient(True, 'TfrmCadLocFisSelecao.btnBuscarClick');
  cdsCadLoc.LogChanges := False;

  TFloatField(cdsCadLoc.FieldByName('ALTURA')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadLoc.FieldByName('LARGUR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadLoc.FieldByName('PROFUN')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadLoc.FieldByName('CAPACI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadLoc.FieldByName('PESMAX')).DisplayFormat := '#,##0.00';

  btnConfirma.Enabled := (cdsCadLoc.RecordCount > 0);

end;

procedure TfrmCadLocFisSelecao.btnConfirmaClick(Sender: TObject);
  Var
    blnTemMarca : Boolean;
begin
//  inherited;
  Try
    blnTemMarca := False;
    cdsCadLoc.DisableControls;
    cdsCadLoc.First;
    While Not cdsCadLoc.Eof Do
    Begin
      If cdsCadLoc.FieldByName('MARCA').AsString = 'S' Then
      Begin
        blnTemMarca := True;
        cdsCadLoc.Last;
      End;

      cdsCadLoc.Next;
    End;

    If (not blnTemMarca) Then
    Begin
      fMensagem('', 'Nenhum Registro Foi Marcado!', ['&OK']);
      Exit;
    End
    Else
      ModalResult := MrOk;

  Finally
    cdsCadLoc.First;
    cdsCadLoc.EnableControls;
  End;
end;

procedure TfrmCadLocFisSelecao.btnMarcarClick(Sender: TObject);
begin
  inherited;

  If (not cdsCadLoc.Active) Or (cdsCadLoc.RecordCount = 0) Then
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

function TfrmCadLocFisSelecao.fMarcarProgresso(cxProgress : TcxProgressBar):Boolean;
Begin
  Try
    Result := True;
    cdsCadLoc.DisableControls;
    cdsCadLoc.First;
    cxProgress.Properties.Max := cdsCadLoc.RecordCount;

    While Not cdsCadLoc.Eof Do
    Begin
      cdsCadLoc.Edit;

      Case FTipoMarca Of
        tmMarcar    : cdsCadLoc.FieldByName('MARCA').AsString := 'S';
        tmDesmarcar : cdsCadLoc.FieldByName('MARCA').AsString := 'N';
        tmInverter  : cdsCadLoc.FieldByName('MARCA').AsString := IfThen(cdsCadLoc.FieldByName('MARCA').AsString = 'S', 'N', 'S');
      End;

      cdsCadLoc.Post;

      cdsCadLoc.Next;
      cxProgress.pStep;
    End;

  Finally
    cdsCadLoc.First;
    cdsCadLoc.EnableControls;
  End;

End;

procedure TfrmCadLocFisSelecao.cxgLocFisTableViewPickinGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If (AText = 'S') Then
    AText := 'Sim'
  Else If (AText = 'N') Then
    AText := 'Não';
end;

procedure TfrmCadLocFisSelecao.edtCodLocExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLoc, edtDesLoc, arrCodLoc, nil, nil, 'da localização física');
end;

procedure TfrmCadLocFisSelecao.edtCodLocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqLocFisica(Self, edtCodLoc, edtDesLoc, nil, key, arrCodLoc, False) Then
  Begin
    If fValidaCampos(edtCodLoc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLocFisSelecao.edtCodLseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodLse, edtDesLse, arrCodLse, nil, fRetLocSep, 'do local de separação');
end;

procedure TfrmCadLocFisSelecao.edtCodLseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqLocSep(Self, edtCodLse, edtDesLse, nil, key, arrCodLse, False) Then
  Begin
    If fValidaCampos(edtCodLSe, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadLocFisSelecao.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT "S" AS MARCA,         ';
  Result := Result + '        AUTOINCREM AS AUTINC, ';
  Result := Result + '        LOC_CODLOC AS CODLOC, ';
  Result := Result + '        LOC_DESCRI AS DESCRI, ';
  Result := Result + '        LOC_ALTURA AS ALTURA, ';
  Result := Result + '        LOC_LARGUR AS LARGUR, ';
  Result := Result + '        LOC_PROFUN AS PROFUN, ';
  Result := Result + '        LOC_CAPACI AS CAPACI, ';
  Result := Result + '        LOC_PESMAX AS PESMAX, ';
  Result := Result + '        LOC_PICKIN AS PICKIN  ';
  Result := Result + ' FROM CADLOC                  ';
  Result := Result + ' WHERE LOC_CODEMP = :CODEMP   ';

  Result := Result + fStrLocate(edtCodLse, arrCodLse, 'LOC_CODLSE', 'CODLSE');
  Result := Result + fStrLocate(edtCodLoc, arrCodLoc, 'LOC_CODLOC', 'CODLOC');

  If not fEmptyStr(edtRuaIni.Text) Then
  Begin
    If not fEmptyStr(edtRuaFin.Text) Then
    Begin
      Result := Result + ' AND LOC_R_U_A_ BETWEEN :RUAINI AND :RUAFIN '
    End
    Else
      Result := Result + ' AND LOC_R_U_A_ = :RUAINI ';
  End;

  If not fEmptyStr(edtPredioIni.Text) Then
  Begin
    If not fEmptyStr(edtPredioFin.Text) Then
    Begin
      Result := Result + ' AND LOC_PREDIO BETWEEN :PREINI AND :PREFIN '
    End
    Else
      Result := Result + ' AND LOC_PREDIO = :PREINI ';
  End;

  If not fEmptyStr(edtAndarIni.Text) Then
  Begin
    If not fEmptyStr(edtAndarFin.Text) Then
    Begin
      Result := Result + ' AND LOC_ANDAR_ BETWEEN :ANDINI AND :ANDFIN '
    End
    Else
      Result := Result + ' AND LOC_ANDAR_ = :ANDINI ';
  End;

  If not fEmptyStr(edtApartamentoIni.Text) Then
  Begin
    If not fEmptyStr(edtApartamentoFin.Text) Then
    Begin
      Result := Result + ' AND LOC_APARTA BETWEEN :APTINI AND :APTFIN '
    End
    Else
      Result := Result + ' AND LOC_APARTA = :APTINI ';
  End;

  If rdgAssociacaoClasse.ItemIndex <> 2 Then
    Result := Result + ' AND  (SELECT COUNT(1) ' +
                       '         FROM CLALOC ' +
                       '        WHERE CLL_CODLOC = LOC_CODLOC ' +
                       '          AND CLL_CODEMP = LOC_CODEMP )' + IIf(rdgAssociacaoClasse.ItemIndex = 0, ' > 0', ' = 0');


end;

procedure TfrmCadLocFisSelecao.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodLse(edtCodLse);
  cdsCadLoc := TZClient.Create(Self);
  cxgLocFisTableView.DataController.DataSource := cdsCadLoc.dtsSource;
  pSetaCampos;
end;

procedure TfrmCadLocFisSelecao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCadLoc);
  inherited;
end;

class function TfrmCadLocFisSelecao.fSelecaoCadArrLotSel(tcTipoConsulta: TTipoConsulta): TArrLotSel;
  Var
    frmCadLocFisSelecao : TfrmCadLocFisSelecao;
begin
  pCriarFormularios(TfrmCadLocFisSelecao, frmCadLocFisSelecao);
  With frmCadLocFisSelecao Do
  Begin
    FTipoConsulta := tcTipoConsulta;
    frmCadLocFisSelecao.ShowModal;
    If ModalResult = MrOK Then
    Begin
      pMontaResult(Result);
    End;
  End;
  FreeAndNil(frmCadLocFisSelecao);
end;

class function TfrmCadLocFisSelecao.fSelecaoCadLoc(tcTipoConsulta: TTipoConsulta): TConsultasArray;
  Var
    frmCadLocFisSelecao : TfrmCadLocFisSelecao;
begin
  pCriarFormularios(TfrmCadLocFisSelecao, frmCadLocFisSelecao);
  With frmCadLocFisSelecao Do
  Begin
    FTipoConsulta := tcTipoConsulta;
    frmCadLocFisSelecao.ShowModal;
    If ModalResult = MrOK Then
    Begin
      pMontaResult(Result);
    End;
  End;
  FreeAndNil(frmCadLocFisSelecao);
end;

function TfrmCadLocFisSelecao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = edtCodLse) Then
    Begin
      pDesmarcaLista(edtCodLse, arrCodLse);
    End

    Else
    If (Sender = edtCodLoc) Then
    Begin
      pDesmarcaLista(edtCodLoc, arrCodLoc);
    End

    Else
    If (Sender = edtRuaIni) Then
    Begin
      edtRuaFin.Enabled := not fEmptyStr(edtRuaIni.Text);
      If Not edtRuaFin.Enabled Then
        edtRuaFin.Clear;
    End

    Else
    If (Sender = edtPredioIni) Then
    Begin
      edtPredioFin.Enabled := not fEmptyStr(edtPredioIni.Text);
      If Not edtPredioFin.Enabled Then
        edtPredioFin.Clear;
    End

    Else
    If (Sender = edtAndarIni) Then
    Begin
      edtAndarFin.Enabled := not fEmptyStr(edtAndarIni.Text);
      If Not edtAndarFin.Enabled Then
        edtAndarFin.Clear;
    End

    Else
    If (Sender = edtApartamentoIni) Then
    Begin
      edtApartamentoFin.Enabled := not fEmptyStr(edtApartamentoIni.Text);
      If Not edtApartamentoFin.Enabled Then
        edtApartamentoFin.Clear;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadLocFisSelecao.pMontaResult(var arrConsulta : TConsultasArray);
Begin
  Try
    cdsCadLoc.DisableControls;
    cdsCadLoc.Filter   := 'MARCA = ' + QuotedStr('S');
    cdsCadLoc.Filtered := True;
    cdsCadLoc.First;

    SetLength(arrConsulta, cdsCadLoc.RecordCount);

    While Not cdsCadLoc.Eof Do
    Begin
      Case FTipoConsulta of
        tcCodigo     : arrConsulta[cdsCadLoc.RecNo-1].strCodigo := cdsCadLoc.FieldByName('CODLOC').AsString;
        tcAutoincrem : arrConsulta[cdsCadLoc.RecNo-1].strCodigo := cdsCadLoc.FieldByName('AUTINC').AsString;
      end;

      cdsCadLoc.Next;
    End;

  Finally
    cdsCadLoc.Filtered := False;
    cdsCadLoc.Filter   := '';
    cdsCadLoc.First;
    cdsCadLoc.EnableControls;
  End;

End;

procedure TfrmCadLocFisSelecao.pMontaResult(var arrLotSel: TArrLotSel);
begin
  Try
    cdsCadLoc.DisableControls;
    cdsCadLoc.Filter   := 'MARCA = ' + QuotedStr('S');
    cdsCadLoc.Filtered := True;
    cdsCadLoc.First;

    SetLength(arrLotSel, cdsCadLoc.RecordCount);

    While Not cdsCadLoc.Eof Do
    Begin

      arrLotSel[cdsCadLoc.RecNo-1].strCODLOC := cdsCadLoc.FieldByName('CODLOC').AsString;
      arrLotSel[cdsCadLoc.RecNo-1].strDESCRI := cdsCadLoc.FieldByName('DESCRI').AsString;
      arrLotSel[cdsCadLoc.RecNo-1].fltALTURA := cdsCadLoc.FieldByName('ALTURA').AsFloat;
      arrLotSel[cdsCadLoc.RecNo-1].fltLARGUR := cdsCadLoc.FieldByName('LARGUR').AsFloat;
      arrLotSel[cdsCadLoc.RecNo-1].fltPROFUN := cdsCadLoc.FieldByName('PROFUN').AsFloat;
      arrLotSel[cdsCadLoc.RecNo-1].fltCAPACI := cdsCadLoc.FieldByName('CAPACI').AsFloat;
      arrLotSel[cdsCadLoc.RecNo-1].fltPESMAX := cdsCadLoc.FieldByName('PESMAX').AsFloat;
      arrLotSel[cdsCadLoc.RecNo-1].strPICKIN := cdsCadLoc.FieldByName('PICKIN').AsString;


      cdsCadLoc.Next;
    End;

  Finally
    cdsCadLoc.Filtered := False;
    cdsCadLoc.Filter   := '';
    cdsCadLoc.First;
    cdsCadLoc.EnableControls;
  End;

end;

procedure TfrmCadLocFisSelecao.pSetaCampos;
  Var
    objCampo     : TCfgLocFis;
    objCfgLocFis : TCamposCfgLocFis;
Begin
  objCfgLocFis := TCamposCfgLocFis.Create;
  Try

    For objCampo in objCfgLocFis Do
    Begin

      If objCampo.strNomCam = 'LOC_CODLSE' Then
        Continue;

      With objCampo Do
      Begin
        If strNomCam = 'LOC_R_U_A_' Then
        Begin
          pSetaConfiguracoes(edtRuaIni);
          pSetaConfiguracoes(edtRuaFin);
        End

        Else
        If strNomCam = 'LOC_PREDIO' Then
        Begin
          pSetaConfiguracoes(edtPredioIni);
          pSetaConfiguracoes(edtPredioFin);
        End

        Else
        If strNomCam = 'LOC_ANDAR_' Then
        Begin
          pSetaConfiguracoes(edtAndarIni);
          pSetaConfiguracoes(edtAndarFin);
        End

        Else
        If strNomCam = 'LOC_APARTA' Then
        Begin
          pSetaConfiguracoes(edtApartamentoIni);
          pSetaConfiguracoes(edtApartamentoFin);
        End;
      End;
    End;
  Finally
    FreeAndNil(objCfgLocFis);
  End;

End;

end.


