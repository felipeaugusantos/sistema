unit untLiberacaoAcompEntregas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, QColorLabel, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, cxSplitter, Uni,
  UniDataSetProvider,
  UniClientDataSet, System.UITypes, cxProgressBar, untMovMeComunica,
  untMovMeXML, cxButtonEdit, System.Actions, Vcl.ActnList,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmLiberacaoAcompEntregas = class(TfrmPai)
    pnlDados: TPanel;
    pnlFiltros: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lblTransp: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lblRegiaoCli: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodCli: TEditFocus;
    edtDesCliente: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCid: TEditFocus;
    edtDesCidade: TEditFocus;
    edtNumRom: TEditFocus;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtCodAju: TEditFocus;
    edtNomAju: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    mskPlaVei: TMaskEditFocus;
    edtDesVei: TEditFocus;
    edtRegCli: TEditFocus;
    edtNomRegCli: TEditFocus;
    gpbDocumento: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtDocFat: TEditFocus;
    edtEspFat: TEditFocus;
    edtEmpFat: TEditFocus;
    rdgCtrEnt: TRadioGroup;
    Label7: TLabel;
    pnlGrid: TPanel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosTableView1: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    dtsDados: TDataSource;
    btnFiltrar: TBitBtnLocked;
    cxgDadosTableView1GER_ROMIMP: TcxGridDBColumn;
    cxgDadosTableView1GER_DTAENT: TcxGridDBColumn;
    cxgDadosTableView1CLIENT: TcxGridDBColumn;
    cxgDadosTableView1GER_VLRCON: TcxGridDBColumn;
    cxgDadosTableView1GER_CODVEN: TcxGridDBColumn;
    cxgDadosTableView1GER_ESTADO: TcxGridDBColumn;
    cxgDadosTableView1DOCUME: TcxGridDBColumn;
    cxgDadosTableView1ROMANE: TcxGridDBColumn;
    Panel1: TPanel;
    edtRecPor: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    edtStaBai: TEditFocus;
    Label13: TLabel;
    edtAjuda1: TEditFocus;
    edtAjuda2: TEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    edtMotivo: TEditFocus;
    cxgDadosTableView1CID_NOMCID: TcxGridDBColumn;
    cxgDadosTableView1STAENT: TcxGridDBColumn;
    btnMarDes: TBitBtnLocked;
    btnMarTod: TBitBtnLocked;
    btnLibEnt: TBitBtnLocked;
    btnAtuali: TBitBtnLocked;
    cxgDadosTableView1MARDES: TcxGridDBColumn;
    btnExpRec: TBitBtnLocked;
    btnRecImg: TBitBtnLocked;
    edtDtaHraBai: TEditFocus;
    Label16: TLabel;
    chkBaixaApp: TCheckBox;
    btnFacImg: TBitBtnLocked;
    btnItensDaNota: TBitBtnLocked;
    gbxTipoBaixa: TGroupBox;
    chkEntregue: TCheckBox;
    chkEntregueParc: TCheckBox;
    chkNaoEntregue: TCheckBox;
    btnReagendar: TBitBtnLocked;
    btnDesconsiderar: TBitBtnLocked;
    chkDesconsiderados: TCheckBox;
    chkReagendados: TCheckBox;
    edtAjuda4: TEditFocus;
    lblAjudante4: TLabel;
    edtAjuda3: TEditFocus;
    lblAjudante3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAjuKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtRegCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtDocFatExit(Sender: TObject);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnAtualiClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure cxgDadosTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnLibEntClick(Sender: TObject);
    procedure btnExpRecClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgDadosTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRecImgClick(Sender: TObject);
    procedure cxgDadosTableView1CustomDrawGroupCell
      (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure rdgCtrEntClick(Sender: TObject);
    procedure btnFacImgClick(Sender: TObject);
    procedure btnItensDaNotaClick(Sender: TObject);
    procedure btnReagendarClick(Sender: TObject);
    procedure btnDesconsiderarClick(Sender: TObject);
  private
    { Private declarations }
    qryDados: TUniQuery;
    dspDados: TUniDataSetProvider;
    cdsDados: TUniClientDataSet;
    bnDirLibEnt: Boolean;
    cdsRoma: TUniClientDataSet;
    function fCarregaDados(pgbStatus: TcxProgressBar): Boolean;
    procedure pSetaParametros;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pMarcarDesmarcar;
    procedure pMarcarDesmarcarTodos;
    function fTemRomaneioMarcado: Boolean;
    procedure pCriaCdsRoma;
    procedure pSintetizarRomaneiosMarcados;
    procedure pLimparSelecao;
    procedure pListarItensDaNota;
    function fStatusBaixa(DataSet: TDataSet): String;
    function fComunicarMovMe(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fMotoristaBloqueado(strCodMot: String): Boolean;
    function fDesconsiderarRomaneio(pgbStatus: TcxProgressBar) :Boolean;
    function fReagendarRomaneio(pgbStatus: TcxProgressBar) :Boolean;
    function fGerarNovoPreRomaneio(Var strRomNov: String;
      strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, DateUtils, untGravando,
  untMovMeGerar, untCadProFoto, untFuncoesImagem,
  untFuncoesRel, untFuncoesRel2, StrUtils,
  untMovGer, untHisPed, untAtualizaOcorrenciasCRM, untFuncoesCRM,
  untRomGer, untTypesCRM;

{ TfrmLiberacaoAcompEntregas }

procedure TfrmLiberacaoAcompEntregas.btnAtualiClick(Sender: TObject);
begin
  inherited;
  btnFiltrar.Click;
end;

procedure TfrmLiberacaoAcompEntregas.btnDesconsiderarClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Desconsiderando romaneio...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fDesconsiderarRomaneio;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
    cdsDados.Refresh;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.btnExpRecClick(Sender: TObject);
begin
  inherited;
  If (btnExpRec.Caption = '[F11] Expandir') Then
  Begin
    btnExpRec.Caption := '[F11] Recolher';
    cxgDadosTableView1.ViewData.Expand(True);
  End
  Else
  Begin
    btnExpRec.Caption := '[F11] Expandir';
    cxgDadosTableView1.ViewData.Collapse(True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.btnFacImgClick(Sender: TObject);
var
  frmCadProFoto: TfrmCadProFoto;
begin
  inherited;
  pCriarFormularios(TfrmCadProFoto, frmCadProFoto);
  Try
    Case fCarregaImagemFachada(cdsDados.FieldByName('GER_ENTGER').AsString,
      frmCadProFoto.imgPro) of
      riOk:
        Begin
          frmCadProFoto.imgPro.Visible := True;
          frmCadProFoto.lblErrImg.Visible := False;
        End;
      riErro:
        Begin
          frmCadProFoto.imgPro.Visible := False;
          frmCadProFoto.lblErrImg.Visible := True;
        End;
      riNulo:
        Begin
          frmCadProFoto.imgPro.Visible := False;
          frmCadProFoto.lblErrImg.Visible := False;
        End;
    End;
    frmCadProFoto.Caption := 'ROMANEIO: ' + cdsDados.FieldByName('ROMANE')
      .AsString + ' - DOCUMENTO: ' + cdsDados.FieldByName('DOCFAT').AsString;

    frmCadProFoto.btnTamanhoOriginal.Enabled := False;

    frmCadProFoto.ShowModal;
  Finally
    pFreeAndNil(frmCadProFoto);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.btnFiltrarClick(Sender: TObject);
  Var
    LfrmGravando: TfrmGravando;
begin
  btnFiltrar.Enabled := False;
  Try
    If (Not fVerificaCampos) Then
      Exit;

    Try
      Try
        pLimparSelecao;
        pCriarFormularios(TfrmGravando, LfrmGravando);
        LfrmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
        LfrmGravando.pgbStatus.Visible := False;
        LfrmGravando.strChave := 'PEDCOM';
        LfrmGravando.fExecutarAcao := fCarregaDados;
        LfrmGravando.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message,
            '[TfrmLiberacaoAcompEntregas.btnFiltrarClick]');
      End;
    Finally
      pFreeAndNil(LfrmGravando);
    End;
  Finally
    btnFiltrar.Enabled := True;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.btnItensDaNotaClick(Sender: TObject);
begin
  pListarItensDaNota;
end;

procedure TfrmLiberacaoAcompEntregas.btnLibEntClick(Sender: TObject);
Var
  qryUpdate: TUniQuery;
begin
  inherited;
  If Not(btnLibEnt.Enabled And btnLibEnt.Visible) Then
    Exit;

  If (Not fTemRomaneioMarcado) Then
  Begin
    fMensagem('ATENÇÃO!',
      'Favor marcar os romaneios a serem liberados!', ['&OK']);
    Exit;
  End;

  qryUpdate := fCriaQuery(Self);
  cdsDados.DisableControls;
  Try
    pSintetizarRomaneiosMarcados;

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE ROMGERX ');
      SQL.Add('    SET GER_LIBENT = :LIBENT, ');
      SQL.Add('        GER_OPLIEN = :OPLIEN, ');
      SQL.Add('        GER_DTLIEN = :DTLIEN, ');
      SQL.Add('        GER_HRLIEN = :HRLIEN  ');
      SQL.Add('  WHERE GER_NUMROM = :NUMROM  ');
      SQL.Add('    AND GER_EMPROM = :EMPROM  ');
      SQL.Add('    AND GER_LIBENT = "N"      ');
    End;

    fStartTransaction;
    Try
      cdsRoma.First;
      While Not cdsRoma.Eof Do
      Begin
        qryUpdate.ParamByName('LIBENT').AsString := 'S';
        qryUpdate.ParamByName('OPLIEN').AsString := strLoginUsuarioLogado;
        qryUpdate.ParamByName('DTLIEN').AsDateTime := VS_Date;
        qryUpdate.ParamByName('HRLIEN').AsDateTime := fNow();
        qryUpdate.ParamByName('NUMROM').AsString :=
          cdsRoma.FieldByName('GER_NUMROM').AsString;
        qryUpdate.ParamByName('EMPROM').AsString :=
          cdsRoma.FieldByName('GER_EMPROM').AsString;
        qryUpdate.ExecSQL;

        cdsRoma.Next;
      End;

      fCommit;

      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.lblGravando.Caption :=
          'Enviando dados para o servidor. Aguarde...';
        frmGravando.pgbStatus.Visible := False;
        frmGravando.fExecutarAcao := fComunicarMovMe;
        frmGravando.ShowModal;

        If not frmGravando.blnConfirma Then
        begin
          With qryUpdate Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' UPDATE ROMGERX ');
            SQL.Add('    SET GER_LIBENT = :LIBENT, ');
            SQL.Add('        GER_OPLIEN = :OPLIEN, ');
            SQL.Add('        GER_DTLIEN = :DTLIEN, ');
            SQL.Add('        GER_HRLIEN = :HRLIEN  ');
            SQL.Add('  WHERE GER_NUMROM = :NUMROM  ');
            SQL.Add('    AND GER_EMPROM = :EMPROM  ');
          End;

          fStartTransaction;

          cdsRoma.First;
          While Not cdsRoma.Eof Do
          Begin
            qryUpdate.ParamByName('LIBENT').AsString := 'N';
            qryUpdate.ParamByName('OPLIEN').Value := Null;
            qryUpdate.ParamByName('DTLIEN').Value := Null;
            qryUpdate.ParamByName('HRLIEN').Value := Null;
            qryUpdate.ParamByName('NUMROM').AsString :=
              cdsRoma.FieldByName('GER_NUMROM').AsString;
            qryUpdate.ParamByName('EMPROM').AsString :=
              cdsRoma.FieldByName('GER_EMPROM').AsString;
            qryUpdate.ExecSQL;

            cdsRoma.Next;
          End;

          fCommit;
        End;
      Finally
        FreeAndNil(frmGravando);
      End;

      btnAtuali.Click;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,
          '[TfrmLiberacaoAcompEntregas.btnLibEntClick]');
      End;
    End;
  Finally
    cdsDados.EnableControls;
    // pLimparSelecao;
    FreeAndNil(qryUpdate);
  End;

end;

procedure TfrmLiberacaoAcompEntregas.btnMarDesClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcar;
end;

procedure TfrmLiberacaoAcompEntregas.btnMarTodClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos;
end;

procedure TfrmLiberacaoAcompEntregas.btnReagendarClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Reagendando romaneio para nova liberação...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fReagendarRomaneio;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
    cdsDados.Refresh;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.btnRecImgClick(Sender: TObject);
var
  frmCadProFoto: TfrmCadProFoto;
begin
  inherited;
  pCriarFormularios(TfrmCadProFoto, frmCadProFoto);
  Try
    Case fCarregaImagemRecibo(cdsDados.FieldByName('AUTOINCREM').AsString,
      frmCadProFoto.imgPro) of
      riOk:
        Begin
          frmCadProFoto.imgPro.Visible := True;
          frmCadProFoto.lblErrImg.Visible := False;
        End;
      riErro:
        Begin
          frmCadProFoto.imgPro.Visible := False;
          frmCadProFoto.lblErrImg.Visible := True;
        End;
      riNulo:
        Begin
          frmCadProFoto.imgPro.Visible := False;
          frmCadProFoto.lblErrImg.Visible := False;
        End;
    End;
    frmCadProFoto.Caption := 'ROMANEIO: ' + cdsDados.FieldByName('ROMANE')
      .AsString + ' - DOCUMENTO: ' + cdsDados.FieldByName('DOCFAT').AsString;

    frmCadProFoto.btnTamanhoOriginal.Enabled := False;

    frmCadProFoto.ShowModal;
  Finally
    pFreeAndNil(frmCadProFoto);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.cxgDadosTableView1CustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsDados Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (FindField('MARDES') = Nil) Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
      cxgDadosTableView1MARDES.Index]) = 'M' Then
    Begin
      If ACanvas.Brush.Color = clHighlight Then
      Begin
        ACanvas.Font.Color := clLime;
        ACanvas.Font.Style := [fsBold];
      End
      Else
      Begin
        ACanvas.Font.Color := clBlue;
        ACanvas.Font.Style := [];
      End;
    End;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.cxgDadosTableView1CustomDrawGroupCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsDados Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (FindField('MARDES') = Nil) Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
      cxgDadosTableView1MARDES.Index]) = 'M' Then
      ACanvas.Font.Style := [fsBold];
  End;
