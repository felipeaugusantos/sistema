unit untDetalhesRomaneio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxImage, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  Vcl.Grids, Vcl.DBGrids, MemDS, DBAccess, dxLayoutContainer,
  cxGridViewLayoutContainer, cxGridLayoutView, cxGridDBLayoutView,
  cxGridCustomLayoutView, Vcl.DBCtrls, cxImageComboBox, System.ImageList,
  Vcl.ImgList, cxImageList, MemoFocus;

type
  TfrmDetalhesRomaneio = class(TfrmPaiSimples)
    dtsAlbumFot: TDataSource;
    tbsFotos: TTabSheet;
    tbsAssinatura: TTabSheet;
    cxgAlbumFot: TcxGrid;
    cxgAlbumFotDBLayoutView: TcxGridDBLayoutView;
    cxgAlbumFotDBLayoutViewItem1: TcxGridDBLayoutViewItem;
    cxgAlbumFotDBLayoutViewGroup_Root: TdxLayoutGroup;
    cxGridLayoutItem1: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    cxgAlbumFotLevel1: TcxGridLevel;
    imgFotoFot: TImage;
    dtsAlbumAss: TDataSource;
    cxgAlbumAss: TcxGrid;
    cxGridDBLayoutView1: TcxGridDBLayoutView;
    cxGridDBLayoutViewItem1: TcxGridDBLayoutViewItem;
    dxLayoutGroup1: TdxLayoutGroup;
    cxGridLayoutItem2: TcxGridLayoutItem;
    dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup;
    cxGridLevel1: TcxGridLevel;
    imgFotoAss: TImage;
    dtsRomMsg: TDataSource;
    cxgRomMsgDBTableView: TcxGridDBTableViewCitel;
    cxgRomMsgLevel: TcxGridLevel;
    cxgRomMsg: TcxGridCitel;
    lblOcorrencias: TLabel;
    lblMensag: TLabel;
    cxgRomMsgOCR_TIPOCR: TcxGridDBColumn;
    cxImageListMsg: TcxImageList;
    cxgRomMsgOCR_DESCRI: TcxGridDBColumn;
    cxgRomMsgMSG_DTAOCO: TcxGridDBColumn;
    mmoMensag: TMemoFocus;
    cxgRomMsgMSG_HOROCO: TcxGridDBColumn;
    Panel1: TPanel;
    FlowPanel1: TFlowPanel;
    BitBtnLocked1: TBitBtnLocked;
    cxgRomMsgOCR_CODIGO: TcxGridDBColumn;
    Label1: TLabel;
    mmoObserv: TMemoFocus;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsAlbumFot,
    cdsAlbumAss,
    cdsRomMsg : TUniClientDataSet;
    procedure pCriaClientAlbum;
    procedure pAtualizaDadosRomFot(DataSet: TDataSet);
    procedure pAtualizaDadosRomAss(DataSet: TDataSet);
    procedure pAtualizaMsg(DataSet: TDataSet);
    procedure pCarregaAlbuns;
    procedure pCarregaMensagens;
    function fRetornaObsevacaoRomaneio: String;
  public
    { Public declarations }
    strSeqGer: String;
    procedure pCarregaAlbum(cdsDados: TUniClientDataSet; strTabela: String);
  end;

implementation

uses
  untFuncoesSimples, untFuncoesImagem, untTypesSistema, untGravando;

{$R *.dfm}

procedure TfrmDetalhesRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaClientAlbum;

  cdsAlbumFot.AfterScroll := pAtualizaDadosRomFot;
  dtsAlbumFot.DataSet := cdsAlbumFot;

  cdsAlbumAss.AfterScroll := pAtualizaDadosRomAss;
  dtsAlbumAss.DataSet := cdsAlbumAss;
end;

procedure TfrmDetalhesRomaneio.pCriaClientAlbum;
begin
  Try
    cdsAlbumFot := TUniClientDataSet.Create(Nil);
    cdsAlbumFot.AggregatesActive := True;

    cdsAlbumFot.FieldDefs.Add('IMAGEM', ftBlob);
    cdsAlbumFot.FieldDefs.Add('AUTINC', ftString, 20);

    cdsAlbumFot.CreateDataSet;
    TBlobField.Create(cdsAlbumFot.FieldByName('IMAGEM') as TBlobField);


    cdsAlbumAss := TUniClientDataSet.Create(Nil);
    cdsAlbumAss.AggregatesActive := True;

    cdsAlbumAss.FieldDefs.Add('IMAGEM', ftBlob);
    cdsAlbumAss.FieldDefs.Add('AUTINC', ftString, 20);

    cdsAlbumAss.CreateDataSet;
    TBlobField.Create(cdsAlbumAss.FieldByName('IMAGEM') as TBlobField);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TItemPromo.pCriaClientAlbum]');
  End;
end;

function TfrmDetalhesRomaneio.fRetornaObsevacaoRomaneio: String;
var
  qryObserv: TUniQuery;
