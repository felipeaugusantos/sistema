unit untImpEtiOrdPro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, UniClientDataSet,
  cxLookAndFeelPainters, cxStyles, cxProgressBar, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untZClient, Vcl.Mask,
  MaskEditFocus, EditFocus, strUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmImpEtiOrdPro = class(TfrmPai)
    cxgMovProLevel1: TcxGridLevel;
    cxgMovProTableView: TcxGridDBTableViewCitel;
    cxgMovPro: TcxGridCitel;
    Panel1: TPanel;
    lblProduto: TLabel;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    rdgTipDta: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    edtOrdPro: TEditFocus;
    cxGridCitelColumnCODPRO: TcxGridDBColumn;
    cxGridCitelColumnCODITE: TcxGridDBColumn;
    cxGridCitelColumnDESITE: TcxGridDBColumn;
    cxGridCitelColumnREFERE: TcxGridDBColumn;
    cxGridCitelColumnNOMCLI: TcxGridDBColumn;
    cxGridCitelColumnNUMDOC: TcxGridDBColumn;
    cxGridCitelColumnESPDOC: TcxGridDBColumn;
    cxGridCitelColumnSIGUNI: TcxGridDBColumn;
    cxGridCitelColumnDTACAD: TcxGridDBColumn;
    cxGridCitelColumnDTAPRO: TcxGridDBColumn;
    cxGridCitelColumnDTABAI: TcxGridDBColumn;
    cxGridCitelColumnQTDAPR: TcxGridDBColumn;
    cxGridCitelColumnQTDETI: TcxGridDBColumn;
    btnLazer: TBitBtnLocked;
    cxGridCitelColumnQTDPRO: TcxGridDBColumn;
    lblSerie: TLabel;
    edtSerie: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnLazerClick(Sender: TObject);
  private
    cdsMovPro : TZClient;
    cdsRegistros : TUniClientDataSet;
    arrLayouts : array of string;
    function fGetSQL : String;
    procedure pAbreDados;
    function fGeraRegistros(cxProgress : TcxProgressBar):Boolean;
  public
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;Override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, TypesRel, untGravando,
  untFuncoesEtiquetas, untConfiguraEtiquetas, untConfiguraEtiquetasFuncoes;

{ TfrmImpEtiOrdPro }

procedure TfrmImpEtiOrdPro.btnLazerClick(Sender: TObject);
  Var
    prmDllEtq: TParamDllEtiquetas;
    i : Integer;
    strTipEti : String;
begin
  Try
    cdsMovPro.CheckBrowseMode;
    cdsMovPro.DisableControls;
    prmDllEtq := TParamDllEtiquetas.Create;
    cdsRegistros := fCriaClientDatset(cdsMovPro, True, Self);

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGeraRegistros;
    frmGravando.lblGravando.Caption := 'Gerando registros...';
    frmGravando.ShowModal;

    If cdsRegistros.IsEmpty Then
    Begin
      fMensagem('','Marque a quantidade de etiquetas para imprimir!', ['&Ok']);
      Exit;
    End;

    prmDllEtq.tpeTipEtq := tpeOrdemProducaoArgox;

    strTipEti := fGetTipoImpressaoEtiquetas('ETIORD');
    If fEmptyStr(strTipEti) then
      strTipEti := 'A';

    Case strTipEti[1] of
      'L': prmDllEtq.tpeTipEtq := tpeOrdemProducao;
      'A': prmDllEtq.tpeTipEtq := tpeOrdemProducaoArgox;
      'Z': prmDllEtq.tpeTipEtq := tpeOrdemProducaoZebra;
    end;

    prmDllEtq.dtsImpres := cdsRegistros;

    for i := 0 to High(arrLayouts) do
    begin
      cdsRegistros.Filtered := False;
      cdsRegistros.Filter   := 'LAYORD = ' + QuotedStr(arrLayouts[i]);
      cdsRegistros.Filtered := True;

      prmDllEtq.strLayDoc := arrLayouts[i];

      fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');
    end;

  Finally
    cdsMovPro.EnableControls;
    FreeAndNil(frmGravando);
    FreeAndNil(prmDllEtq);
    FreeAndNil(cdsRegistros);
  End;

