unit untInformarPedidoVendaItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, uniClientDataSet, uni, Datasnap.DBClient, Vcl.ComCtrls,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmInformarPedidoVendaItens = class(TfrmPaiConfirma)
    cxItemsTblVw: TcxGridDBTableView;
    cxItemsLvl: TcxGridLevel;
    cxItems: TcxGrid;
    dtsItens: TDataSource;
    cxItemsDescri : TcxGridDBColumn;
    cxItemsUnidad : TcxGridDBColumn;
    cxItemsQuanti : TcxGridDBColumn;
    cxItemsVlrUni : TcxGridDBColumn;
    cxItemsVrTotal: TcxGridDBColumn;
    cxItemsPedVen : TcxGridDBColumn;
    cxItemsESPECI : TcxGridDBColumn;
    cxItemsEMPPED : TcxGridDBColumn;
    cxItemsDtaEnt : TcxGridDBColumn;
    cxItemsCodite: TcxGridDBColumn;
    pgbProgress: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxItemsTblVwKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnDataSetAfterPost(DataSet: TDataSet);
    procedure cxItemsTblVwKeyPress(Sender: TObject; var Key: Char);
    procedure cxItemsTblVwEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
  private
    qryConsulta: TUniQuery;
    function fValidarPedidoECarregaCampos(strCodEmp, strNumPed: String): Boolean;
    function fCarregarCamposPedido(strCodEmp, strNumPed, strAutPedItem: string; dtPedDta: TDateTime): Boolean;
    { Private declarations }
  public
    { Public declarations }
    class function fRelacionaItemPedidoVenda(var cdsItens: TUniClientDataSet): Boolean;
  end;

var
  frmInformarPedidoVendaItens: TfrmInformarPedidoVendaItens;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

{ TfrmInformarPedidoVendaItens }

procedure TfrmInformarPedidoVendaItens.OnDataSetAfterPost(
  DataSet: TDataSet);
begin
  dtsItens.DataSet.AfterPost := Nil;
  Try
    If Not fEmptyStr(dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString) Then
    Begin
      If fEmptyStr(fRetNomeEmpresa(dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString)) Then
      Begin
        pMensagemOk('Código da Empresa [ ' + dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString + ' ] Inválido ');
        dtsItens.DataSet.Edit;
        dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString   := VS_StrCodEmp;
        dtsItens.DataSet.Post;
      End;
    End;

    If ((Not fEmptyStr(dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString)) And
         Not fEmptyStr(dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString)) Then
    Begin
      If Not fValidarPedidoECarregaCampos(dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString,
                                          dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString) Then
      Begin
        pMensagemOk('O Pedido [' + dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString + ' - ' +
                     fStrZero(dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString, fTamNumDoc) + '- PD ]' + ' não foi encontrado ou não contém o item [' +
                     dtsItens.DataSet.FieldbyName('ITE_CODITE').AsString + '].');
        dtsItens.DataSet.Edit;
        dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString   := VS_StrCodEmp;
        dtsItens.DataSet.FieldbyName('ITE_PEDVEN').Clear;
        dtsItens.DataSet.FieldbyName('ITE_PEDDTA').Clear;
        dtsItens.DataSet.FieldbyName('ITE_SEQFDO').Clear;
        dtsItens.DataSet.Post;
      End;
    End;
  Finally
    dtsItens.DataSet.AfterPost := OnDataSetAfterPost;
  End;
end;

procedure TfrmInformarPedidoVendaItens.cxItemsTblVwEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
     cxItemsTblVwKeyPress(Sender, Key);

end;

procedure TfrmInformarPedidoVendaItens.cxItemsTblVwKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
    Var
    strCodEmp,
    strPedVen,
    strDtaEnt,
    strAutPedItem,
    strMensagem: String;

