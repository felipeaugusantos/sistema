unit untGarantiaGeraCreditos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, untTypesSistema,
  BitBtnLockedIncrem, ExtCtrls, Grids, DBGrids, EditFocus, untZClient,
  untFuncoesSimples, untFuncoesConsulta, DB, ImgList, Uni, StrUtils,
  System.ImageList, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxImageComboBox,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmGarantiaGeraCreditos = class(TfrmPaiConfirma)
    pnlCliente: TPanel;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    imgLista: TImageList;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnInverter: TBitBtnLocked;
    cxgDadosLevel: TcxGridLevel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    cxgDadosMARDES: TcxGridDBColumn;
    cxgDadosCODCLI: TcxGridDBColumn;
    cxgDadosNOMCLI: TcxGridDBColumn;
    cxgDadosNUMDOC: TcxGridDBColumn;
    cxgDadosESPDOC: TcxGridDBColumn;
    cxgDadosCODITE: TcxGridDBColumn;
    cxgDadosDESITE: TcxGridDBColumn;
    cxgDadosVALITE: TcxGridDBColumn;
    cxgDadosDOCENT: TcxGridDBColumn;
    cxgDadosESPENT: TcxGridDBColumn;
    Label1: TLabel;
    edtCodFav: TEditFocus;
    edtNomFav: TEditFocus;
    cxgDadosCODFAV: TcxGridDBColumn;
    cxgDadosNOMFAV: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgDadosTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edtCodFavExit(Sender: TObject);
    procedure edtCodFavKeyPress(Sender: TObject; var Key: Char);
  private
    FblnInfCli: Boolean;
    qryDados  : TZClient;
    arrCodCli : TConsultasArray;
    arrCodFav : TConsultasArray;
    strCodCli,
    strCodFav : String;
    strPorGar : String;
    intCorZeb : Integer;

    function fGravaCreditoCliente(strNumDup, strEspDup, strCodCli, strCodVen, strCodDig, strPortad: String; fltValDup: Double; strAutIncGer, strHistor: String; Out strSeqRec: String): Boolean;
    function fGetSql : String;
    procedure pAbrirDataSet;
    procedure pMarcar(intOpcao : Integer);
    procedure pConfirma;
    function fGravarNumDUPNaMovGag(const strAutInc, strNumDUP: String): Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean): Boolean; override;

  end;


implementation

uses untConsultas, untCadRec, untGarant, untTCRMGarantia;

{$R *.dfm}

procedure TfrmGarantiaGeraCreditos.btnConfirmaClick(Sender: TObject);
begin
  If (not qryDados.Active) Or (qryDados.RecordCount <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Não Existe dados para Confirmar!', ['OK']);
  End
  Else
  Begin
    inherited;
    ModalResult := mrOk;
  End;

end;

procedure TfrmGarantiaGeraCreditos.btnMarcarClick(Sender: TObject);
begin
  inherited;
  if TBitBtnLocked(Sender).Tag = 2 Then
  Begin
    qryDados.DisableControls;
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      pMarcar( TBitBtnLocked(Sender).Tag );
      qryDados.Next;
    End;
    qryDados.First;
    qryDados.EnableControls;
  End
  Else
    pMarcar( TBitBtnLocked(Sender).Tag );
end;

procedure TfrmGarantiaGeraCreditos.cxgDadosTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (AButton = mbLeft) And (ACellViewInfo.Item.Index = cxgDadosMARDES.Index) Then
    pMarcar(2);
end;

procedure TfrmGarantiaGeraCreditos.dbgDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key in [VK_RETURN, VK_SPACE] Then
    pMarcar(2);
end;

procedure TfrmGarantiaGeraCreditos.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCodCli, nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmGarantiaGeraCreditos.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCodCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmGarantiaGeraCreditos.edtCodFavExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFav, edtNomFav, arrCodFav, nil, fRetNomCliente, 'do Favorecido');
end;