end;

procedure TfrmImpEtiOrdPro.edtOrdProKeyPress(Sender: TObject; var Key: Char);
  Var
    strSQL: String;
    arrSel: TConsultasArray;
begin
  inherited;
  strSQL := 'WHERE PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  If fPesqOrdemProd(conSimples, Self, edtOrdPro, nil, nil, Key, arrSel, strSQL) then
  Begin
    If fValidaCampos(edtOrdPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmImpEtiOrdPro.fGetSQL: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT PRO_CODITE AS CODITE,                       ';
  strSQL := strSQL + '        ITE_DESITE AS DESITE,                       ';
  strSQL := strSQL + '        ITE_REFERE AS REFERE,                       ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOMCLI,                       ';
  strSQL := strSQL + '        PRO_NUMDOC AS NUMDOC,                       ';
  strSQL := strSQL + '        PRO_ESPDOC AS ESPDOC,                       ';
  strSQL := strSQL + '        MAR_DESMAR AS DESMAR,                       ';
  strSQL := strSQL + '        UNI_SIGUNI AS SIGUNI,                       ';
  strSQL := strSQL + '        ITE_EMBALA AS EMBALA,                       ';
  strSQL := strSQL + '        PRO_CODPRO AS CODPRO,                       ';
  strSQL := strSQL + '        ITE_LOCFIS AS LOCFIS,                       ';
  strSQL := strSQL + '        PRO_OBS001 AS OBS001,                       ';
  strSQL := strSQL + '        PRO_OBS002 AS OBS002,                       ';
  strSQL := strSQL + '        PRO_DTACAD AS DTACAD,                       ';
  strSQL := strSQL + '        PRO_DTAPRO AS DTAPRO,                       ';
  strSQL := strSQL + '        PRO_DTABAI AS DTABAI,                       ';
  strSQL := strSQL + '        PRO_QTDAPR AS QTDAPR,                       ';
  strSQL := strSQL + '        PRO_QTDPRO AS QTDPRO,                       ';
  strSQL := strSQL + '        ITE_PESOIT * PRO_QTDPRO AS PESBRU,          ';
  strSQL := strSQL + '        ITE_PESLIQ * PRO_QTDPRO AS PESLIQ,          ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR,                       ';
  strSQL := strSQL + '        PRO_CODEMP AS CODEMP,                       ';
  strSQL := strSQL + '        PRO_CONFER AS CONFER,                       ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR,                       ';

  strSQL := strSQL + '        00000      AS QTDETI,                       ';

  strSQL := strSQL + '        IF(IFNULL(PRO_NUMDOC,"") <> ""              ';
  strSQL := strSQL + '           , CONCAT(PRO_NUMDOC, "-",                ';
  strSQL := strSQL + '                    PRO_ESPDOC, "-",                ';
  strSQL := strSQL + '                    PRO_CODEMP)                     ';
  strSQL := strSQL + '           , "")   AS NUMPED,                       ';

  strSQL := strSQL + ' CAST("" AS CHAR(100))   AS SEQDET,                 ';

  strSQL := strSQL + '        IFNULL(ITE_LAYORD, "") AS LAYORD,           ';


  strSQL := strSQL + ' IF( '; //INDICA SE NO PEDIDO TEM SOMENTE ESTRUTURA.
  strSQL := strSQL + ' (SELECT COUNT(0) FROM FATDOR D2 WHERE D2.FDO_SEQGER = IFNULL(F1.AUTOINCREM, F2.AUTOINCREM)) = '; //QTDE DE ITENS NO PEDIDO
  strSQL := strSQL + ' (SELECT COUNT(0) FROM FATDOR D3 INNER JOIN GERMAT ON GMT_CODITE = FDO_CODITE WHERE D3.FDO_SEQGER = IFNULL(F1.AUTOINCREM, F2.AUTOINCREM)), '; //QTDE DE ITENS NO PEDIDO QUE É ESTRUTURA
  strSQL := strSQL + ' "S", "N") AS PEDEST, ';

  strSQL := strSQL + '        PRO_NUMLOT AS NUMLOT,                       ';
  strSQL := strSQL + '        LOT_DTAFAB AS DTAFAB,                       ';
  strSQL := strSQL + '        LOT_DTAVAL AS DTAVAL,                       ';
  strSQL := strSQL + '        DP.DOP_QTDITE AS QTDUTI,                    ';
  strSQL := strSQL + '  I.ITE_VALIDA AS VALIDA,                           ';
  strSQL := strSQL + '  I.ITE_ITESAC AS ITESAC,                           ';
  strSQL := strSQL + '  I.ITE_COMPOS AS COMPOS,                           ';
  strSQL := strSQL + '  I.ITE_PAISOR AS PAISOR                            ';

  strSQL := strSQL + ' FROM MOVPRO V                                      ';
  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = V.PRO_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN DETPRO DP ON DP.DOP_SEQGER = V.AUTOINCREM     ';
  strSQL := strSQL + ' LEFT  JOIN CADCLI C ON C.CLI_CODCLI = V.PRO_CODCLI ';
  strSQL := strSQL + ' LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  strSQL := strSQL + ' LEFT  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = V.PRO_CODITE ';
  strSQL := strSQL + '                    AND G.ITE_CODEMP = V.PRO_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FATDOR D1   ON FDO_ORDPRO = PRO_CODPRO AND FDO_EMPITE = PRO_CODEMP         ';
  strSQL := strSQL + '   LEFT JOIN FATGOR F1 ON F1.AUTOINCREM = FDO_SEQGER                                  ';
  strSQL := strSQL + '   LEFT JOIN FATGOR F2 ON (F2.FGO_NUMDOC = PRO_NUMPED AND F2.FGO_ESPDOC = PRO_ESPPED AND F2.FGO_CODEMP = PRO_EMPPED) ';
  strSQL := strSQL + '   LEFT JOIN CADLOT L ON (L.LOT_CODITE = V.PRO_CODITE AND L.LOT_CODEMP = V.PRO_CODEMP AND L.LOT_NUMLOT = V.PRO_NUMLOT)';

  strSQL := strSQL + ' WHERE TRUE                                         ';

  If not fEmptyStr(edtOrdPro.Text) Then
  Begin
    strSQL := strSQL + ' AND PRO_CODPRO = :CODPRO ';
  End
  Else
  Begin
    If Not fEmptyDate(mskDtaIni.Text) Then
    Begin
      Case rdgTipDta.ItemIndex Of
        0: strSQL := strSQL + ' AND PRO_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
        1: strSQL := strSQL + ' AND PRO_DTAPRO BETWEEN :DTAINI AND :DTAFIN ';
        2: strSQL := strSQL + ' AND PRO_DTABAI BETWEEN :DTAINI AND :DTAFIN ';
      End;
    End;

    If Not fEmptyStr(edtCodPro.Text) Then
      strSQL := strSQL + ' AND PRO_CODITE = :CODITE ';

    If Not fEmptyStr(edtNumDoc.Text) Then
      strSQL := strSQL + ' AND PRO_NUMDOC = :NUMDOC ';

    If Not fEmptyStr(edtEspDoc.Text) Then
      strSQL := strSQL + ' AND PRO_ESPDOC = :ESPDOC ';

    If Not fEmptyStr(edtSerie.Text) Then
      strSQL := strSQL + ' AND PRO_SERIE_ = :SERIE_ ';

  End;

  strSQL := strSQL + ' ORDER BY    ';
  strSQL := strSQL + '   LAYORD ';

  Result := strSQL;
end;

procedure TfrmImpEtiOrdPro.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodPro);
  cdsMovPro := TZClient.Create(Self);