begin
  If (Key = 13) Then
  begin
    cxItemsTblVw.DataController.Edit;
    If cxItemsEMPPED.Focused Then
    begin
      cxItemsPedVen.Focused := True;
      cxItemsPedVen.Options.Editing := True;
      cxItemsPedVen.Editing := True;
    End
    Else
    Begin
      cxItemsEMPPED.Focused := True;
      cxItemsEMPPED.Options.Editing := True;
      cxItemsEMPPED.Editing := True;
    End;
    Exit;
  End
  Else
  If Key = VK_F5 Then
  begin
    If fMensagem('Atenção', 'Deseja replicar as informações do Pedido de Venda para os outros itens?', ['Sim', 'Não']) = 1 Then
    Begin
      Try
        dtsItens.DataSet.AfterPost := Nil;
        dtsItens.DataSet.DisableControls;
        strCodEmp := dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString;
        strPedVen := dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString;
        strDtaEnt := dtsItens.DataSet.FieldbyName('ITE_PEDDTA').AsString;
        strAutPedItem := dtsItens.DataSet.FieldbyName('ITE_SEQFDO').AsString;
        pgbProgress.Max := dtsItens.DataSet.RecordCount -1;
        dtsItens.DataSet.First;
        strMensagem := '';
        While Not dtsItens.DataSet.Eof Do
        Begin
          Try
             If fEmptyStr(dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString) Then
             Begin
               If Not fValidarPedidoECarregaCampos(strCodEmp, strPedVen) Then
               Begin
                 strMensagem := strMensagem + ' Item [' + dtsItens.DataSet.FieldbyName('ITE_CODITE').AsString + '] ' +
                                              ' Não encotrado no Pedido [' +   strCodEmp + ' - ' + strPedVen + ' - ' + 'PD]. ' + #$A#$D;


               End;
             End;
          Finally
            pgbProgress.Position := dtsItens.DataSet.RecNo;
            Application.ProcessMessages;
            dtsItens.DataSet.Next;
          End;
        End;
      Finally
        If Not fEmptyStr(strMensagem) Then
          pMensagemOk(strMensagem);
        dtsItens.DataSet.AfterPost := OnDataSetAfterPost;
        pgbProgress.Position := 0;
        dtsItens.DataSet.EnableControls;
      End;
    End
  End;
end;


procedure TfrmInformarPedidoVendaItens.cxItemsTblVwKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
Begin

  If fEntraCons(Key) Then
  Begin
    If (cxItemsPedVen.Focused) And
       (fPesqPedOrc(conPedOrdPro, Self, 'PD', 'PD', '',  Nil, Nil,
                    Nil, qryConsulta, key, arrSel, True, Nil, '', 'N',
                    dtsItens.DataSet.FieldbyName('ITE_CODITE').AsString)) Then
    Begin
      fValidarPedidoECarregaCampos(qryConsulta.FieldByName('FDO_CODEMP').AsString,
                                   qryConsulta.FieldByName('FDO_NUMDOC').AsString);
    End

    Else If (cxItemsEMPPED.Focused) And
            (fPesqEmpresa(conEmpSimples, Self, nil, nil, qryConsulta, key, arrSel)) Then
    Begin
      dtsItens.DataSet.AfterPost := Nil;
      dtsItens.DataSet.Edit;
      dtsItens.DataSet.FieldByName('ITE_EMPPED').AsString :=  qryConsulta.FieldByName('EMP_CODEMP').AsString;
      dtsItens.DataSet.Post;
      dtsItens.DataSet.AfterPost := OnDataSetAfterPost;
    End;
  End;
end;

procedure TfrmInformarPedidoVendaItens.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery(Nil);
end;

procedure TfrmInformarPedidoVendaItens.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
end;