procedure TfrmGarantiaGeraCreditos.edtCodFavKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodFav, edtNomFav, Nil, Key, arrCodFav, False) Then
  Begin
    If fValidaCampos(edtCodFav, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmGarantiaGeraCreditos.fGetSql: String;
begin

  Result := '';
  Result := Result + ' SELECT GAD_SEQGAG, ';
  Result := Result + '        GAG_CODCLI AS CODCLI,                          ';
  Result := Result + '        A.CLI_NOMCLI AS NOMCLI,                        ';
  Result := Result + '        GAD_NUMDOC AS NUMDOC,                          ';
  Result := Result + '        GAD_ESPDOC AS ESPDOC,                          ';
  Result := Result + '        GAD_CODITE AS CODITE,                          ';
  Result := Result + '        ITE_DESITE AS DESITE,                          ';
  Result := Result + '        (IF(IFNULL(GAD_UNICRD,0) = 0,                 ';
  Result := Result + '             (GAD_VALITE/GAD_QTDREQ), GAD_UNICRD)      ';
  Result := Result + '              * ( GAD_QTDREQ - IFNULL(GAD_QTDDEV,0))) AS VALITE,';
  Result := Result + '        MOVGAD.AUTOINCREM AS AUTINC,                   ';
  Result := Result + '        D1.DET_NUMDOC AS DOCENT,                          ';
  Result := Result + '        D1.DET_ESPDOC AS ESPENT,                          ';
  Result := Result + '        GAG_CODFAV AS CODFAV,                          ';
  Result := Result + '        B.CLI_NOMCLI AS NOMFAV,                        ';
  Result := Result + '        "0" AS MARDES,                                 ';
  Result := Result + '        D1.DET_SEQGER AS "INCGER",                     ';
  Result := Result + '        MOVGAG.AUTOINCREM AS "INCGAG",                 ';
  Result := Result + '        MOVGAG.GAG_NUMCCR,                             ';
  Result := Result + '        MOVGAG.GAG_NUMENT,                             ';
  Result := Result + '        (GAD_QTDREQ - IFNULL(GAD_QTDDEV,0)) AS QTDITE  ';
  Result := Result + ' FROM MOVGAD                                           ';
  Result := Result + '   INNER JOIN MOVGAG ON MOVGAG.AUTOINCREM = GAD_SEQGAG ';
  Result := Result + '   INNER JOIN CADCLI A ON A.CLI_CODCLI = GAG_CODCLI        ';
  Result := Result + '   INNER JOIN CADCLI B ON B.CLI_CODCLI = GAG_CODFAV    ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = GAD_CODITE        ';
  Result := Result + '   LEFT JOIN MOVGRC G1 ON G1.GRC_SEQGAD = MOVGAD.AUTOINCREM ';
  Result := Result + '   LEFT JOIN MOVDET D1 ON D1.AUTOINCREM = G1.GRC_SEQDET ';
  Result := Result + ' WHERE GAD_SCREDI = 1                                   ';
  Result := Result + '   AND GAG_CODEMP = :CODEMP                             ';
  Result := Result + '   AND GRC_OPCDOC IN ("GA", "NE", "DV", "OE")           ';
  Result := Result + '   AND ( GAD_QTDREQ - IFNULL(GAD_QTDDEV,0)) > 0         ';
  Result := Result + fStrLocate(edtCodCli, arrCodCli, 'GAG_CODCLI', 'CODCLI');
  If Not fEmptyStr(edtCodFav.text) Then
    Result := Result + fStrLocate(edtCodFav, arrCodFav, 'GAG_CODFAV', 'CODFAV');

  Result := Result + ' ORDER BY GAG_CODCLI, GAD_SEQGAG, GAD_NUMDOC, GAD_ESPDOC, GAD_CODITE ';
end;

procedure TfrmGarantiaGeraCreditos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (ModalResult <> MrOK) And qryDados.Active And (qryDados.RecordCount > 0) Then
  Begin
    if fMensagem('ATENÇÃO', 'Deseja Abandonar a Operação?', ['&Sim', '&Não']) = 1 Then
    Begin
      qryDados.EmptyDataSet;
      qryDados.Close;
    End;

    Action := caNone;
  End;

  If (ModalResult = MrOK) And qryDados.Active And (qryDados.RecordCount > 0) Then
  Begin
    pConfirma;
    Action := caNone;
  End;


end;

procedure TfrmGarantiaGeraCreditos.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := TZClient.Create(Self);
  cxgDadosTableView.DataController.DataSource := qryDados.dtsSource;
  intCorZeb := fCfgSis('CORZEB', varInteger);
  strPorGar := fCfgSis('PORGAR', varString);
  FblnInfCli := fCfgSis('INFCLI', VarString) = 'S';
end;

procedure TfrmGarantiaGeraCreditos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryDados);
end;

