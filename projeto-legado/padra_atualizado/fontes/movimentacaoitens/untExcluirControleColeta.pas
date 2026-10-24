unit untExcluirControleColeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untObservacao,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untPai, untZClient,
  cxCheckBox, uni, Datasnap.DBClient, untTLock, untSalvaConfiguracaoGrid,
  cxCurrencyEdit, untTrocaOrigemMovimentacaoProgramada;

type
  TfrmExcluirControleColeta = class(TfrmPai)
    cxvDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxgDados: TcxGridCitel;
    btnConfirma: TBitBtnLocked;
    dtsDados: TDataSource;
    cxvDadosColumn1: TcxGridDBColumn;
    cxvDadosColumn2: TcxGridDBColumn;
    cxvDadosColumn3: TcxGridDBColumn;
    cxvDadosColumn4: TcxGridDBColumn;
    cxvDadosColumn5: TcxGridDBColumn;
    cxvDadosColumn6: TcxGridDBColumn;
    cxvDadosColumn7: TcxGridDBColumn;
    cxvDadosColumn8: TcxGridDBColumn;
    cxvDadosColumn9: TcxGridDBColumn;
    cxvDadosColumn10: TcxGridDBColumn;
    cxvDadosColumn11: TcxGridDBColumn;
    cxvDadosColumn12: TcxGridDBColumn;
    cxvDadosColumn13: TcxGridDBColumn;
    cxvDadosColumn14: TcxGridDBColumn;
    cxvDadosColumn15: TcxGridDBColumn;
    cxvDadosColumn16: TcxGridDBColumn;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    cxvDadosColumn17: TcxGridDBColumn;
    btnTrocarLocOrigem: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pCriaDados;

    function fRetSQL: String;
    procedure cxvDadosColumn12GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxvDadosColumn15GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cdsDadosBeforePost(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnTrocarLocOrigemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
     objLock  : TLock;
     cdsDados: TZClient;
     procedure pExcluiColetasSelecionadas;
     procedure pMarcaDesMarcaTodos(blnMarca: Boolean);
     function fTemMovimentacaoProgramadaComSeparacaoNaoFaturado(strCodIte, strLotDes: String): Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExcluirControleColeta: TfrmExcluirControleColeta;

implementation

uses
  untConstantes, untTypesSistema, untFuncoesSimples;


{$R *.dfm}

procedure TfrmExcluirControleColeta.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  cdsDados.DisableControls;
  Try
    cdsDados.Filtered := False;
    cdsDados.Filter := 'EXCLUIR > 0';
    cdsDados.Filtered := True;

    If cdsDados.IsEmpty Then
    Begin
      pMensagemOk('Nenhuma coleta marcada para ser excluida!');
      Exit;
    End;

    If fPergunta('Excluir coletas selecionadas?') then
    Begin
      pExcluiColetasSelecionadas;
      Close;
    End;
  Finally
    cdsDados.Filtered := False;
    cdsDados.EnableControls;
  End;
end;


procedure TfrmExcluirControleColeta.pMarcaDesMarcaTodos(blnMarca: Boolean);
begin
  cdsDados.First;
  while not cdsDados.Eof do
  begin
    cdsDados.Edit;
    cdsDados.FieldByName('EXCLUIR').AsInteger := IIf(blnMarca, 1 , 0);
    cdsDados.Post;
    cdsDados.Next;
  End;
End;


procedure TfrmExcluirControleColeta.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesMarcaTodos(False);
end;

procedure TfrmExcluirControleColeta.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pMarcaDesMarcaTodos(True);
end;

procedure TfrmExcluirControleColeta.btnTrocarLocOrigemClick(Sender: TObject);
begin
  inherited;
  If dtsDados.DataSet.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmTrocaOrigemMovimentacaoProgramada, frmTrocaOrigemMovimentacaoProgramada);
  Try
    frmTrocaOrigemMovimentacaoProgramada.edtLocFisOri.Text := dtsDados.DataSet.FieldByName('LOCFIS_ORIGEM').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtQtdMov.Text := FloatToStr(fFormataFloat(dtsDados.DataSet.FieldByName('MLT_QTDMOV').AsFloat - dtsDados.DataSet.FieldByName('MLT_QTDCNF').AsFloat, 2));
    frmTrocaOrigemMovimentacaoProgramada.edtLocFisDes.Text := dtsDados.DataSet.FieldByName('LOCFIS_DESTINO').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtCapacidade.Text := dtsDados.DataSet.FieldByName('LOC_CAPACI').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtCodIte.Text := dtsDados.DataSet.FieldByName('MLT_CODITE').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtDesIte.Text := dtsDados.DataSet.FieldByName('ITE_DESITE').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtCodMar.Text := dtsDados.DataSet.FieldByName('ITE_CODMAR').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtDesMar.Text := dtsDados.DataSet.FieldByName('MAR_DESMAR').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtSigUni.Text := dtsDados.DataSet.FieldByName('ITE_CODUNI').AsString;

    frmTrocaOrigemMovimentacaoProgramada.edtNumLotOri.Text := dtsDados.DataSet.FieldByName('LOT_ORIGEM').AsString;
    frmTrocaOrigemMovimentacaoProgramada.edtNumLotDes.Text := dtsDados.DataSet.FieldByName('LOT_DESTINO').AsString;

    frmTrocaOrigemMovimentacaoProgramada.strIncremOrigem :=  dtsDados.DataSet.FieldByName('INCMOV').AsString;
    frmTrocaOrigemMovimentacaoProgramada.strOpeDes := dtsDados.DataSet.FieldByName('OPEDES').AsString;


    frmTrocaOrigemMovimentacaoProgramada.ShowModal;

    FreeAndNil(cdsDados);
    pCriaDados;

  Finally
    FreeAndNil(frmTrocaOrigemMovimentacaoProgramada);
  End;