begin
  qryObserv := fCriaQuery;

  try
    Result := EmptyStr;

    qryObserv.Close;
    qryObserv.SQL.Clear;
    qryObserv.SQL.Add('SELECT H.HIS_OBSERV');
    qryObserv.SQL.Add('FROM HISPED H');
    qryObserv.SQL.Add('INNER JOIN ROMGERX R');
    qryObserv.SQL.Add('ON(H.HIS_NUMROM = R.GER_NUMROM AND');
    qryObserv.SQL.Add('   H.HIS_NUMDOC = R.GER_NUMDOC AND');
    qryObserv.SQL.Add('   H.HIS_ESPDOC = R.GER_ESPDOC AND');
    qryObserv.SQL.Add('   H.HIS_CODEMP = R.GER_CODEMP)');
    qryObserv.SQL.Add('WHERE R.AUTOINCREM = :AUTINC');
    qryObserv.ParamByName('AUTINC').AsString := strSeqGer;
    qryObserv.Open;

    if qryObserv.IsEmpty then
      Exit;

    Result := qryObserv.FieldByName('HIS_OBSERV').AsString;
  finally
    FreeAndNil(qryObserv);
  end;
end;

procedure TfrmDetalhesRomaneio.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsAlbumFot);
  FreeAndNil(cdsAlbumAss);
end;

procedure TfrmDetalhesRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaAlbuns;
  pCarregaMensagens;
end;

procedure TfrmDetalhesRomaneio.pAtualizaDadosRomFot(DataSet: TDataSet);
begin
  if fCarregaImagemRomaneio(DataSet.FieldByName('AUTINC').AsString,
                           'ROMFOT',
                            imgFotoFot.Picture) = riOk then
    imgFotoFot.Visible := True;
end;

procedure TfrmDetalhesRomaneio.pAtualizaDadosRomAss(DataSet: TDataSet);
begin
  if fCarregaImagemRomaneio(DataSet.FieldByName('AUTINC').AsString,
                            'ROMASS',
                            imgFotoAss.Picture) = riOk then
    imgFotoAss.Visible := True;
end;

procedure TfrmDetalhesRomaneio.pAtualizaMsg(DataSet: TDataSet);
begin
  mmoMensag.Clear;
  mmoMensag.Lines.Add(cdsRomMsg.FieldByName('MSG_MENSAG').AsString);

  mmoObserv.Clear;
  mmoObserv.Lines.Add(fRetornaObsevacaoRomaneio);
end;

procedure TfrmDetalhesRomaneio.pCarregaAlbuns;
begin
  pCarregaAlbum(cdsAlbumFot, 'ROMFOT');
  pCarregaAlbum(cdsAlbumAss, 'ROMASS');
end;

procedure TfrmDetalhesRomaneio.pCarregaMensagens;
var
  qryRomMsg: TUniQuery;
begin
  try
    qryRomMsg := fCriaQuery(Self);

    qryRomMsg.Close;
    qryRomMsg.SQL.Text :=
    ' SELECT '+
    '   IFNULL(O.OCR_TIPOCR, "S") AS OCR_TIPOCR, '+
    '   IFNULL(O.OCR_CODIGO, "00000") AS OCR_CODIGO, '+
    '   IFNULL(O.OCR_DESCRI, "ENTREGUE") AS OCR_DESCRI, '+
    '   M.MSG_DTAOCO, '+
    '   M.MSG_HOROCO, '+
    '   M.MSG_MENSAG  '+
    ' FROM '+
    '   ROMMSG M '+
    ' LEFT JOIN OCOROM O '+
    '   ON M.MSG_SEQOCR = O.AUTOINCREM '+
    ' WHERE '+
    '   M.MSG_SEQGER = :SEQGER '+
    ' ORDER BY '+
    '   M.MSG_DTAOCO, '+
    '   M.MSG_HOROCO  ';

    qryRomMsg.ParamByName('SEQGER').AsString := strSeqGer;
    qryRomMsg.Open;

    if Assigned(cdsRomMsg) then
      FreeAndNil(cdsRomMsg);

    cdsRomMsg := fCriaClientDatset(qryRomMsg);
    pSetaClient(cdsRomMsg);

    cdsRomMsg.AfterScroll := pAtualizaMsg;
    dtsRomMsg.DataSet := cdsRomMsg;
  finally
    FreeAndNil(qryRomMsg);
  end;

end;

procedure TfrmDetalhesRomaneio.pCarregaAlbum(cdsDados: TUniClientDataSet; strTabela: String);
var
  qryAlbum: TUniQuery;
  objOutputStream : TBytesStream;
begin
  Try
    qryAlbum := fCriaQuery(Self);
    cdsDados.EmptyDataSet;

    qryAlbum.Close;
    qryAlbum.SQL.Text :=
      ' SELECT * FROM '+
      strTabela+
      ' WHERE '+
      IIF(strTabela = 'ROMFOT', 'FOT_SEQGER', 'ASS_SEQGER')+ ' = :SEQGER';

    qryAlbum.ParamByName('SEQGER').AsString := strSeqGer;
    qryAlbum.Open;

    if not qryAlbum.IsEmpty then
    begin
      qryAlbum.First;
      while not qryAlbum.Eof do
      begin
        cdsDados.Insert;

        cdsDados.FieldByName('AUTINC').AsString := qryAlbum.FieldByName('AUTOINCREM').AsString;

        objOutputStream := TBytesStream.Create;
        try
          if fCarregaImagemRomaneio(qryAlbum.FieldByName('AUTOINCREM').AsString, strTabela, objOutputStream) then
            TBlobField(cdsDados.FieldByName('IMAGEM')).LoadFromStream(objOutputStream);
        finally
          if Assigned(objOutputStream) then objOutputStream.Free;
        end;

        cdsDados.Post;

        qryAlbum.Next;
      end;
    end;

  except
    on E: Exception do
      pMensagensErro(e.Message, '[TfrmDetalhesRomaneio.pCarregaAlbum]')
  end;

  FreeAndNil(qryAlbum);
end;

end.