end;

procedure TfrmImpEtiOrdPro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsMovPro);
  inherited;
end;

procedure TfrmImpEtiOrdPro.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtOrdPro);
end;

function TfrmImpEtiOrdPro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtOrdPro) Then
    Begin
      mskDtaIni.Enabled := fEmptyStr(edtOrdPro.Text);
      mskDtaFin.Enabled := fEmptyStr(edtOrdPro.Text);
      rdgTipDta.Enabled := fEmptyStr(edtOrdPro.Text);
      edtCodPro.Enabled := fEmptyStr(edtOrdPro.Text);
      edtNumDoc.Enabled := fEmptyStr(edtOrdPro.Text);
      edtEspDoc.Enabled := fEmptyStr(edtOrdPro.Text);
      edtSerie.Enabled  := fEmptyStr(edtOrdPro.Text);

      If not fEmptyStr(edtOrdPro.Text) Then
        pAbreDados;
    End

    Else
    If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := Not fEmptyDate(mskDtaIni.Text);
      If mskDtaFin.Enabled Then
        mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));

    End

    Else
    If (Sender = mskDtaFin) And mskDtaFin.Enabled Then
    Begin
      If fEmptyDate(mskDtaFin.Text) Then
      Begin
        Result := False;
        pMensagemOK('Informe a data final!');
      End

      Else
      If (StrToDate(mskDtaFin.Text) < StrToDate(mskDtaIni.Text)) Then
      Begin
        Result := False;
        pMensagemOK('A data final deve ser maior ou igual a inicial!');
      End;


    End

    Else
    If (Sender = edtCodPro) Then
    Begin
      If fEmptyStr(edtCodPro.Text) Then
        edtDesPro.Clear
      Else
      Begin
        edtDesPro.Text := fRetNomProduto(edtCodPro.Text);
        If fEmptyStr(edtDesPro.Text) Then
        Begin
          Result := False;
          pMensagemOK('Digite um código válido!');
        End;
      End;

    End

    Else
    If (Sender = edtSerie) Then
    Begin
      pAbreDados;
    End;

  End;