end;

procedure TfrmExcluirControleColeta.cdsDadosBeforePost(DataSet: TDataSet);
var
  strTrava: String;
begin
  inherited;
  strTrava := 'MOVIMENTACAO_PROGRAMADA-' + cdsDados.FieldByname('INCMOV').AsString;
  If cdsDados.FieldByName('EXCLUIR').AsInteger = 1 then
  begin
    If not objLock.fLock_Unlock(strTrava, True, False) Then
    begin
      fMensagem('ATENÇÃO!', 'Esta movimentação já está sendo utilizada em outra estação: ' + fGetHostLock(strTrava + '%'), ['&Ok']);
      cdsDados.FieldByName('EXCLUIR').AsInteger := 0;
    End
    Else
    If fTemMovimentacaoProgramadaComSeparacaoNaoFaturado(cdsDados.FieldByName('MLT_CODITE').AsString,cdsDados.FieldByName('LOT_DESTINO').AsString) Then
    Begin
      cdsDados.FieldByName('EXCLUIR').AsInteger := 0;
      objLock.fLock_Unlock(strTrava, False, False);
    End;
  End
  Else
    objLock.fLock_Unlock(strTrava, False, False);

{}
end;

procedure TfrmExcluirControleColeta.cxvDadosColumn12GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'S' Then
    AText := 'Sim'
  Else
    AText := 'Não'

end;

procedure TfrmExcluirControleColeta.cxvDadosColumn15GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'S' Then
    AText := 'Sim'
  Else
    AText := 'Não'

end;

procedure TfrmExcluirControleColeta.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDados;
  objLock   := TLock.Create;
end;


procedure TfrmExcluirControleColeta.pCriaDados;
begin
  cdsDados := TZClient.Create(Self, fRetSQL);
  cdsDados.fAbreClient(False, 'TfrmExcluirControleColeta.FormShow');
  dtsDados.DataSet := cdsDados;
  cdsDados.BeforePost := cdsDadosBeforePost;
End;

procedure TfrmExcluirControleColeta.FormDestroy(Sender: TObject);
begin
  inherited;

  objLock.pDestravarTodos;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesGrid(cxvDados, Self.Name);
  FreeAndNil(objLock);
end;

procedure TfrmExcluirControleColeta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_f11 Then
    btnTrocarLocOrigem.Click;
end;

procedure TfrmExcluirControleColeta.FormShow(Sender: TObject);
begin
  inherited;
  TSalvaConfiguracaoGrid.pCarregaConfiguracoesGrid(cxvDados, Self.Name);

end;