end;

procedure TfrmLiberacaoAcompEntregas.cxgDadosTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F1) Then
    btnMarDes.Click;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodAjuKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqAjudantes(Self, edtCodAju, edtNomAju, nil, nil, Key, arrSel, True, True) Then
  Begin
    If fValidaCampos(edtCodAju, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCid: TConsultasArray;
begin
  If fPesqCidade(Self, edtCodCid, edtDesCidade, Nil, Nil, Key, arrCid) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCli: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCliente, Nil, Key,
    arrCli) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key,
    arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel,
    True, nil, 'Consulta de Itens', '1') Then
  Begin
    If fValidaCampos(edtCodIte, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMot: TConsultasArray;
begin
  inherited;
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao: TConsultasArray;
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrTransp: TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key,
    arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodVen, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.edtDocFatExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtDocFat.Text)) Then
    edtDocFat.Text := fStrZero(edtDocFat.Text, edtDocFat.TamCampo);
end;

procedure TfrmLiberacaoAcompEntregas.edtRegCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao: TConsultasArray;
begin
  If fPesqRegiao(Self, edtRegCli, edtNomRegCli, Nil, Key, arrRegiao) Then
  Begin
    If fValidaCampos(edtRegCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := fCriaQuery(Self);

  pSetaCodIte(edtCodIte);

  dspDados := TUniDataSetProvider.Create(Self);
  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.SetProvider(dspDados);
  cdsDados.ReadOnly := False;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  dtsDados.DataSet := cdsDados;

  dspDados.DataSet := qryDados;

  cdsDados.AfterScroll := pAfterScroll;
  cdsDados.AfterOpen := pAfterOpen;

  pCriaCdsRoma;

  bnDirLibEnt := fVerificaAcessoSistema('LBETAE');

  btnLibEnt.Enabled := bnDirLibEnt;
end;

procedure TfrmLiberacaoAcompEntregas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryDados);
  FreeAndNil(dspDados);
  FreeAndNil(cdsDados);
  FreeAndNil(cdsRoma);
end;

procedure TfrmLiberacaoAcompEntregas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnMarTod.Click
  Else If (Key = VK_F5) Then
    btnAtuali.Click
  Else If (Key = VK_F10) Then
    btnLibEnt.Click
  Else If (Key = VK_F11) Then
    btnExpRec.Click;
end;

function TfrmLiberacaoAcompEntregas.fStatusBaixa(DataSet: TDataSet): String;
begin
  // ENTREGUE TOTALMENTE / ENTREGA PARCIAL / NÃO ENTREGUE.
  If (DataSet.FieldByName('GER_DTABAI').IsNull) Then
    Result := ''
  Else If (DataSet.FieldByName('ENTREGA')
    .AsString = 'Entregue Parcialmente') Then
    Result := 'Entregue Parcialmente'
  Else If (DataSet.FieldByName('GER_ENTREG').AsString = '1') Then
    Result := 'Entregue'
  Else
    Result := 'Não Entregue';

  if (DataSet.FieldByName('GER_BAIFLG').AsString = 'R') then
    Result := Result +' - Reagendamento'
  else if (DataSet.FieldByName('GER_BAIFLG').AsString = 'D') then
    Result := Result +' - Desconsiderar'
  else if (DataSet.FieldByName('GER_BAIFLG').AsString = 'P') then
    Result := Result +' - Pendente';
end;

function TfrmLiberacaoAcompEntregas.fTemRomaneioMarcado: Boolean;
Var
  cdsClone: TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsDados);
    cdsClone.Filter := 'MARDES = ' + QuotedStr('M');
    cdsClone.Filtered := True;
    Result := (Not cdsClone.IsEmpty);
    cdsClone.Close;
  Finally
    FreeAndNil(cdsClone)
  End;
end;