procedure TfrmGarantiaGeraCreditos.FormShow(Sender: TObject);
begin
  inherited;

  If Not FblnInfCli Then
  Begin
   Label1.Visible := False;
   edtCodFav.Visible := False;
   edtNomFav.Visible := False;

   cxgDadosCODFAV.Visible := False;
   cxgDadosNOMFAV.Visible := False;

   pnlCliente.Height := 35;
   Width := 806;
  End;

  pSetFocus(edtCodCli);
end;

function TfrmGarantiaGeraCreditos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    if (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli, arrCodCli, '');
      Result := (not edtCodFav.Visible);
      If edtCodFav.Visible Then
        pSetFocus(edtCodFav);
    End;

    If (Sender = edtCodFav) And (edtCodFav.Visible)  Then
    Begin
      pDesmarcaLista(edtCodFav, arrCodFav, '');
    End;

    if Result and blnBuscaPorChave Then
      pAbrirDataSet;

  End;


end;

procedure TfrmGarantiaGeraCreditos.pAbrirDataSet;
begin
  qryDados.Close;
  qryDados.qryQuery.Close;
  With qryDados.qryQuery, SQL Do
  Begin
    Clear;
    Add(fGetSql);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    pSetaParam(edtCodCli.Text, arrCodCli, strCodCli, 'CODCLI', qryDados.qryQuery);
    If Not fEmptyStr(edtCodFav.text) Then
      pSetaParam(edtCodFav.Text, arrCodCli, strCodFav, 'CODFAV', qryDados.qryQuery);
    qryDados.IndexFieldNames := 'GAD_SEQGAG';
  End;

  qryDados.fAbreClient(True, 'TfrmGarantiaGeraCreditos.pAbrirDataSet');
  TFloatField(qryDados.FieldByName('VALITE')).DisplayFormat := '#,##0.00';

  IF qryDados.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi encontrado nenhum registro!', ['OK']);
    pSetFocus(edtCodCli);
  End;

end;

procedure TfrmGarantiaGeraCreditos.pConfirma;
  Var
    qryUpdate : TUniQuery;
    strCodCliente : String;
    strNumDUP: String;
    blnAtualizarNumDupMovGag: boolean;
    strHist,
    lstrIncCTR: String;
    fltTotCre: Double;

    strEspEnt,
    strIncGag,
    strIncDoc: String;
    arrIncGad: Array of String;
    dtaDtaHra: TDateTime;

    blnResult: Boolean;

    stlProcessar: TStrings;
    lCRMGarantia: TCRMGarantia;
    lrecDadosGarantiaCRM: TDadosGarantiaCRM;