function TfrmExcluirControleColeta.fRetSQL: String;
begin
  Result := '';
  Result := Result + 'SELECT 0 AS EXCLUIR  , MOVLOT.AUTOINCREM AS INCMOV, ';
  Result := Result + '       MLT_DTACAD,  ';
  Result := Result + '       CONCAT(MLT_CODOPE, "-", O.OPE_NOMOPE) AS OPEMOV,  ';
  Result := Result + '       CONCAT(MLT_OPEDES, "-", OD.OPE_NOMOPE) AS OPEDES,  ';
  Result := Result + '       MLT_CODITE,  ';
  Result := Result + '       ITE_DESITE,  ';
  Result := Result + '       ITE_CODUNI,  ';
  Result := Result + '       UNI_DESUNI,  ';
  Result := Result + '       ITE_REFERE,  ';
  Result := Result + '       ITE_CODMAR,  ';
  Result := Result + '       MAR_DESMAR,  ';
  Result := Result + '       LD.LOC_CAPACI,  ';
  Result := Result + '       LTO.LOT_NUMLOT AS LOT_ORIGEM,  ';
  Result := Result + '       LTO.LOT_LOCFIS AS LOCFIS_ORIGEM,  ';
  Result := Result + '       LO.LOC_PICKIN ORIGEM_PICKING,  ';
  Result := Result + '       LTD.LOT_NUMLOT AS LOT_DESTINO,  ';
  Result := Result + '       LTD.LOT_LOCFIS AS LOCFIS_DESTINO,  ';
  Result := Result + '       LD.LOC_PICKIN DESTINO_PICKING,  ';
  Result := Result + '       MLT_QTDMOV,  ';
  Result := Result + '       MLT_QTDCNF   ';
  Result := Result + '  FROM MOVLOT  ';
  Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = MLT_CODITE  ';
  Result := Result + ' LEFT JOIN CADOPE O ON O.OPE_CODOPE = MLT_CODOPE   ';
  Result := Result + ' LEFT JOIN CADOPE OD ON OD.OPE_CODOPE = MLT_OPEDES   ';

  Result := Result + '  LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI  ';
  Result := Result + '  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR  ';
  Result := Result + ' INNER JOIN CADLOT LTO ON LTO.LOT_CODEMP = MLT_CODEMP  ';
  Result := Result + '                 AND LTO.LOT_CODITE = MLT_CODITE  ';
  Result := Result + '                 AND LTO.LOT_NUMLOT = MLT_LOTORI  ';
  Result := Result + '  LEFT JOIN CADLOC LO ON LO.LOC_CODLOC = LTO.LOT_LOCFIS AND LO.LOC_CODEMP = LTO.LOT_CODEMP  ';
  Result := Result + ' INNER JOIN CADLOT LTD ON LTD.LOT_CODEMP = MLT_CODEMP  ';
  Result := Result + '                      AND LTD.LOT_CODITE = MLT_CODITE  ';
  Result := Result + '                      AND LTD.LOT_NUMLOT = MLT_LOTDES  ';
  Result := Result + ' LEFT JOIN CADLOC LD ON LD.LOC_CODLOC = LTD.LOT_LOCFIS AND LD.LOC_CODEMP = LTD.LOT_CODEMP  ';
  Result := Result + ' LEFT JOIN LCKATC ON LCK_ORIGEM = "COLETOR-MOVIMENTACAO_PROGRAMADA" AND LOCATE(MOVLOT.AUTOINCREM, LCK_CHAACE) > 0  ';
  Result := Result + 'WHERE MLT_CODEMP = "' + VS_StrCodemp  + '"  ';
  Result := Result + '  AND LCKATC.LCK_CON_ID IS NULL  ';
  Result := Result + '  AND MLT_OPEREA IS NULL ';
end;

procedure TfrmExcluirControleColeta.pExcluiColetasSelecionadas;
var qryMOVLOT: TUniQuery;
    qryCommand: TUniQuery;
begin
  cdsDados.First;
  qryMOVLOT := fCriaQuery;
  qryCommand  := fCriaQuery;
  Try
    qryMOVLOT.SQL.Add('SELECT * FROM MOVLOT WHERE AUTOINCREM = :INCMOV');
    While not cdsDados.Eof Do
    Begin
        qryMOVLOT.ParamByName('INCMOV').AsString := cdsDados.FieldByName('INCMOV').AsString;
        qryMOVLOT.Open;
        fVerificaIntegridade(Self.Name, 'MOVLOT', qryMOVLOT, True, False, '', strLoginUsuarioLogado);
        qryCommand.SQL.Clear;
        qryCommand.SQL.Add('DELETE FROM MOVLOT WHERE MOVLOT.AUTOINCREM = "'+cdsDados.FieldByName('INCMOV').AsString+'"');
        qryCommand.ExecSQL;

        qryMOVLOT.Close;
      cdsDados.Next;
    End;

  Finally
    FreeAndNil(qryCommand);
    FreeAndNil(qryMOVLOT);
  End;
end;

function TfrmExcluirControleColeta.fTemMovimentacaoProgramadaComSeparacaoNaoFaturado(strCodIte, strLotDes: String): Boolean;
var
  qryMovimento: TUniQuery;
  frmObservacaoLocal: TfrmObservacao;
  strMensagem: string;