function TfrmLiberacaoAcompEntregas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskDtaIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      mskDtaFin.Clear;
      mskDtaFin.Enabled := False;
    End
    Else
      mskDtaFin.Enabled := True;
  End
  Else If (Sender = mskDtaFin) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&OK']);
        Sender := mskDtaIni;
        Result := False;
      End
      Else If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!',
          'A data final deve ser maior que a data inicial!', ['&OK']);
        Result := False;
      End;
    End
    Else
    Begin
      If Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&OK']);
        Sender := mskDtaFin;
        Result := False;
      End
    End;
  End
  Else If (Sender = edtCodCli) Then
  Begin
    If (fEmptyStr(edtCodCli.Text)) Then
      edtDesCliente.Text := 'TODOS'
    Else
    Begin
      edtDesCliente.Text := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'],
        [edtCodCli.Text]);
      If fEmptyStr(edtDesCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodCid) Then
  Begin
    If (fEmptyStr(edtCodCid.Text)) Then
      edtDesCidade.Text := 'TODAS'
    Else
    Begin
      edtDesCidade.Text := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'],
        [edtCodCid.Text], False);
      If fEmptyStr(edtDesCidade.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodEmp) Then
  Begin
    If (fEmptyStr(edtCodEmp.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa do romaneio deve ser preenchida!',
        ['&OK']);
      Result := False;
    End
    Else
    Begin
      edtDesEmpresa.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'],
        [edtCodEmp.Text], False);
      If fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodMot) Then
  Begin
    If (fEmptyStr(edtCodMot.Text)) Then
      edtNomMot.Text := 'TODOS'
    Else
    Begin
      edtNomMot.Text := fCampoTabela('MOT_NOMMOT', 'CADMOT', ['MOT_CODMOT'],
        [edtCodMot.Text]);
      If fEmptyStr(edtNomMot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = mskPlaVei) Then
  Begin

    If fVeiculoInativo(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Begin
      edtDesVei.Text := '';
      fMensagem('','Este veículo está inativo.',['&O k']);
      Result := False;
    End
    Else
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text))) Then
        edtDesVei.Text := 'TODOS'
      Else
      Begin
        edtDesVei.Text := fRetornaDescricaoVeic
          (fTiraCaracEspeciais(mskPlaVei.Text));
        If fEmptyStr(edtDesVei.Text) Then
        Begin
          fMensagem('', 'Nenhum veículo cadastrado com esta placa!', ['&OK']);
          Result := False;
        End
      End;
    End;
  End
  Else If (Sender = edtCodVen) Then
  Begin
    If (fEmptyStr(edtCodVen.Text)) Then
      edtNomVen.Text := 'TODOS'
    Else
    Begin
      edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
      If fEmptyStr(edtNomVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodReg) Then
  Begin
    If (fEmptyStr(edtCodReg.Text)) Then
      edtNomReg.Text := 'TODAS'
    Else
    Begin
      edtNomReg.Text := fCampoTabela('REG_DESREG', 'CADREG', ['REG_CODREG'],
        [edtCodReg.Text]);
      If (fEmptyStr(edtNomReg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Região não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtRegCli) Then
  Begin
    If (fEmptyStr(edtRegCli.Text)) Then
      edtNomRegCli.Text := 'TODAS'
    Else
    Begin
      edtNomRegCli.Text := fCampoTabela('REG_DESREG', 'CADREG', ['REG_CODREG'],
        [edtRegCli.Text]);
      If (fEmptyStr(edtNomRegCli.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Região não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodTra) Then
  Begin
    If (fEmptyStr(edtCodTra.Text)) Then
      edtNomTra.Text := 'TODAS'
    Else
    Begin
      edtNomTra.Text := fCampoTabela('TRA_NOMTRA', 'CADTRA', ['TRA_CODTRA'],
        [edtCodTra.Text]);
      If (fEmptyStr(edtNomTra.Text)) Then
      Begin
        fMensagem('ATENÇÃO!',
          'Essa Transportadora não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodAju) Then
  Begin
    If (fEmptyStr(edtCodAju.Text)) Then
      edtNomAju.Text := 'TODOS'
    Else
    Begin
      edtNomAju.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAju.Text], False);
      If fEmptyStr(edtNomAju.Text) Then
      Begin
        fMensagem('', 'Este ajudante não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodIte) Then
  Begin
    If (fEmptyStr(edtCodIte.Text)) Then
      edtDesIte.Text := 'TODOS'
    Else
    Begin
      edtDesIte.Text := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'],
        [edtCodIte.Text]);
      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('', 'Este item não está cadastrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtEspFat) Then
  Begin
    If (Not fEmptyStr(edtDocFat.Text)) Then
    Begin
      If (fEmptyStr(edtEspFat.Text)) Then
      Begin
        fMensagem('', 'Espécie do documento deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmLiberacaoAcompEntregas.mskPlaVeiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrVei: TConsultasArray;
begin
  inherited;
  If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, arrVei, True, False, ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLiberacaoAcompEntregas.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    (FieldByName('GER_VLRCON') As TFloatField).DisplayFormat := '#,###0.00';
  End;
  pAfterScroll(DataSet);
end;

procedure TfrmLiberacaoAcompEntregas.pAfterScroll(DataSet: TDataSet);
Var
  strDtaHra: String;
begin
  if not cdsDados.ControlsDisabled then
  begin
    btnItensDaNota.Enabled :=
      (cdsDados.FieldByName('ENTREGA').AsString <> 'Não Entregue') and
      (cdsDados.RecordCount > 0);

    edtRecPor.Text := DataSet.FieldByName('GER_NOMREC').AsString;
    edtStaBai.Text := fStatusBaixa(DataSet);

//    edtMotivo.Text := '';
//    If Pos('Não Entregue', DataSet.FieldByName('STAENT').AsString) > 0 Then
//      edtMotivo.Text := DataSet.FieldByName('MOTBAI').AsString;

    edtMotivo.Text := DataSet.FieldByName('MOTBAI').AsString;

    edtAjuda1.Text := DataSet.FieldByName('NOMAJ1').AsString;
    edtAjuda2.Text := DataSet.FieldByName('NOMAJ2').AsString;
    edtAjuda3.Text := DataSet.FieldByName('NOMAJ3').AsString;
    edtAjuda4.Text := DataSet.FieldByName('NOMAJ4').AsString;

    strDtaHra := '';

    If Not DataSet.FieldByName('GER_DTABAI').IsNull Then
      strDtaHra := FormatDateTime('dd/mm/yyyy', DataSet.FieldByName('GER_DTABAI')
        .AsDateTime) + ' - ';

    If Not DataSet.FieldByName('GER_HORBAI').IsNull Then
      strDtaHra := strDtaHra + FormatDateTime('hh:nn:ss',
        DataSet.FieldByName('GER_HORBAI').AsDateTime);

    edtDtaHraBai.Text := strDtaHra;

    btnLibEnt.Enabled := (bnDirLibEnt) And
      (DataSet.FieldByName('GER_LIBENT').AsString = 'N');

    btnRecImg.Enabled := (DataSet.FieldByName('RECIMG').asString = 'S');
    btnFacImg.Enabled := (DataSet.FieldByName('FACIMG').asString = 'S');

    btnReagendar.Enabled := (DataSet.FieldByName('GER_BAIFLG').AsString = 'P');
    btnDesconsiderar.Enabled := (DataSet.FieldByName('GER_BAIFLG').AsString = 'P');
  end;
end;

procedure TfrmLiberacaoAcompEntregas.pCriaCdsRoma;
begin
  cdsRoma := TUniClientDataSet.Create(nil);

  With cdsRoma.FieldDefs.AddFieldDef Do
  Begin
    Name := 'GER_NUMROM';
    DataType := ftString;
    Size := 6;
  End;

  With cdsRoma.FieldDefs.AddFieldDef Do
  Begin
    Name := 'GER_EMPROM';
    DataType := ftString;
    Size := 3;
  End;

  cdsRoma.IndexFieldNames := 'GER_NUMROM;GER_EMPROM';
  cdsRoma.CreateDataSet;
end;

function TfrmLiberacaoAcompEntregas.fDesconsiderarRomaneio(pgbStatus: TcxProgressBar) :Boolean;
Var
  strEntreg: String;
  objHisPed: THisPed;
  qryRomObs: TUniQuery;
  qryPedido: TUniQuery;
  qryItens: TUniQuery;

  objOcoCrm: TAtuOcoCrm;

  blnGerarNovoPreRomaneio: Boolean;
  strNumeroNovoPreRomaneio: String;

  strSQL: String;

  procedure pCancelar;
  begin
    FreeAndNil(objHisPed);
    FreeAndNil(qryRomObs);
    FreeAndNil(qryPedido);
    cdsDados.EnableControls;
  End;

  procedure pFlagDesconsiderar;
  var
    qryUpdate: TUniQuery;
  begin
    qryUpdate := fCriaQuery(Self);

    try
      fStartTransaction;

      with qryUpdate, SQL do
      begin
        Append(' UPDATE ROMGERX ');
        Append(' SET ');
        Append(' GER_BAIFLG = "D" ');
        Append(' WHERE ');
        Append(' GER_NUMROM = :NUMROM ');
        Append(' AND GER_EMPROM = :EMPROM ');
        Append(' AND GER_CODCLI = :CODCLI ');
        Append(' AND GER_NUMFAT = :NUMFAT ');
        Append(' AND GER_TIPFAT = :TIPFAT ');

        ParamByName('NUMROM').AsString := cdsDados.FieldByName('GER_NUMROM').AsString;
        ParamByName('EMPROM').AsString := cdsDados.FieldByName('GER_EMPROM').AsString;
        ParamByName('CODCLI').AsString := cdsDados.FieldByName('GER_CODCLI').AsString;
        ParamByName('NUMFAT').AsString := cdsDados.FieldByName('GER_NUMFAT').AsString;
        ParamByName('TIPFAT').AsString := cdsDados.FieldByName('GER_TIPFAT').AsString;

        ExecSQL;
      end;

      fCommit;
    finally
      FreeAndNil(qryUpdate);

      Result := True;
    end;
  end;

  procedure fAtualizaInformacoesCRMLocal(strNumDoc, strEspDoc,
    strCodEmp: String; strNumOrc: String = ''; strEspOrc: String = '');
  begin
    objOcoCrm := fAtualizaInformacoesCRM(strNumDoc, strEspDoc, strCodEmp,
      cdsDados.FieldByName('GER_CODCLI').AsString, strNumOrc, strEspOrc,
      strLoginUsuarioLogado, afcRomaneioBaixa);

    objOcoCrm.strDHBaix := FormatDateTime('dd/mm/yyyy hh:nn', Date);
    objOcoCrm.strNomRec := cdsDados.FieldByName('CLI_NOMCLI').AsString;
    objOcoCrm.strNumRom := cdsDados.FieldByName('GER_NUMROM').AsString;
    objOcoCrm.strNomFrm := Self.Name;

    TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
  end;

  Function fRetValSel: String;
  Begin
    Result := '(DET_QTDBAI * DET_UNITAR) - (DET_QTDBAI * (DET_DESESP / DET_QTDITE)) DET_VALSEL ';
  End;

begin
  Result := False;

  strNumeroNovoPreRomaneio := '';
  blnGerarNovoPreRomaneio := fCfgSis('USPRRO', varBoolean) And
    (Not fCfgSis('ROMPAR', varBoolean)) And fCfgSis('GERPRO', varBoolean);

  cdsDados.DisableControls;
  objHisPed := THisPed.Create(Self);

  qryRomObs := fCriaQuery;
  qryRomObs.Options.SetFieldsReadOnly := False;

  qryItens := fCriaQuery;

  qryPedido := fCriaQuery;
  qryPedido.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP');
  qryPedido.SQL.Add('FROM FATGOR');
  qryPedido.SQL.Add('WHERE FGO_NUMFAT = :NUMDOC');
  qryPedido.SQL.Add('  AND FGO_TIPFAT = :ESPDOC');
  qryPedido.SQL.Add('  AND FGO_EMPFAT = :CODEMP');

  Try
    fStartTransaction;

    qryRomObs.Close;
    qryRomObs.SQL.Clear;
    qryRomObs.SQL.Add(' SELECT * ');
    qryRomObs.SQL.Add('   FROM ROMOBSX ');
    qryRomObs.SQL.Add('  WHERE OBS_NUMROM = ' +
      Quotedstr(cdsDados.FieldByName('GER_NUMROM').AsString));
    qryRomObs.SQL.Add('    AND OBS_NUMDOC = ' +
      Quotedstr(cdsDados.FieldByName('GER_NUMDOC').AsString));
    qryRomObs.SQL.Add('    AND OBS_ESPDOC = ' +
      Quotedstr(cdsDados.FieldByName('GER_ESPDOC').AsString));
    qryRomObs.SQL.Add('    AND OBS_EMPDOC = ' +
      Quotedstr(cdsDados.FieldByName('GER_CODEMP').AsString));
    qryRomObs.SQL.Add('    AND OBS_CODCLI = ' +
      Quotedstr(cdsDados.FieldByName('GER_CODCLI').AsString));
    qryRomObs.Open;

    If (qryRomObs.IsEmpty) Then
      qryRomObs.Append
    Else
      qryRomObs.Edit;

    qryRomObs.FieldByName('AUTOINCREM').AsString :=
      fRetAutoIncrem('ROMOBSX', VS_strCodEmp);
    qryRomObs.FieldByName('OBS_NUMROM').AsString :=
      cdsDados.FieldByName('GER_NUMROM').AsString;
    qryRomObs.FieldByName('OBS_EMPROM').AsString :=
      cdsDados.FieldByName('GER_EMPROM').AsString;
    qryRomObs.FieldByName('OBS_NUMDOC').AsString :=
      cdsDados.FieldByName('GER_NUMDOC').AsString;
    qryRomObs.FieldByName('OBS_ESPDOC').AsString :=
      cdsDados.FieldByName('GER_ESPDOC').AsString;
    qryRomObs.FieldByName('OBS_EMPDOC').AsString :=
      cdsDados.FieldByName('GER_CODEMP').AsString;
    qryRomObs.FieldByName('OBS_CODCLI').AsString :=
      cdsDados.FieldByName('GER_CODCLI').AsString;
    qryRomObs.FieldByName('OBS_OBSERV').AsString :=
      qryRomObs.FieldByName('OBS_OBSERV').AsString +'<<csq>>' +
      'Entrega não realizada, e retirada das entregas do aplicativo.' +
      ' Realizar o procedimento interno pelo Autcom, de devolução da mercadoria';
    qryRomObs.Post;

    strEntreg := 'S';

    Result := objHisPed.fAtualizarHistorico(
      cdsDados.FieldByName('GER_NUMDOC').AsString,
      cdsDados.FieldByName('GER_ESPDOC').AsString,
      cdsDados.FieldByName('GER_CODEMP').AsString,
      cdsDados.FieldByName('GER_NUMROM').AsString,
      cdsDados.FieldByName('GER_NOMREC').AsString,
      IIF(cdsDados.FieldByName('GER_DTABAI').AsDateTime = 0, VS_Date,
      cdsDados.FieldByName('GER_DTABAI').AsDateTime),
      IIF(cdsDados.FieldByName('GER_HORBAI').AsDateTime = 0, fTime(),
      cdsDados.FieldByName('GER_HORBAI').AsDateTime), strEntreg,
      cdsDados.FieldByName('MOTBAI').AsString +
        '<<csq>>Entrega não realizada, e retirada das entregas do aplicativo. Realizar o procedimento interno pelo Autcom, de devolução da mercadoria'
    );

    If (Result) And (VS_strHabilitarCRM) And
      (Not fEmptyStr(fCfgSis('VENORC', varString))) And
      (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
    begin
      If fCfgSis('OPCROM', varInteger) = 1 Then
      Begin
        fAtualizaInformacoesCRMLocal(cdsDados.FieldByName('GER_NUMDOC')
          .AsString, cdsDados.FieldByName('GER_ESPDOC').AsString,
          cdsDados.FieldByName('GER_CODEMP').AsString);
      End
      Else
      Begin
        qryPedido.Close;
        qryPedido.ParamByName('NUMDOC').AsString :=
          cdsDados.FieldByName('GER_NUMDOC').AsString;
        qryPedido.ParamByName('ESPDOC').AsString :=
          cdsDados.FieldByName('GER_ESPDOC').AsString;
        qryPedido.ParamByName('CODEMP').AsString :=
          cdsDados.FieldByName('GER_CODEMP').AsString;
        qryPedido.Open;

        If Not qryPedido.IsEmpty Then
        Begin
          qryPedido.First;
          While Not qryPedido.Eof Do
          Begin
            fAtualizaInformacoesCRMLocal
              (cdsDados.FieldByName('GER_NUMDOC').AsString,
              cdsDados.FieldByName('GER_ESPDOC').AsString,
              qryPedido.FieldByName('FGO_CODEMP').AsString,
              qryPedido.FieldByName('FGO_NUMDOC').AsString,
              qryPedido.FieldByName('FGO_ESPDOC').AsString);

            qryPedido.Next;
          End;
        End;
      End;
    end;

    If (Not Result) Then
      fRollBack;

    If (strEntreg = 'N') Then
    Begin
      If blnGerarNovoPreRomaneio Then
      Begin
        Result := fGerarNovoPreRomaneio(strNumeroNovoPreRomaneio,
          cdsDados.FieldByName('GER_NUMROM').AsString,
          cdsDados.FieldByName('GER_EMPROM').AsString,
          cdsDados.FieldByName('GER_NUMDOC').AsString,
          cdsDados.FieldByName('GER_ESPDOC').AsString,
          cdsDados.FieldByName('GER_CODEMP').AsString);
      End
      Else
      Begin
        Result := fRemoverDocumento(cdsDados.FieldByName('GER_NUMDOC').AsString,
                                    cdsDados.FieldByName('GER_ESPDOC').AsString,
                                    cdsDados.FieldByName('GER_CODEMP').AsString,
                                    cdsDados.FieldByName('GER_CODCLI').AsString,
                                    cdsDados.FieldByName('GER_NUMROM').AsString,
                                    cdsDados.FieldByName('GER_CODVEN').AsString,
                                    cdsDados.FieldByName('MOT_CODMOT').AsString,
                                    cdsDados.FieldByName('GER_DTAENT').AsDateTime,
                                    cdsDados.FieldByName('GER_HORENT').AsDateTime,
                                    cdsDados.FieldByName('MOTBAI').AsString);
      End;
    End
    Else
    Begin
      Try
        strSQL := '';
        strSQL := strSQL + ' SELECT SQL_NO_CACHE    ';
        strSQL := strSQL + '          DET_SEQGER,   ';
        strSQL := strSQL + '          DET_CODITE,   ';
        strSQL := strSQL + '          DET_DESCRI,   ';
        strSQL := strSQL + '          DET_NUMLOT,   ';
        strSQL := strSQL + '          DET_QTDITE,   ';
        strSQL := strSQL + '          DET_QTDBAI,   ';
        strSQL := strSQL + '   "M" AS DET_MARDES,   ';
        strSQL := strSQL + '          DET_NUMROM,   ';
        strSQL := strSQL + '          DET_CODEMP,   ';
        strSQL := strSQL + '          AUTOINCREM,   ';
        strSQL := strSQL + '          DET_AUTINC,   ';
        strSQL := strSQL + '          DET_UNITAR,   ';
        strSQL := strSQL + '          DET_DESESP,   ';
        strSQL := strSQL + '      ' + fRetValSel;
        strSQL := strSQL + ' FROM                   ';
        strSQL := strSQL + '   ROMDETX              ';
        strSQL := strSQL + ' WHERE                  ';
        strSQL := strSQL + '   DET_SEQGER = :SEQGER ';

        qryItens.Close;
        qryItens.SQL.Clear;
        qryItens.SQL.Add(strSQL);
        qryItens.ParamByName('SEQGER').AsString :=
          cdsDados.FieldByName('AUTOINCREM').AsString;
        qryItens.Open;

        pSetaClient(qryItens);
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '');
        End;
      End;

      If (qryItens.Active) Then
      Begin
        qryItens.Filtered := False;
        // qryItens.Filter   := 'DET_SEQGER = ' + QuotedStr(cdsDados.FieldByName('AUTOINCREM').AsString) + ' AND DET_MARDES <> ' + QuotedStr('M');
        qryItens.Filter := 'DET_SEQGER = ' +
          Quotedstr(cdsDados.FieldByName('AUTOINCREM').AsString);
        qryItens.Filtered := True;

        qryItens.First;

        while not qryItens.Eof do
        begin
          Result := fRemoverItemDocto
            (cdsDados.FieldByName('GER_NUMDOC').AsString,
            cdsDados.FieldByName('GER_ESPDOC').AsString,
            cdsDados.FieldByName('GER_CODEMP').AsString,
            cdsDados.FieldByName('GER_CODCLI').AsString,
            cdsDados.FieldByName('GER_NUMROM').AsString,
            qryItens.FieldByName('DET_CODITE').AsString,

            ((qryItens.FieldByName('DET_QTDITE').AsFloat *
            qryItens.FieldByName('DET_UNITAR').AsFloat) -
            (qryItens.FieldByName('DET_QTDITE').AsFloat
            * (qryItens.FieldByName('DET_DESESP').AsFloat
            / qryItens.FieldByName('DET_QTDITE').AsFloat))),

            qryItens.FieldByName('DET_QTDITE').AsFloat,
            qryItens.FieldByName('DET_AUTINC').AsString,
            cdsDados.FieldByName('GER_NOMTAB').AsString);

          If (Result) Then
            Result := fRemoverRomDet(qryItens.FieldByName('DET_NUMROM')
              .AsString, qryItens.FieldByName('DET_SEQGER').AsString,
              qryItens.FieldByName('DET_CODEMP').AsString,
              qryItens.FieldByName('AUTOINCREM').AsString,
              cdsDados.FieldByName('GER_NUMDOC').AsString,
              cdsDados.FieldByName('GER_ESPDOC').AsString,
              cdsDados.FieldByName('GER_CODCLI').AsString,
              cdsDados.FieldByName('GER_CODVEN').AsString,
              cdsDados.FieldByName('MOT_CODMOT').AsString,
              cdsDados.FieldByName('GER_DTAENT').AsDateTime,
              cdsDados.FieldByName('GER_HORENT').AsDateTime,
              qryItens.FieldByName('DET_CODITE').AsString,
              qryItens.FieldByName('DET_QTDITE').AsFloat,
              qryItens.FieldByName('DET_QTDITE').AsFloat,
              qryItens.FieldByName('DET_AUTINC').AsString,
              '',
              '',
              cdsDados.FieldByName('GER_DTADOC').AsDateTime,
              cdsDados.FieldByName('GER_VOLUME').AsFloat);

          qryItens.Next;
        End;

        qryItens.Filtered := False;
        qryItens.EnableControls;
      End;

      If (Result) Then
      begin
        qryItens.Close;
        qryItens.SQL.Clear;
        qryItens.SQL.Add(strSQL);
        qryItens.ParamByName('SEQGER').AsString :=
          cdsDados.FieldByName('AUTOINCREM').AsString;
        qryItens.Open;

        if qryItens.IsEmpty then
        begin
          Result :=
            fRemoverDocumento(cdsDados.FieldByName('GER_NUMDOC').AsString,
              cdsDados.FieldByName('GER_ESPDOC').AsString,
              cdsDados.FieldByName('GER_CODEMP').AsString,
              cdsDados.FieldByName('GER_CODCLI').AsString,
              cdsDados.FieldByName('GER_NUMROM').AsString,
              cdsDados.FieldByName('GER_CODVEN').AsString,
              cdsDados.FieldByName('MOT_CODMOT').AsString,
              cdsDados.FieldByName('GER_DTAENT').AsDateTime,
              cdsDados.FieldByName('GER_HORENT').AsDateTime,
              cdsDados.FieldByName('MOTBAI').AsString);
        end
        else
        begin
          Result := fBaixarDocumento(cdsDados.FieldByName('GER_NUMDOC').AsString,
            cdsDados.FieldByName('GER_ESPDOC').AsString,
            cdsDados.FieldByName('GER_CODEMP').AsString,
            cdsDados.FieldByName('GER_CODCLI').AsString,
            cdsDados.FieldByName('GER_NUMROM').AsString,
            cdsDados.FieldByName('GER_NOMREC').AsString,
            IIF(cdsDados.FieldByName('GER_DTABAI').AsDateTime = 0, VS_Date,
            cdsDados.FieldByName('GER_DTABAI').AsDateTime),
            IIF(cdsDados.FieldByName('GER_HORBAI').AsDateTime = 0, fRetHoraServidor,
            cdsDados.FieldByName('GER_HORBAI').AsDateTime), strEntreg, 'S',
            '','','',
            cdsDados.FieldByName('GER_DTAROM').AsDateTime,
            cdsDados.FieldByName('GER_DTADOC').AsDateTime,
            cdsDados.FieldByName('GER_VOLUME').AsFloat);
        end;
      end;
    End;

    If (Not Result) Then
      fRollBack;

    pFlagDesconsiderar;

    If (Result) Then
    Begin
      fCommit;
      Result := True;
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fDesconsiderarRomaneio]');
    End;
  End;

  If Result And Not fEmptyStr(strNumeroNovoPreRomaneio) Then
  Begin
    pMensagemOk('Foi gerado novo Romaneio Nº ' + strNumeroNovoPreRomaneio + ' '
      + 'com os documentos não entregues!');
  End;

  pCancelar;
end;

function TfrmLiberacaoAcompEntregas.fGerarNovoPreRomaneio(var strRomNov: String;
  strNumRom, strEmpRom, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  qryUpd: TUniQuery;
  qryGer: TUniQuery;
  qryDet: TUniQuery;
  intCnt: Integer;
  strFieldName: String;

  procedure pSetaParametrosUpdate(qry: TUniQuery);
  begin
    If qry.FindParam('ROMNOV') <> Nil Then
      qry.ParamByName('ROMNOV').AsString := strRomNov;

    If qry.FindParam('NUMROM') <> Nil Then
      qry.ParamByName('NUMROM').AsString := strNumRom;

    If qry.FindParam('EMPROM') <> Nil Then
      qry.ParamByName('EMPROM').AsString := strEmpRom;

    If qry.FindParam('NUMDOC') <> Nil Then
      qry.ParamByName('NUMDOC').AsString := strNumDoc;

    If qry.FindParam('ESPDOC') <> Nil Then
      qry.ParamByName('ESPDOC').AsString := strEspDoc;

    If qry.FindParam('CODEMP') <> Nil Then
      qry.ParamByName('CODEMP').AsString := strCodEmp;
  end;

begin
  Result := True;

  If fEmptyStr(strRomNov) Then
    strRomNov := fAtualizaProCod('ROMGERX', 'GER_NUMROM');

  qryUpd := fCriaQuery;
  qryGer := fCriaQuery;
  qryDet := fCriaQuery;
  fStartTransaction;
  Try
    Try
      With qryGer Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM ROMGERX ');
        SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
        SQL.Add('    AND GER_EMPROM = :EMPROM ');
        SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
        SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
        SQL.Add('    AND GER_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(qryGer);
        Open;
      end;

      With qryDet Do
      begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT * ');
        SQL.Add('   FROM ROMDETX ');
        SQL.Add('  WHERE DET_NUMROM = :NUMROM ');
        SQL.Add('    AND DET_EMPROM = :EMPROM ');
        SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
        SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
        SQL.Add('    AND DET_CODEMP = :CODEMP ');
        pSetaParametrosUpdate(qryDet);
        Open;
      end;

      qryUpd.Close;
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add(' DELETE ');
      qryUpd.SQL.Add('   FROM ROMGERX ');
      qryUpd.SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
      qryUpd.SQL.Add('    AND GER_EMPROM = :EMPROM ');
      qryUpd.SQL.Add('    AND GER_NUMDOC = :NUMDOC ');
      qryUpd.SQL.Add('    AND GER_ESPDOC = :ESPDOC ');
      qryUpd.SQL.Add('    AND GER_CODEMP = :CODEMP ');
      pSetaParametrosUpdate(qryUpd);
      qryUpd.ExecSQL;

      qryUpd.Close;
      qryUpd.SQL.Text := 'SELECT * FROM ROMGERX WHERE FALSE ';
      qryUpd.Open;

      qryUpd.Append;

      For intCnt := 0 To qryUpd.FieldCount - 1 Do
      Begin
        strFieldName := qryUpd.Fields[intCnt].FieldName;
        If qryGer.FindField(strFieldName) <> Nil Then
          qryUpd.FieldByName(strFieldName).Value :=
            qryGer.FieldByName(strFieldName).Value;
      End;
      qryUpd.FieldByName('GER_NUMROM').AsString := strRomNov;
      qryUpd.FieldByName('GER_STATUS').AsString := 'P';
      qryUpd.FieldByName('GER_CODREG').Value := Null;
      qryUpd.FieldByName('GER_FRETE_').AsFloat := 0;
      qryUpd.FieldByName('GER_ADIFRE').AsFloat := 0;
      qryUpd.FieldByName('GER_PERFRE').AsFloat := 0;
      qryUpd.Post;

      qryUpd.Close;
      qryUpd.SQL.Text := 'SELECT * FROM ROMDETX WHERE FALSE ';
      qryUpd.Open;

      qryDet.First;
      While Not qryDet.Eof Do
      Begin
        qryUpd.Append;
        For intCnt := 0 To qryUpd.FieldCount - 1 Do
        Begin
          strFieldName := qryUpd.Fields[intCnt].FieldName;
          If qryDet.FindField(strFieldName) <> Nil Then
            qryUpd.FieldByName(strFieldName).Value :=
              qryDet.FieldByName(strFieldName).Value;
        End;
        qryUpd.FieldByName('DET_NUMROM').AsString := strRomNov;
        qryUpd.Post;

        qryDet.Next;
      End;

      qryUpd.Close;
      qryUpd.SQL.Text := ' UPDATE FATGOR ' + '   SET FGO_NUMROM = :ROMNOV ' +
        ' WHERE FGO_NUMROM = :NUMROM AND ' + '       FGO_NUMDOC = :NUMDOC AND '
        + '       FGO_ESPDOC = :ESPDOC AND ' +
        '       FGO_CODEMP = :CODEMP     ';

      pSetaParametrosUpdate(qryUpd);
      qryUpd.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,
          '[TfrmFatBaixaRomaneio.fGerarNovoPreRomaneio]');
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
    FreeAndNil(qryGer);
    FreeAndNil(qryDet);
  End;
end;

function TfrmLiberacaoAcompEntregas.fReagendarRomaneio(pgbStatus: TcxProgressBar) :Boolean;
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery(Self);

  try
    fStartTransaction;

    with qryUpdate, SQL do
    begin
      Append(' UPDATE ROMGERX ');
      Append(' SET ');
      Append(' GER_LIBENT = "N", ');
      Append(' GER_DTABAI = NULL, ');
      Append(' GER_BAIFLG = "R" ');
      Append(' WHERE ');
      Append(' GER_NUMROM = :NUMROM ');
      Append(' AND GER_EMPROM = :EMPROM ');
      Append(' AND GER_CODCLI = :CODCLI ');
      Append(' AND GER_NUMFAT = :NUMFAT ');
      Append(' AND GER_TIPFAT = :TIPFAT ');

      ParamByName('NUMROM').AsString := cdsDados.FieldByName('GER_NUMROM').AsString;
      ParamByName('EMPROM').AsString := cdsDados.FieldByName('GER_EMPROM').AsString;
      ParamByName('CODCLI').AsString := cdsDados.FieldByName('GER_CODCLI').AsString;
      ParamByName('NUMFAT').AsString := cdsDados.FieldByName('GER_NUMFAT').AsString;
      ParamByName('TIPFAT').AsString := cdsDados.FieldByName('GER_TIPFAT').AsString;

      ExecSQL;
    end;

    fCommit;
  finally
    FreeAndNil(qryUpdate);

    Result := True;
  end;
end;

{
  UPDATE ROMGERX SET GER_LIBENT = 'N'
  WHERE GER_JAFATU = 1
  AND GER_TIP_FC = "C"
  AND GER_LIBENT = "S"
  AND GER_DTABAI IS NULL
  AND GER_ENTSAI = "S"
  AND GER_ENVENT = "N"
  ORDER BY GER_DTAFAT
}

procedure TfrmLiberacaoAcompEntregas.pLimparSelecao;
Var
  qryLimpar: TUniQuery;
begin
  qryLimpar := fCriaQuery(Self);

  with qryLimpar do
  begin
    SQL.Append(' UPDATE ROMGERX SET GER_LIBENT = "N" ');
    SQL.Append(' WHERE GER_JAFATU = 1 ');
    SQL.Append('   AND GER_TIP_FC = "C" ');
    SQL.Append('   AND GER_LIBENT = "S" ');
    SQL.Append('   AND GER_DTABAI IS NULL ');
    SQL.Append('   AND GER_ENTSAI = "S" ');
    SQL.Append('   AND GER_ENVENT = "N" ');

    ExecSQL;
  end;
end;

procedure TfrmLiberacaoAcompEntregas.pListarItensDaNota;
var
  blnSTAENT: Boolean;
begin

  If cxgDadosTableView1.Controller.FocusedRow.ClassName = 'TGridDataRowCitel' Then
  Begin

    blnSTAENT := ((Pos('Não Entregue', cdsDados.FieldByName('STAENT').AsString) > 0) or
                  (Pos('Baixado', cdsDados.FieldByName('STAENT').AsString) > 0));

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(189, 7464, [],
                          ['STAENT','DOCFAT','NUMFAT','TIPFAT','CODEMP','NUMROM'],
                          [IfThen(blnSTAENT,'S','N'),
                          cdsDados.FieldByName('DOCFAT').AsString,
                          SplitString(cdsDados.FieldByName('DOCFAT').AsString, '-')[0],
                          SplitString(cdsDados.FieldByName('DOCFAT').AsString, '-')[1],
                          SplitString(cdsDados.FieldByName('DOCFAT').AsString, '-')[2],
                          cdsDados.FieldByName('GER_NUMROM').AsString],
                          nil,
                          nil,
                          True);
    End;

  End
  Else

    fMensagem('Atenção!', 'Deve selecionar uma nota para exibir seus respectivos itens', ['&Ok']);

end;

function TfrmLiberacaoAcompEntregas.fCarregaDados
  (pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  With qryDados Do
  Begin
    cdsDados.Close;

    Close;
    SQL.Clear;
    SQL.Add(' SELECT SQL_NO_CACHE ');

    If (Not fEmptyStr(edtCodIte.Text)) Then
      SQL.Add(' DISTINCT ');

    SQL.Add('        IF(IFNULL(GER_ROMIMP,"") = "", "N", GER_ROMIMP) AS GER_ROMIMP, ');
    SQL.Add('        GER_DTAENT, GER_VLRCON, GER_CODVEN, ');
    SQL.Add('        CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCUME, ');
    SQL.Add('        CONCAT(IFNULL(GER_NUMFAT, ""), "-", IFNULL(GER_TIPFAT, ""), "-", IFNULL(GER_EMPFAT, GER_EMPROM)) AS DOCFAT, ');
    SQL.Add('        CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS CLIENT, ');

    SQL.Add('        CONCAT(GER_NUMROM, " - ", GER_CODCLI, "-", CLI_NOMCLI, IF(MOT_CODMOT IS NOT NULL,CONCAT(" - Motorista: ", MOT_NOMMOT), ');
    SQL.Add('        ""),IF(GER_PLAVEI IS NOT NULL,CONCAT(" (", GER_PLAVEI, IF(VEI_DESVEI IS NOT NULL, CONCAT(" - ", VEI_DESVEI), ""), ")"), "")) AS ROMANE, ');

    SQL.Add('        IF(CIDENT.CID_ESTADO IS NULL, CIDCLI.CID_ESTADO, CIDENT.CID_ESTADO) AS GER_ESTADO, ');
    SQL.Add('        IF(CIDENT.CID_NOMCID IS NULL, CIDCLI.CID_NOMCID, CIDENT.CID_NOMCID) AS CID_NOMCID, ');
    SQL.Add('        "D" AS MARDES, ');
    SQL.Add('        AJUDA1.AJU_NOMAJU AS NOMAJ1, AJUDA2.AJU_NOMAJU AS NOMAJ2, ');
    SQL.Add('        AJUDA3.AJU_NOMAJU AS NOMAJ3, AJUDA4.AJU_NOMAJU AS NOMAJ4, ');
    SQL.Add('        GER_NUMROM, GER_EMPROM, GER_CODCLI, GER_NUMFAT, GER_TIPFAT, GER_NUMDOC, GER_ESPDOC, GER_CODEMP, ');
    SQL.Add('        CLI_NOMCLI, MOT_CODMOT, MOT_NOMMOT, GER_HORENT, ');
    SQL.Add('        GER_LIBENT, GER_OPLIEN, GER_DTLIEN, GER_HRLIEN, ');
    SQL.Add('        GER_NOMREC, ');
    SQL.Add('        GER_DTABAI, ');
    SQL.Add('        GER_HORBAI, ');
    SQL.Add('        GER_ENTGER, ');
    SQL.Add('        IF(RECIMG.IMG_IMGB64 IS NULL, "N", "S") AS RECIMG, ');
    SQL.Add('        IF(FACIMG.IMG_IMGB64 IS NULL, "N", "S") AS FACIMG, ');
    SQL.Add('        MOT_CODMOT, ');
    SQL.Add('        GER_ENTREG, ');
    SQL.Add('        GER_BAIFLG, ');

    SQL.Add('        CONCAT(IF(GER_DTABAI IS NULL, IF(GER_LIBENT = "S", "Entrega em andamento", ');
    SQL.Add('        "AG Liberação"), "Baixado"), IF(GER_BAIFLG = "R", " - Reagendamento", IF(GER_BAIFLG = "D", " - Desconsiderado", IF(GER_BAIFLG = "P", " - Pendente", ""))), IF (GER_BAIAPP = "S", " (Aplicativo)", "")) AS STAENT, ');

    SQL.Add('        (IF((SELECT COUNT(*) FROM ROMITEX ');
    SQL.Add('        WHERE DET_NUMROM = ROMGERX.GER_NUMROM) = 0, "Entregue", IF(GER_BAIFLG = "D", "Não Entregue", "Entregue Parcialmente"))) AS ENTREGA, ');

    SQL.Add('        OBS_OBSERV AS MOTBAI, ');
    SQL.Add('        GER_NOMTAB, ');
    SQL.Add('        GER_DTAROM, ');
    SQL.Add('        GER_VOLUME, ');
    SQL.Add('        GER_DTAENT AS GER_DTADOC, ');
    SQL.Add('        ROMGERX.AUTOINCREM ');
    SQL.Add('   FROM ROMGERX ');
    SQL.Add('   JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ');
    SQL.Add('   JOIN CADCID CIDCLI ON CIDCLI.CID_CODCID = CLI_CODCID ');

    If (Not fEmptyStr(edtCodIte.Text)) Then
    Begin
      SQL.Add('   JOIN ROMDETX ON DET_NUMROM = GER_NUMROM ');
      SQL.Add('               AND DET_EMPROM = GER_EMPROM ');
      SQL.Add('               AND DET_CODITE = :CODITE    ');
    End;

    SQL.Add('   LEFT JOIN CADMOT ON MOT_CODMOT = GER_CODMOT ');
    SQL.Add('   LEFT JOIN CADVEI ON GER_PLAVEI = VEI_PLAVEI ');
    SQL.Add('   LEFT JOIN CADAJU AJUDA1 ON AJUDA1.AJU_CODAJU = GER_CODAJ1 ');
    SQL.Add('   LEFT JOIN CADAJU AJUDA2 ON AJUDA2.AJU_CODAJU = GER_CODAJ2 ');
    SQL.Add('   LEFT JOIN CADAJU AJUDA3 ON AJUDA3.AJU_CODAJU = GER_CODAJ3 ');
    SQL.Add('   LEFT JOIN CADAJU AJUDA4 ON AJUDA4.AJU_CODAJU = GER_CODAJ4 ');
    SQL.Add('   LEFT JOIN RECIMG ON IMG_SEQROM = ROMGERX.AUTOINCREM ');
    SQL.Add('   LEFT JOIN FACIMG ON IMG_SEQENT = ROMGERX.GER_ENTGER ');
    SQL.Add('   LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = GER_ENTGER ');
    SQL.Add('   LEFT JOIN CADCID CIDENT ON ENTCLI.ETC_CIDENT = CIDENT.CID_CODCID ');
    SQL.Add('   LEFT JOIN ROMOBSX ON GER_NUMROM = OBS_NUMROM ');
    SQL.Add('                        AND GER_EMPROM = OBS_EMPROM ');
    SQL.Add('                        AND GER_NUMDOC = OBS_NUMDOC ');
    SQL.Add('                        AND GER_ESPDOC = OBS_ESPDOC ');
    SQL.Add('                        AND GER_CODEMP = OBS_EMPDOC ');
    SQL.Add('                        AND GER_CODCLI = OBS_CODCLI ');

    SQL.Add('  WHERE GER_JAFATU = 1 AND GER_TIP_FC = "C" AND GER_ENTSAI = "S" ');

    If (Not fEmptyStr(edtNumRom.Text)) Then
      SQL.Add(' AND GER_NUMROM = :NUMROM ');

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      SQL.Add(' AND GER_EMPROM = :EMPROM ');

    If (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
      (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))) Then
      SQL.Add(' AND GER_DTAFAT BETWEEN :DTAINI AND :DTAFIN ');

    If (Not fEmptyStr(edtDocFat.Text)) And (Not fEmptyStr(edtEspFat.Text)) Then
    Begin
      SQL.Add(' AND GER_NUMDOC = :NUMDOC ');
      SQL.Add(' AND GER_ESPDOC = :ESPDOC ');
    End;

    If (Not fEmptyStr(edtEmpFat.Text)) Then
      SQL.Add(' AND GER_CODEMP = :CODEMP ');

    If (Not fEmptyStr(edtCodCli.Text)) Then
      SQL.Add(' AND GER_CODCLI = :CODCLI ');

    If (Not fEmptyStr(mskPlaVei.Text)) Then
      SQL.Add(' AND GER_PLAVEI = :PLAVEI ');

    If (Not fEmptyStr(edtCodCid.Text)) Then
      SQL.Add(' AND IF(CIDENT.CID_CODCID IS NULL, CIDCLI.CID_CODCID, CIDENT.CID_CODCID) = :CODCID ');

    If (Not fEmptyStr(edtCodVen.Text)) Then
      SQL.Add(' AND GER_CODVEN = :CODVEN ');

    If (Not fEmptyStr(edtCodMot.Text)) Then
      SQL.Add(' AND GER_CODMOT = :CODMOT ');

    If (Not fEmptyStr(edtCodReg.Text)) Then
      SQL.Add(' AND GER_CODREG = :CODREG ');

    If (Not fEmptyStr(edtCodAju.Text)) Then
      SQL.Add(' AND ((GER_CODAJ1 = :CODAJU) OR (GER_CODAJ2 = :CODAJU) OR (GER_CODAJ3 = :CODAJU) OR (GER_CODAJ4 = :CODAJU)) ');

    If (Not fEmptyStr(edtRegCli.Text)) Then
      SQL.Add(' AND CLI_CODREG = :REGCLI ');

    If (Not fEmptyStr(edtCodTra.Text)) Then
      SQL.Add(' AND GER_CODTRA = :CODTRA ');

    { ************************************************************
       GER_BAIFLG é utilizada apenas quando há uma "Não entrega"
       TOTAL pelo aplicativo. P = Pendente, R = Reagendar,
       D = Desconsiderar. Caso contrário, GER_BAIFLG = NULL
      ************************************************************ }

    SQL.Add(' AND (IFNULL(GER_BAIFLG, "") != "P" ');
    SQL.Add(' AND IFNULL(GER_BAIFLG, "") != "D") ');

    Case rdgCtrEnt.ItemIndex Of
      1:
        begin
          SQL.Add(' AND GER_LIBENT = "N" AND GER_DTABAI IS NULL AND GER_CODMOT IS NOT NULL AND GER_STATUS = "A" ');

          if chkReagendados.Checked then
            SQL.Add(' AND GER_BAIFLG = "R" ');
        end;
      2:
        SQL.Add(' AND GER_LIBENT = "S" AND GER_DTABAI IS NULL ');
      3:
        Begin
          SQL.Add(' AND GER_DTABAI IS NOT NULL ');

          If chkBaixaApp.Checked Then
            SQL.Add(' AND GER_BAIAPP = "S" ');

          SQL.Add(' HAVING FALSE ');

          if chkEntregue.Checked then
          begin
            SQL.Add(' OR ENTREGA = "Entregue" ');
          end;

          if chkEntregueParc.Checked then
          begin
            SQL.Add(' OR ENTREGA = "Entregue Parcialmente" ');
          end;
        End;
    End;

    If (rdgCtrEnt.ItemIndex In [0, 3]) And (fEmptyStr(edtCodIte.Text)) Then
    Begin
      SQL.Add(' UNION ALL ');

      SQL.Add(' SELECT ');
      SQL.Add('   "S" AS GER_ROMIMP, ');
      SQL.Add('   GER_DTAROM AS GER_DTAENT, 0.00 AS GER_VLRCON, GER_CODVEN AS GER_CODVEN, ');
      SQL.Add('        CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCUME, ');
      SQL.Add('        CONCAT(IFNULL(GER_NUMFAT, ""), "-", IFNULL(GER_TIPFAT, ""), "-", IFNULL(GER_EMPFAT, GER_EMPROM)) AS DOCFAT, ');
      SQL.Add('   CONCAT(GER_CODCLI, "-", CLI_NOMCLI) AS CLIENT, ');

      SQL.Add('        CONCAT(GER_NUMROM, " - ", GER_CODCLI, "-", CLI_NOMCLI, IF(MOT_CODMOT IS NOT NULL,CONCAT(" - Motorista: ", MOT_NOMMOT), ');
      SQL.Add('        ""),IF(GER_PLAVEI IS NOT NULL,CONCAT(" (", GER_PLAVEI, IF(VEI_DESVEI IS NOT NULL, CONCAT(" - ", VEI_DESVEI), ""), ")"), "")) AS ROMANE, ');

      SQL.Add('   IF(CIDENT.CID_ESTADO IS NULL, CIDCLI.CID_ESTADO, CIDENT.CID_ESTADO) AS GER_ESTADO, ');
      SQL.Add('   IF(CIDENT.CID_NOMCID IS NULL, CIDCLI.CID_NOMCID, CIDENT.CID_NOMCID) AS CID_NOMCID, ');
      SQL.Add('   "D" AS MARDES, ');
      SQL.Add('   AJUDA1.AJU_NOMAJU AS NOMAJ1, AJUDA2.AJU_NOMAJU AS NOMAJ2, ');
      SQL.Add('   AJUDA3.AJU_NOMAJU AS NOMAJ3, AJUDA4.AJU_NOMAJU AS NOMAJ4, ');
      SQL.Add('   GER_NUMROM, GER_EMPROM, GER_CODCLI, GER_NUMFAT, GER_TIPFAT, GER_NUMDOC, GER_ESPDOC, GER_CODEMP, ');
      SQL.Add('   CLI_NOMCLI, MOT_CODMOT, MOT_NOMMOT, GER_HORENT, ');
      SQL.Add('   "S" AS GER_LIBENT, NULL AS GER_OPLIEN, NULL AS GER_DTLIEN, NULL AS GER_HRLIEN, ');
      SQL.Add('   GER_NOMREC, ');
      SQL.Add('   GER_DTABAI AS GER_DTABAI, ');
      SQL.Add('   GER_HORBAI AS GER_HORBAI, ');
      SQL.Add('   GER_ENTGER, ');
      SQL.Add('   IF(RECIMG.IMG_IMGB64 IS NULL, "N", "S") AS RECIMG, ');
      SQL.Add('   IF(FACIMG.IMG_IMGB64 IS NULL, "N", "S") AS FACIMG, ');
      SQL.Add('   MOT_CODMOT, ');
      SQL.Add('   "GER_ENTREG" AS GER_ENTREG, ');
      SQL.Add('   GER_BAIFLG, ');

      SQL.Add('   CONCAT("Não Entregue", IF(GER_BAIFLG = "R", " - Reagendamento", IF(GER_BAIFLG = "D", " - Desconsiderado", IF(GER_BAIFLG = "P", " - Pendente", ""))), IF(GER_BAIAPP = "S", " (Aplicativo)", "")) AS STAENT, ');
      SQL.Add('   "Não Entregue" AS ENTREGA, ');
      SQL.Add('   OBS_OBSERV AS MOTBAI, ');
      SQL.Add('   GER_NOMTAB, ');
      SQL.Add('   GER_DTAROM, ');
      SQL.Add('   GER_VOLUME, ');
      SQL.Add('   GER_DTAENT AS GER_DTADOC, ');
      SQL.Add('   ROMGERX.AUTOINCREM ');
      SQL.Add(' FROM ROMGERX ');
      SQL.Add(' JOIN CADCLI ON CLI_CODCLI = GER_CODCLI ');
      SQL.Add(' JOIN CADCID CIDCLI ON CIDCLI.CID_CODCID = CLI_CODCID ');
      SQL.Add(' LEFT JOIN CADCID CIDENT ON GER_CIDCON = CIDENT.CID_CODCID ');
      SQL.Add(' LEFT JOIN CADMOT ON MOT_CODMOT = GER_CODMOT ');
      SQL.Add(' LEFT JOIN CADAJU AJUDA1 ON AJUDA1.AJU_CODAJU = GER_CODAJ1 ');
      SQL.Add(' LEFT JOIN CADAJU AJUDA2 ON AJUDA2.AJU_CODAJU = GER_CODAJ2 ');
      SQL.Add(' LEFT JOIN CADAJU AJUDA3 ON AJUDA3.AJU_CODAJU = GER_CODAJ3 ');
      SQL.Add(' LEFT JOIN CADAJU AJUDA4 ON AJUDA4.AJU_CODAJU = GER_CODAJ4 ');
      SQL.Add(' LEFT JOIN CADVEI ON GER_PLAVEI = VEI_PLAVEI ');
      SQL.Add(' LEFT JOIN ROMOBSX ON GER_NUMROM = OBS_NUMROM ');
      SQL.Add('                      AND GER_EMPROM = OBS_EMPROM ');
      SQL.Add('                      AND GER_NUMDOC = OBS_NUMDOC ');
      SQL.Add('                      AND GER_ESPDOC = OBS_ESPDOC ');
      SQL.Add('                      AND GER_CODEMP = OBS_EMPDOC ');
      SQL.Add('                      AND GER_CODCLI = OBS_CODCLI ');
      SQL.Add(' LEFT JOIN RECIMG ON IMG_SEQROM = ROMGERX.AUTOINCREM ');
      SQL.Add(' LEFT JOIN FACIMG ON IMG_SEQENT = ROMGERX.GER_ENTGER ');

      SQL.Add(' WHERE TRUE ');

      If (Not fEmptyStr(edtNumRom.Text)) Then
        SQL.Add(' AND GER_NUMROM = :NUMROM ');

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        SQL.Add(' AND GER_EMPROM = :EMPROM ');

      If (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
        (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))) Then
        SQL.Add(' AND GER_DTAFAT BETWEEN :DTAINI AND :DTAFIN ');

      If (Not fEmptyStr(edtDocFat.Text)) And
        (Not fEmptyStr(edtEspFat.Text)) Then
      Begin
        SQL.Add(' AND GER_NUMDOC = :NUMDOC ');
        SQL.Add(' AND GER_ESPDOC = :ESPDOC ');
      End;

      If (Not fEmptyStr(edtEmpFat.Text)) Then
        SQL.Add(' AND GER_CODEMP = :CODEMP ');

      If (Not fEmptyStr(edtCodCli.Text)) Then
        SQL.Add(' AND GER_CODCLI = :CODCLI ');

      If (Not fEmptyStr(mskPlaVei.Text)) Then
        SQL.Add(' AND GER_PLAVEI = :PLAVEI ');

      If (Not fEmptyStr(edtCodCid.Text)) Then
        SQL.Add(' AND IF(CIDENT.CID_CODCID IS NULL, CIDCLI.CID_CODCID, CIDENT.CID_CODCID) = :CODCID ');

      If (Not fEmptyStr(edtCodVen.Text)) Then
        SQL.Add(' AND GER_CODVEN = :CODVEN ');

      If (Not fEmptyStr(edtCodMot.Text)) Then
        SQL.Add(' AND GER_CODMOT = :CODMOT ');

      If (Not fEmptyStr(edtCodReg.Text)) Then
        SQL.Add(' AND GER_CODREG = :CODREG ');

      If (Not fEmptyStr(edtCodAju.Text)) Then
        SQL.Add(' AND ((GER_CODAJ1 = :CODAJU) OR (GER_CODAJ2 = :CODAJU) OR (GER_CODAJ3 = :CODAJU) OR (GER_CODAJ4 = :CODAJU)) ');

      If (Not fEmptyStr(edtRegCli.Text)) Then
        SQL.Add(' AND CLI_CODREG = :REGCLI ');

      If (Not fEmptyStr(edtCodTra.Text)) Then
        SQL.Add(' AND GER_CODTRA = :CODTRA ');

      If chkBaixaApp.Checked Then
        SQL.Add(' AND GER_BAIAPP = "S" ');

      SQL.Add(' AND (IFNULL(GER_BAIFLG, "") = "P" ');
      SQL.Add(' OR IFNULL(GER_BAIFLG, "") = "D") ');

      SQL.Add(' HAVING FALSE ');

      if chkNaoEntregue.Checked then
      begin
        SQL.Add(' OR ENTREGA = "Não Entregue" ');
      end;

      if chkDesconsiderados.Checked then
      begin
        SQL.Add(' OR STAENT LIKE "%Desconsiderado%" ');
      end;
    End;

    pSetaParametros;

    Open;
    pSetaClient(qryDados);

    cdsDados.SetProvider(dspDados);
    cdsDados.Open;
  End;
end;

function TfrmLiberacaoAcompEntregas.fComunicarMovMe
  (pgbStatus: TcxProgressBar = Nil): Boolean;
var
  objMvMeCom: TMovMeGerar;
begin
  try
    objMvMeCom := TMovMeGerar.Create(Self);

    objMvMeCom.pComunicar(pgbStatus);

    pFreeAndNil(objMvMeCom);
    Result := True;
  Except
    pFreeAndNil(objMvMeCom);
    Result := False;
  End;
end;

function TfrmLiberacaoAcompEntregas.fMotoristaBloqueado
  (strCodMot: String): Boolean;
var
  qryRomaneiosMot: TUniQuery;
begin
  qryRomaneiosMot := fCriaQuery;

  with qryRomaneiosMot do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT GER_CODMOT FROM ROMGERX  ');
    SQL.Add(' WHERE GER_DTABAI IS NULL AND GER_LIBENT = "S" AND GER_ENVENT = "S"');
    SQL.Add(' AND GER_CODMOT = :CODMOT ');

    ParamByName('CODMOT').AsString := strCodMot;

    Open;

    Result := (RecordCount > 0);
  end;
end;

procedure TfrmLiberacaoAcompEntregas.pMarcarDesmarcar;
Var
  strNumRom: String;
  strEmpRom: String;
  strCodCli: String;
  blnMarDes: Boolean;
begin
  strNumRom := cdsDados.FieldByName('GER_NUMROM').AsString;
  strEmpRom := cdsDados.FieldByName('GER_EMPROM').AsString;
  blnMarDes := (cdsDados.FieldByName('MARDES').AsString = 'D');
  strCodCli := cdsDados.FieldByName('CLIENT').AsString;

  cdsDados.DisableControls;

  If not fMotoristaBloqueado(cdsDados.FieldByName('MOT_CODMOT').AsString) Then
  begin
    Try
      cdsDados.Filter := 'GER_NUMROM = ' + QuotedStr(strNumRom) +
        ' AND GER_EMPROM = ' + QuotedStr(strEmpRom);
      cdsDados.Filtered := True;
      cdsDados.First;

      While Not cdsDados.Eof Do
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('MARDES').AsString := IIF(blnMarDes, 'M', 'D');
        cdsDados.Post;
        cdsDados.Next;
      End;
    Finally
      cdsDados.Filtered := False;
      cdsDados.Filter := '';
      cxgDadosTableView1.DataController.DataSet.Locate('GER_NUMROM;CLIENT',
        VarArrayOf([strNumRom, strCodCli]), []);
      // cxgDadosTableView1.Controller.FocusedRowIndex := strFocusedRowIndex;
    End;
  end
  else
    fMensagem('ATENÇÃO!', 'O motorista do romaneio ' + strNumRom + '-' +
      strEmpRom + ' está em campo no momento.' + sLineBreak +
      'Aguarde seu retorno para realizar um novo envio', ['&OK']);

  cdsDados.EnableControls;
end;

procedure TfrmLiberacaoAcompEntregas.pMarcarDesmarcarTodos;
Var
  intFocusedRowIndex: Integer;
  blnMarDes: Boolean;
begin
  btnMarTod.Enabled := False;
  cdsDados.DisableControls;
  intFocusedRowIndex := cxgDadosTableView1.Controller.FocusedRowIndex;
  Try
    If (btnMarTod.Caption = '[F2] Marcar Todos Romaneios') Then
    Begin
      btnMarTod.Caption := '[F2] Desmarcar Todos Romaneios';
      blnMarDes := True;
    End
    Else
    Begin
      btnMarTod.Caption := '[F2] Marcar Todos Romaneios';
      blnMarDes := False;
    End;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('MARDES').AsString := IIF(blnMarDes, 'M', 'D');
      cdsDados.Post;
      cdsDados.Next;
    End;
  Finally
    cdsDados.EnableControls;
    cxgDadosTableView1.Controller.TopRowIndex := intFocusedRowIndex;
    btnMarTod.Enabled := True;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.pSetaParametros;
begin
  With qryDados Do
  Begin
    If (Not fEmptyStr(edtNumRom.Text)) Then
      ParamByName('NUMROM').AsString := edtNumRom.Text;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      ParamByName('EMPROM').AsString := edtCodEmp.Text;

    If (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)))) And
      (Not(fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If (Not fEmptyStr(edtDocFat.Text)) And (Not fEmptyStr(edtEspFat.Text)) Then
    Begin
      ParamByName('NUMDOC').AsString := edtDocFat.Text;
      ParamByName('ESPDOC').AsString := edtEspFat.Text;
    End;

    If (Not fEmptyStr(edtEmpFat.Text)) Then
      ParamByName('CODEMP').AsString := edtEmpFat.Text;

    If (Not fEmptyStr(edtCodCli.Text)) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If (Not fEmptyStr(mskPlaVei.Text)) Then
      ParamByName('PLAVEI').AsString := mskPlaVei.Text;

    If (Not fEmptyStr(edtCodCid.Text)) Then
      ParamByName('CODCID').AsString := edtCodCid.Text;

    If (Not fEmptyStr(edtCodVen.Text)) Then
      ParamByName('CODVEN').AsString := edtCodVen.Text;

    If (Not fEmptyStr(edtCodMot.Text)) Then
      ParamByName('CODMOT').AsString := edtCodMot.Text;

    If (Not fEmptyStr(edtCodReg.Text)) Then
      ParamByName('CODREG').AsString := edtCodReg.Text;

    If (Not fEmptyStr(edtCodAju.Text)) Then
      ParamByName('CODAJU').AsString := edtCodAju.Text;

    If (Not fEmptyStr(edtRegCli.Text)) Then
      ParamByName('REGCLI').AsString := edtRegCli.Text;

    If (Not fEmptyStr(edtCodIte.Text)) Then
      ParamByName('CODITE').AsString := edtCodIte.Text;

    If (Not fEmptyStr(edtCodTra.Text)) Then
      ParamByName('CODTRA').AsString := edtCodTra.Text;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.pSintetizarRomaneiosMarcados;
begin
  cdsRoma.EmptyDataSet;
  cdsDados.Filter := 'MARDES = ' + QuotedStr('M');
  cdsDados.Filtered := True;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If Not cdsRoma.FindKey([cdsDados.FieldByName('GER_NUMROM').AsString,
        cdsDados.FieldByName('GER_EMPROM').AsString]) Then
      Begin
        cdsRoma.Append;
        cdsRoma.FieldByName('GER_NUMROM').AsString :=
          cdsDados.FieldByName('GER_NUMROM').AsString;
        cdsRoma.FieldByName('GER_EMPROM').AsString :=
          cdsDados.FieldByName('GER_EMPROM').AsString;
        cdsRoma.Post;
      End;
      cdsDados.Next;
    End;
  Finally
    cdsDados.Filter := '';
    cdsDados.Filtered := False;
  End;
end;

procedure TfrmLiberacaoAcompEntregas.rdgCtrEntClick(Sender: TObject);
begin
  btnLibEnt.Enabled := (rdgCtrEnt.ItemIndex = 1) And (bnDirLibEnt);

  chkBaixaApp.Enabled := (rdgCtrEnt.ItemIndex = 3);
  gbxTipoBaixa.Enabled := (rdgCtrEnt.ItemIndex = 3);
  chkEntregue.Enabled := (rdgCtrEnt.ItemIndex = 3);
  chkEntregueParc.Enabled := (rdgCtrEnt.ItemIndex = 3);
  chkNaoEntregue.Enabled := (rdgCtrEnt.ItemIndex = 3);
  chkDesconsiderados.Enabled := (rdgCtrEnt.ItemIndex = 3);
  chkReagendados.Enabled := (rdgCtrEnt.ItemIndex = 1);

  if not chkBaixaApp.Enabled then
    chkBaixaApp.Checked := False;

  if not chkReagendados.Enabled then
    chkReagendados.Checked := False;
end;

end.