end;

procedure TfrmImpEtiOrdPro.pAbreDados;
Begin
  With cdsMovPro.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add ( fGetSQL );

    If not fEmptyStr(edtOrdPro.Text) Then
    Begin
      ParamByName('CODPRO').AsString := edtOrdPro.Text;
    End
    Else
    Begin
      If Not fEmptyDate(mskDtaIni.Text) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(edtCodPro.Text) Then
        ParamByName('CODITE').AsString := edtCodPro.Text;

      If Not fEmptyStr(edtNumDoc.Text) Then
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;

      If Not fEmptyStr(edtEspDoc.Text) Then
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;

      If Not fEmptyStr(edtSerie.Text) Then
        ParamByName('SERIE_').AsString := edtSerie.Text;

    End;

    cxgMovProTableView.DataController.DataSource := cdsMovPro.dtsSource;
    cdsMovPro.fAbreClient(True, 'TfrmImpEtiOrdPro.pAbreDados');

    cxgMovProTableView.ApplyBestFit;

    pSetFocus(cxgMovPro);

  End;

End;

function TfrmImpEtiOrdPro.fGeraRegistros(cxProgress : TcxProgressBar):Boolean;
  Var
    intRegis : Integer;
begin
  Result := True;

  intRegis := 0;
  cdsMovPro.First;
  While not cdsMovPro.Eof Do
  Begin
    intRegis := intRegis + cdsMovPro.FieldByName('QTDETI').AsInteger;
    cdsMovPro.Next;
  End;

  cxProgress.Properties.Max := intRegis;

  SetLength(arrLayouts,0);

  cdsMovPro.First;
  While not cdsMovPro.Eof Do
  Begin
    //adiciona o layout no array para fazer a impressão por layout
    if cdsMovPro.FieldByName('QTDETI').AsInteger > 0 then
    begin
      if AnsiIndexStr(cdsMovPro.FieldByName('LAYORD').AsString, arrLayouts) < 0 then
      begin
        SetLength(arrLayouts, Length(arrLayouts) + 1);
        arrLayouts[High(arrLayouts)] := cdsMovPro.FieldByName('LAYORD').AsString;
      end;
    end;

    For intRegis := 1 to cdsMovPro.FieldByName('QTDETI').AsInteger Do
    Begin
      cdsRegistros.Append;
      cdsRegistros.FieldByName('CODITE').Value := cdsMovPro.FieldByName('CODITE').Value;
      cdsRegistros.FieldByName('DESITE').Value := cdsMovPro.FieldByName('DESITE').Value;
      cdsRegistros.FieldByName('REFERE').Value := cdsMovPro.FieldByName('REFERE').Value;
      cdsRegistros.FieldByName('NOMCLI').Value := cdsMovPro.FieldByName('NOMCLI').Value;
      cdsRegistros.FieldByName('NUMDOC').Value := cdsMovPro.FieldByName('NUMDOC').Value;
      cdsRegistros.FieldByName('ESPDOC').Value := cdsMovPro.FieldByName('ESPDOC').Value;
      cdsRegistros.FieldByName('DESMAR').Value := cdsMovPro.FieldByName('DESMAR').Value;
      cdsRegistros.FieldByName('SIGUNI').Value := cdsMovPro.FieldByName('SIGUNI').Value;
      cdsRegistros.FieldByName('EMBALA').Value := cdsMovPro.FieldByName('EMBALA').Value;
      cdsRegistros.FieldByName('CODPRO').Value := cdsMovPro.FieldByName('CODPRO').Value;
      cdsRegistros.FieldByName('LOCFIS').Value := cdsMovPro.FieldByName('LOCFIS').Value;
      cdsRegistros.FieldByName('OBS001').Value := cdsMovPro.FieldByName('OBS001').Value;
      cdsRegistros.FieldByName('OBS002').Value := cdsMovPro.FieldByName('OBS002').Value;

      cdsRegistros.FieldByName('NUMLOT').Value := cdsMovPro.FieldByName('NUMLOT').Value;
      cdsRegistros.FieldByName('DTAFAB').Value := cdsMovPro.FieldByName('DTAFAB').Value;
      cdsRegistros.FieldByName('DTAVAL').Value := cdsMovPro.FieldByName('DTAVAL').Value;
      cdsRegistros.FieldByName('QTDUTI').Value := cdsMovPro.FieldByName('QTDUTI').Value;

      cdsRegistros.FieldByName('DTACAD').Value := cdsMovPro.FieldByName('DTACAD').Value;
      cdsRegistros.FieldByName('DTAPRO').Value := cdsMovPro.FieldByName('DTAPRO').Value;
      cdsRegistros.FieldByName('DTABAI').Value := cdsMovPro.FieldByName('DTABAI').Value;
      cdsRegistros.FieldByName('QTDAPR').Value := cdsMovPro.FieldByName('QTDAPR').Value;
      cdsRegistros.FieldByName('QTDPRO').Value := cdsMovPro.FieldByName('QTDPRO').Value;
      cdsRegistros.FieldByName('CONFER').Value := cdsMovPro.FieldByName('CONFER').Value;
      cdsRegistros.FieldByName('LAYORD').Value := cdsMovPro.FieldByName('LAYORD').Value;
      cdsRegistros.FieldByName('SEQDET').Value := IntToStr(intRegis)+'/'+IntToStr(cdsMovPro.FieldByName('QTDETI').AsInteger);

      cdsRegistros.Post;

      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
    cdsMovPro.Next;
  End;

End;

end.