begin
  Result := False;
  qryMovimento := fCriaQuery;
  try
    qryMovimento.Close;
    qryMovimento.SQL.Clear;
    qryMovimento.SQL.Add(' SELECT                                             ');
    qryMovimento.SQL.Add('  D.FGO_DTAENT,                                     ');
    qryMovimento.SQL.Add('  D.FGO_NUMDOC,                                     ');
    qryMovimento.SQL.Add('  D.FGO_ESPDOC,                                     ');
    qryMovimento.SQL.Add('  D.FGO_CODEMP,                                     ');
    qryMovimento.SQL.Add('  D.FGO_CODCLI,                                     ');
    qryMovimento.SQL.Add('  L.CLI_NOMCLI                                      ');
    qryMovimento.SQL.Add('   FROM                                             ');
    qryMovimento.SQL.Add('  MOVLOT A                                          ');
    qryMovimento.SQL.Add(' INNER JOIN FATDOR B ON A.MLT_CODITE = B.FDO_CODITE ');
    qryMovimento.SQL.Add('                    AND B.FDO_JAFATU = "0"          ');
    qryMovimento.SQL.Add(' INNER JOIN LOTDOR C ON B.AUTOINCREM = C.LDO_SEQFDO ');
    qryMovimento.SQL.Add('                    AND A.MLT_LOTDES = C.LDO_NUMLOT ');
    qryMovimento.SQL.Add(' INNER JOIN FATGOR D ON B.FDO_SEQGER = D.AUTOINCREM ');
    qryMovimento.SQL.Add(' INNER JOIN EXTGOR E ON D.AUTOINCREM = E.FGO_SEQFGO ');
    qryMovimento.SQL.Add('                    AND E.FGO_EMPEXP = A.MLT_CODEMP ');
    qryMovimento.SQL.Add(' INNER JOIN CADCLI L ON L.CLI_CODCLI = D.FGO_CODCLI ');
    qryMovimento.SQL.Add(' WHERE MLT_CODEMP = :CODEMP                         ');
    qryMovimento.SQL.Add('   AND MLT_CODITE = :CODITE                         ');
    qryMovimento.SQL.Add('   AND MLT_LOTDES = :LOTDES                         ');
    qryMovimento.SQL.Add('   AND MLT_DTAREA IS NULL                           ');
    qryMovimento.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryMovimento.ParamByName('CODITE').AsString := strCodIte;
    qryMovimento.ParamByName('LOTDES').AsString := strLotDes;
    qryMovimento.Open;

    if not qryMovimento.IsEmpty then
    begin
      Result := True;
      qryMovimento.First;
      pCriarFormularios(TfrmObservacao, frmObservacaoLocal);
      try
        strMensagem :=               'Atenção! A movimentação programada selecionada tem pedidos com separações impressas para o lote de destino vinculados e por isso, não';
        strMensagem := strMensagem + sLineBreak;
        strMensagem := strMensagem + 'pode ser excluída. Para conseguir excluir essa movimentação se de fato houver necessidade, estorne a separação dos pedidos relacionados';
        strMensagem := strMensagem + sLineBreak;
        strMensagem := strMensagem + 'abaixo se o produto ainda não foi retirado do estoque e depois tente novamente.';
        strMensagem := strMensagem + sLineBreak + sLineBreak;

        While not qryMovimento.Eof Do
        Begin
          strMensagem := strMensagem + 'Data: '+ FormatDateTime('dd/mm/yyyy',qryMovimento.FieldByName('FGO_DTAENT').AsDateTime) + ' - ' +
                                       'Pedido: '+ qryMovimento.FieldByName('FGO_NUMDOC').AsString + '-' + qryMovimento.FieldByName('FGO_ESPDOC').AsString + ' - ' +
                                       'Cliente: '+ qryMovimento.FieldByName('FGO_CODCLI').AsString + '-' + qryMovimento.FieldByName('CLI_NOMCLI').AsString;
          strMensagem := strMensagem + sLineBreak;
          qryMovimento.Next;
        End;

        frmObservacaoLocal.Width := 1000;
        frmObservacaoLocal.lblMensagem.Caption := 'Item '+strCodIte+' e o lote '+strLotDes+' com movimentação programada em aberto!';
        frmObservacaoLocal.memObs.Texto := strMensagem;
        frmObservacaoLocal.ShowModal;
      finally
        pFreeAndNil(frmObservacaoLocal);
      end;
    end;
  finally
    FreeAndNil(qryMovimento);
  end;
end;

end.