procedure TfrmInformarPedidoVendaItens.FormShow(Sender: TObject);
  var strListaChavesPedido: string;
  procedure pCarregarConsulta;
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT D.AUTOINCREM, ');
    qryConsulta.SQL.Add('       IF(FDO_ENTRET  = "R", IFNULL(FGO_PREVIS, CURRENT_DATE), CURRENT_DATE) DATCAL, ');
    qryConsulta.SQL.Add('       FDO_NUMDOC, ');
    qryConsulta.SQL.Add('       FDO_CODEMP ');
    qryConsulta.SQL.Add('  FROM FATDOR D');
    qryConsulta.SQL.Add('  LEFT JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER');
    qryConsulta.SQL.Add('  LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM');
    qryConsulta.SQL.Add('WHERE D.AUTOINCREM IN (' + strListaChavesPedido + ')');
    qryConsulta.Open;
  End;

begin
  inherited;
  pSetFocus(cxItems);
  //Se os items tiverem o autoincrem do pedido porem tiver vazio o pedido de compra carrega os pedidos referente;
  //Isso acontece quando estiver alterando um pedido;
  dtsItens.DataSet.DisableControls;
  dtsItens.DataSet.AfterPost := nil;
  Try
    dtsItens.DataSet.Filter  :=  'ITE_PEDVEN = ' + QuotedStr('') + ' And ITE_SEQFDO <> ' + QuotedStr('');
    dtsItens.DataSet.Filtered := True;
    //Se tiver vazio não precisa carregar os dados adicionais que não estão armazenados na tebela da PCMDET
    //MAS AINDA FAZ-SE NECESSARIO VERIFICA SE TODOS OS CAMPOS ESTÃO VAZIO, ISSO ACONTECE SE FOR GRAVADO O PEDIDO SEM GERAR RELACIONAMENTO COM FATDOR
    If dtsItens.DataSet.IsEmpty Then
    Begin
      dtsItens.DataSet.Filter  :=  'ITE_PEDVEN = ' + QuotedStr('') + ' AND ITE_SEQFDO = ' + QuotedStr('') +' AND ITE_ESPPVE = ' + QuotedStr('');
      dtsItens.DataSet.Filtered := True;
      If dtsItens.DataSet.IsEmpty Then
        Exit
      Else
      Begin
        While Not dtsItens.DataSet.IsEmpty do
        Begin
          dtsItens.DataSet.Edit;
          dtsItens.DataSet.FieldByName('ITE_ESPPVE').AsString := 'PD';
          dtsItens.DataSet.FieldByName('ITE_EMPPED').AsString := VS_StrCodEmp;
          dtsItens.DataSet.Post;
        End;
        Exit;
      End;
    End;

    dtsItens.DataSet.First;
    While Not dtsItens.DataSet.Eof do
    Begin
      strListaChavesPedido := strListaChavesPedido + '"' + dtsItens.DataSet.FieldByName('ITE_SEQFDO').AsString + '",';
      dtsItens.DataSet.Next;
    End;
    //Tira a ultima virgula;
    strListaChavesPedido := Copy(strListaChavesPedido, 0, Length(strListaChavesPedido) -1);
    //Carrega as informações da fatdor;
    pCarregarConsulta;
    // Limpa o filtro para não interferir no carregamento dos itens
    dtsItens.DataSet.Filtered := False;
    //Atribui os valores da fatdor nos itens do pedido
    dtsItens.DataSet.First;
    While Not dtsItens.DataSet.Eof do
    Begin
      If qryConsulta.Locate('AUTOINCREM', dtsItens.DataSet.FieldByName('ITE_SEQFDO').AsString, []) Then
      Begin
        dtsItens.DataSet.Edit;
        dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString   := qryConsulta.FieldByName('FDO_CODEMP').AsString;
        dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString   := qryConsulta.FieldByName('FDO_NUMDOC').AsString;
        dtsItens.DataSet.FieldbyName('ITE_PEDDTA').AsDateTime := qryConsulta.FieldByName('DATCAL'    ).AsDateTime;
        dtsItens.DataSet.FieldbyName('ITE_ESPPVE').AsString   := 'PD';
        dtsItens.DataSet.Post;
      End;
      dtsItens.DataSet.Next;
    End;
  Finally
    dtsItens.DataSet.EnableControls;
    dtsItens.DataSet.Filtered := False;
    dtsItens.DataSet.Filter := '';
    dtsItens.DataSet.AfterPost := OnDataSetAfterPost;
  End;