begin
  If (fMensagem('ATENÇÃO', 'Deseja Confirmar a Operação?' , ['&Sim', '&Não']) = 2) then
    Exit;

  blnResult := False;
  fStartTransaction;
  stlProcessar := TStringList.Create;
  stlProcessar.Clear;
  lCRMGarantia := TCRMGarantia.Create;
  Try
    stlProcessar.Clear;
    strCodCliente := '';
    qryUpdate := fCriaQuery(Self);
    With qryUpdate, SQL Do
    Begin
      Add( ' UPDATE MOVGAD SET GAD_SCREDI = 2,       ' );
      Add( '                   GAD_DTACRE = :DTACRE, ' );
      Add( '                   GAD_HRACRE = :HRACRE, ' );
      Add( '                   GAD_OPECRE = :OPECRE,  ' );
      Add( '                   GAD_INCCTR = :INCCTR  ' );
      Add( ' WHERE AUTOINCREM = :AUTINC              ' );
    End;
    qryDados.Data := qryDados.Data;


    qryDados.DisableControls;
    qryDados.Filter := 'MARDES = 1';
    qryDados.Filtered := True;

    If qryDados.IsEmpty Then
    Begin
      fMensagem('','Selecione pelo menos um registro para realizar o crédito para o cliente!', ['&OK']);
      Exit;
    End;

    qryDados.First;
    //Selecionando autoincrem (MOVGAG) da garantidas selecionandas para processamento agrupado
    While Not qryDados.Eof do
    begin
      if stlProcessar.IndexOf(qryDados.FieldByName('INCGAG').AsString) = -1 Then
        stlProcessar.Add(qryDados.FieldByName('INCGAG').AsString);

      qryDados.Next;
    end;

    blnResult := True;
    Try
      for strIncGag in stlProcessar do
      Begin
        Try
          //filtrando todas os registros marcados da mesma garantia para somar.
          qryDados.Filtered := False;
          qryDados.Filter := 'MARDES = 1 AND INCGAG = '+ QuotedStr(strIncGag);
          qryDados.Filtered := True;

          if qryDados.IsEmpty Then
            Continue;

          qryDados.First;

          dtaDtaHra := fNow;
          fltTotCre := 0;

          SetLength(arrIncGad,0);

          strEspEnt := qryDados.FieldByName('ESPENT').AsString;

          strIncDoc := qryDados.FieldByName('INCGER').AsString;

          blnAtualizarNumDupMovGag := fEmptyStr(qryDados.FieldByName('GAG_NUMCCR').AsString);
          if blnAtualizarNumDupMovGag then
              strNumDup := qryDados.FieldByName('DOCENT').AsString
          else
              strNumDup := qryDados.FieldByName('GAG_NUMCCR').AsString;

          strCodCliente := qryDados.FieldByName('CODCLI').AsString;

          If FblnInfCli And
               (Not fEmptyStr(qryDados.FieldByName('CODFAV').AsString)) And (fClienteConsumidor(fRetNomCliente(strCodCliente)))  Then
             strCodCliente := qryDados.FieldByName('CODFAV').AsString;
          //selecionando autoincrem (movgad) que serão processadas
          Repeat
            fltTotCre := fltTotCre + qryDados.FieldByName('VALITE').AsFloat;
            SetLength(arrIncGad,length(arrIncGad) + 1);
            arrIncGad[High(arrIncGad)] := qryDados.FieldByName('AUTINC').AsString;

            if VS_strHabilitarCRM then
            begin
              lrecDadosGarantiaCRM.strCodAde := '';
              lrecDadosGarantiaCRM.strDescri := '';
              lrecDadosGarantiaCRM.strNumEnt := qryDados.FieldByName('DOCENT').AsString;
              lrecDadosGarantiaCRM.strEspDoc := qryDados.FieldByName('ESPENT').AsString;
              lrecDadosGarantiaCRM.strCodCli := qryDados.FieldByName('CODCLI').AsString;
              lrecDadosGarantiaCRM.strNomCli := qryDados.FieldByName('NOMCLI').AsString;
              lrecDadosGarantiaCRM.strCodEmp := VS_strCodEmp;
              lrecDadosGarantiaCRM.strNomFrm := 'TfrmGarantiaGeraCreditos';
              lrecDadosGarantiaCRM.blnGeraCreditoNoRecebimento := False;
              lCRMGarantia.recDadosGarantia := lrecDadosGarantiaCRM;
              lCRMGarantia.pIncluirHistoricoLiberacaoCreditoItem(
                qryDados.FieldByName('CODITE').AsString,
                qryDados.FieldByName('DESITE').AsString,
                qryDados.FieldByName('QTDITE').AsFloat);
            end;
            qryDados.Next;

          Until (qryDados.Eof);

          strHist := fGerarHistoricoCredito(arrIncGad);

          blnResult :=
            blnResult and
              fGravaCreditoCliente(strNumDup,
                                   strEspEnt,
                                   strCodCliente,
                                   strLoginUsuarioLogado,
                                   strLoginUsuarioLogado,
                                   strPorGar,
                                   fltTotCre,
                                   strIncDoc,
                                   strHist,
                                   lstrIncCTR);

          if blnResult then
          begin
            //Atualizando (BAIXA) registros MOVGAD
            QryDados.First;
            While Not QryDados.Eof do
            begin
              qryUpdate.ParamByName('AUTINC').AsString   := qryDados.FieldByName('AUTINC').AsString;
              qryUpdate.ParamByName('OPECRE').AsString   := strLoginUsuarioLogado;
              qryUpdate.ParamByName('DTACRE').AsDateTime := VS_Date;
              qryUpdate.ParamByName('HRACRE').AsDateTime := dtaDtaHra;
              qryUpdate.ParamByName('INCCTR').AsString   := lstrIncCTR;
              qryUpdate.ExecSql;
              QryDados.Next;
            end;
          end;

          if blnResult and blnAtualizarNumDupMovGag then
            blnResult := fGravarNumDUPNaMovGag(strIncGag, strNumDup);
        Finally
          qryDados.Filtered := False;
          qryDados.Filter := '';
        End;

        if Not blnResult then
          Break;
      End;
      if blnResult then
        fCommit;
    Except
      On E: Exception do
      begin
        if blnResult then
          blnResult := False;
        pMensagensErro(e.Message, '[TfrmGarantiaGeraCreditos.pConfirma]');
        Exit;
      end;
    end;
  Finally
    if blnResult Then
      fMensagem('','Créditos Liberados com Sucesso!', ['&OK'])
    else
      fRollBack;

    qryDados.Close;
    qryDados.Filter := '';
    qryDados.Filtered := False;
    qryDados.EnableControls;

    if Assigned(qryUpdate) Then
      FreeAndNil(qryUpdate);

    stlProcessar.Free;
    lCRMGarantia.Free;
  End;