end;

class function TfrmInformarPedidoVendaItens.fRelacionaItemPedidoVenda(var cdsItens: TUniClientDataSet): Boolean;
  var
    objBackupData: OleVariant;
    onAfterPost: TDataSetNotifyEvent;
Begin
  Result := False;
  onAfterPost := cdsitens.AfterPost;
  pCriarFormularios(TfrmInformarPedidoVendaItens, frmInformarPedidoVendaItens);
  Try
    objBackupData := cdsItens.Data;
    frmInformarPedidoVendaItens.dtsItens.DataSet := cdsItens;
    frmInformarPedidoVendaItens.cxItemsTblVw.ApplyBestFit();
    cdsitens.AfterPost := frmInformarPedidoVendaItens.OnDataSetAfterPost;
    If frmInformarPedidoVendaItens.Showmodal = mrOk Then
      Result := True
    Else
      cdsItens.Data := objBackupData;
  Finally
    cdsitens.AfterPost := onAfterPost;
    FreeAndNil(frmInformarPedidoVendaItens);
  End;
End;

function TfrmInformarPedidoVendaItens.fValidarPedidoECarregaCampos(strCodEmp, strNumPed: String): Boolean;
begin
  Result := False;

  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('SELECT D.AUTOINCREM, ');
  qryConsulta.SQL.Add('       IF(FDO_ENTRET  = "R", IFNULL(FGO_PREVIS, CURRENT_DATE), CURRENT_DATE) DATCAL, ');
  qryConsulta.SQL.Add('       FDO_NUMDOC, ');
  qryConsulta.SQL.Add('       FDO_CODEMP ');
  qryConsulta.SQL.Add('  FROM FATDOR D');
  qryConsulta.SQL.Add('  LEFT JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER');
  qryConsulta.SQL.Add('  LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM');
  qryConsulta.SQL.Add('  WHERE D.FDO_NUMDOC = :NUMDOC');
  qryConsulta.SQL.Add('    AND D.FDO_CODEMP = :CODEMP');
  qryConsulta.SQL.Add('    AND D.FDO_ESPDOC = "PD"');
  qryConsulta.SQL.Add('    AND D.FDO_JAFATU = 0');
  qryConsulta.SQL.Add('    AND D.FDO_CODITE = :CODITE');

  qryConsulta.ParamByname('NUMDOC').AsString := fStrZero(strNumPed, fTamNumDoc);
  qryConsulta.ParamByname('CODEMP').AsString := strCodEmp;
  qryConsulta.ParamByName('CODITE').AsString := dtsItens.DataSet.FieldByName('ITE_CODITE').AsString;
  qryConsulta.Open;
  If Not qryConsulta.IsEmpty Then
    Result := fCarregarCamposPedido(qryConsulta.FieldByName('FDO_CODEMP').AsString,
                                    qryConsulta.FieldByName('FDO_NUMDOC').AsString,
                                    qryConsulta.FieldByName('AUTOINCREM').AsString,
                                    qryConsulta.FieldByName('DATCAL').AsDateTime);
end;

function TfrmInformarPedidoVendaItens.fCarregarCamposPedido(strCodEmp,
  strNumPed, strAutPedItem: string; dtPedDta: TDateTime): Boolean;
begin
  Result := True;
  dtsItens.DataSet.Edit;
  dtsItens.DataSet.FieldbyName('ITE_EMPPED').AsString   := strCodEmp;
  dtsItens.DataSet.FieldbyName('ITE_PEDVEN').AsString   := strNumPed;
  dtsItens.DataSet.FieldbyName('ITE_PEDDTA').AsDateTime := dtPedDta;
  dtsItens.DataSet.FieldbyName('ITE_SEQFDO').AsString   := strAutPedItem;
  Try
     dtsItens.DataSet.Post;
  Except
    Result := False;
  End;
end;

end.