end;

procedure TfrmGarantiaGeraCreditos.pMarcar(intOpcao: Integer);
begin
  if (Not qryDados.Active) Or (qryDados.IsEmpty) Then
    Exit;

  qryDados.Edit;
  Case intOpcao Of
    0,
    1 : qryDados.FieldByName('MARDES').AsInteger := intOpcao;
    2 : qryDados.FieldByName('MARDES').AsInteger := IIF( qryDados.FieldByName('MARDES').AsInteger = 0, 1, 0);

  End;
  qryDados.Post;
end;

function TfrmGarantiaGeraCreditos.fGravaCreditoCliente(strNumDup,
strEspDup, strCodCli, strCodVen, strCodDig, strPortad: String; fltValDup: Double; strAutIncGer, strHistor: String; out strSeqRec: String): Boolean;
  Var
    qryConsulta : TUniQuery;
    strParcel   : String;
Begin
  qryConsulta := fCriaQuery(Self);
  With qryConsulta, SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT SQL_NO_CACHE              ');
    Add('        MAX(CTR_PARCEL) AS PARCEL ');
    Add(' FROM CADREC                      ');
    Add(' WHERE CTR_NUMDUP = :NUMDUP       ');
    Add('   AND CTR_SEQBAI = :SEQBAI       ');
    Add('   AND CTR_ESPDOC = :ESPDOC       ');
    Add('   AND CTR_CODCLI = :CODCLI       ');
    Add('   AND CTR_CODEMP = :CODEMP       ');

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('SEQBAI').AsString := '0';
    ParamByName('ESPDOC').AsString := 'CC';
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    If IsEmpty or fEmptystr(FieldByName('PARCEL').AsString) Then
      strParcel := 'A'
    Else
      strParcel := Chr(Ord(FieldByName('PARCEL').AsString[1]) + 1);

  End;
  FreeAndNil(qryConsulta);

  Result := fGravaCadRec(strSeqRec,
                         Self.Name,
                         'INCLUSÃO',
                         strNumDup,                                                          // Duplicata
                         strParcel,                                                          // Parcela
                         0,                                                                  // Sequencial de Baixa
                         'CC',                                                               // Espécie
                         strCodCli,                                                          // Cliente
                         VS_strCodEmp,                                                       // Empresa
                         strCodVen,                                                          // Vendedor
                         strCodDig,                                                          // Digitador
                         strPortad,                                                          // Portador
                         VS_Date,                                                            // Data de Cadastro
                         VS_Date,                                                            // Data de Vencimento
                         -fltValDup,                                                         // Valor da Duplicata
                         -fltValDup,                                                         // Valor Original
                         0.0,                                                                // Despesa de Cobrança
                         'N',                                                                // Desconto
                         strHistor,                                    // Histórico 1
                         '',                                                                 // Histórico 2
                         '',                                                                 // Portador da Baixa
                         '',                                                                 // Centro de Custo da Baixa
                         '',                                                                 // Operador da Baixa
                         '',                                                                 // Documento da Baixa
                         0.0,                                                                // Valor do Recebimento
                         0,                                                                  // Data do Recebimento
                         'N',
                         '',                                                                 // Código do Evento
                         '',                                                                 // Código Velho (CONVERSÃO)
                         '',                                                                 // Tipo de Fora (Condição de Pagamento)
                         '',                                                                 // Código da Condição de Pagamento
                         False,
                         '',                                                                 // Codigo do Centro de Custo
                         0,                                                                  // Sequencial de Controle
                         0,
                         '',                                                                 // Observação de Agrupamento 1
                         '',                                                                 // Observação de Agrupamento 2
                         '',                                                                // Observação de Agrupamento 3
                         '',    //   strCtaSer
                         0,     //   fltValSer
                         0,     //   intResCai
                         0,     //   fltVlrCom
                         0,     //   fltFatCom
                         '',    //   strEmpBai
                         '',    //   strEmp_PD
                         '',    //   strDocDiv
                         '',    //   strEspDiv
                         '',    //   strEmpDiv
                         '',    //   strCliDiv
                         0,     //   fltVlrRep
                         0,     //   fltFatRep
                         '',    //   strCodRep
                         0,     //   fltValIPI
                         0,     //   fltValRet
                         'N',   //   strOriF11
                         0,     //   fltDesSuj
                         0,     //   fltJurSuj
                         0,     //   fltValCqP
                         0,     //   fltValCqV
                         0,     //   fltValDin
                         0,     //   fltValCar
                         0,     //   fltValOrd
                         0,     //   fltValFin
                         '',    //   strBarCon
                         0,     //   fltPerDPo
                         0,     //  intQtdDAV
                         0,     //   fltVrTrDv
                         '',    //   strHisBai
                         0,     //   fltValAce
                         0,     //   fltValFre
                         0,     //   fltDifOri
                         0,     //   fltValAnt
                         0,     //   fltComDiv
                         0,     //   fltFatDiv
                         '',    //   strCodDiv
                         0,     //   fltValFCP
                         'INCLUSÃO', //     strStatusDEPS:
                         '',  //    strOpcDoc:
                         '',  //     strAutincMovGerFC:
                         strAutIncGer); //   strINCDOC:
end;


function TfrmGarantiaGeraCreditos.fGravarNumDUPNaMovGag(const strAutInc,
  strNumDUP: String): Boolean;
  Var
    Qry: TUniQuery;
begin
  Result := True;
  Qry := Nil;
  Try
    Try
      Qry := fCriaQuery(Nil);
      Qry.Close;
      Qry.SQL.Clear;
      Qry.SQL.Add('UPDATE MOVGAG SET GAG_NUMCCR = :NUMDUP WHERE AUTOINCREM = :AUTINC AND ((GAG_NUMCCR IS NULL) OR (GAG_NUMCCR = ""))');
      Qry.ParambyName('NUMDUP').AsString := strNumDup;
      Qry.ParambyName('AUTINC').AsString := strAutInc;
      Qry.ExecSql;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    end;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

end.
