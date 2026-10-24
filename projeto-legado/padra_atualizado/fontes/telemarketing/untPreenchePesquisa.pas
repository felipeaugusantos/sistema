unit untPreenchePesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Math,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, DBCtrls,
  DBMemoFocus, untFuncoesSimples, Uni, BitBtnLockedIncrem,
  UniClientDataSet, cxEditRepositoryItems, DateUtils, strUtils, cxImageComboBox,
  cxSpinEdit, cxTextEdit, dxBar, dxBarExtItems, cxBarEditItem, Gauges,
  cxCheckBox, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmPreenchePesquisa = class(TfrmPaiConfirma)
    dtsConsul: TDataSource;
    cxgConsulta: TcxGrid;
    cxgConsultaTable: TcxGridDBTableView;
    cxgConsultaCODPER: TcxGridDBColumn;
    cxgConsultaPERGUN: TcxGridDBColumn;
    cxgConsultaRESPOS: TcxGridDBColumn;
    cxgConsultaLevel1: TcxGridLevel;
    cxgConsultaCODRES: TcxGridDBColumn;
    Panel1: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    cxStyleGroup: TcxStyle;
    btnExpand: TBitBtnLocked;
    btnAgrupa: TBitBtnLocked;
    cxgConsultaRESPONDIDO: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgConsultaRESPOSGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure btnSairClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgConsultaTableCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgConsultaTableCustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
    qryConsul: TUniQuery;
    cdsConsul: TUniClientDataSet;
    dicRespostas: TDicionario;

    function fSqlConsulta: String;
    function fPerguntasRespondidas: Boolean;

    Procedure pAbreConsulta;
    procedure pCarregarClientDataSet;
    procedure pCarregaRespostas;
    procedure pAtualizarDocumentos;

  public
    { Public declarations }
    strCodAge: String;
    cdsResp: TUniClientDataSet;
  end;

var
  frmPreenchePesquisa: TfrmPreenchePesquisa;

implementation

uses untBaixaAgenda, untTypesSistema;

{$R *.dfm}

procedure TfrmPreenchePesquisa.btnExpandClick(Sender: TObject);
begin
  inherited;
  If Sender = btnExpand Then
  Begin
    cxgConsultaTable.ViewData.Expand(True);
    btnExpand.Visible := False;
    btnAgrupa.Visible := True;
  End
  Else
  Begin
    cxgConsultaTable.ViewData.Collapse(True);
    btnExpand.Visible := True;
    btnAgrupa.Visible := False;
  End;
end;

procedure TfrmPreenchePesquisa.btnGravarClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
begin
  inherited;

  Try
    pDisableControls(cdsConsul, prcScroll);

    If Not (fPerguntasRespondidas) then
    Begin
      pMensagemOk('Uma ou mais perguntas não foram respondidas!');
      btnExpandClick(btnExpand);
      Exit;
    End
    else
    Begin

      If fMensagem('','Deseja salvar esta Pesquisa?',['','']) = 1 Then
      Begin
        Try
          If cdsConsul.State = dsEdit Then
            cdsConsul.Post;

          cdsResp := TUniClientDataSet.Create(Nil);
          cdsResp.Data := cdsConsul.Data;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pMensagensErro(E.Message, '[TfrmPreenchePesquisa.btnGravarClick]');
            Exit;
          End;
        End;
      End
      Else
      Begin
        cdsConsul.EmptyDataSet;
      End;

      Close;
    End;

  Finally
    pEnableControls(cdsConsul, prcScroll);
  End;

end;

procedure TfrmPreenchePesquisa.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPreenchePesquisa.cxgConsultaRESPOSGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    intIdx: Integer;
begin
  inherited;
  intIdx := cxgConsultaCODPER.Index;

  If ARecord.Values[intIdx] <> Null Then
    AProperties := TcxEditRepositoryRadioGroupItem(dicRespostas.RetornaObjeto(FormatFloat('00000',ARecord.Values[intIdx]))).Properties;
end;

procedure TfrmPreenchePesquisa.cxgConsultaTableCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsConsul Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaRESPONDIDO.Index] = 'N') Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clBlack;
     
  end;
end;

procedure TfrmPreenchePesquisa.cxgConsultaTableCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  With cdsConsul Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgConsultaRESPONDIDO.Index] = 'N') Then
      ACanvas.Font.Color := clRed
    Else
      ACanvas.Font.Color := clBlack;

  end;
end;

procedure TfrmPreenchePesquisa.FormCreate(Sender: TObject);
begin
  inherited;
  btnExpandClick(btnAgrupa);
  qryConsul    := fCriaQuery(Self);
  dicRespostas := TDicionario.Create;
  pAtualizarDocumentos;
end;

procedure TfrmPreenchePesquisa.pAtualizarDocumentos;
begin
  pCarregaRespostas;
  pAbreConsulta;
end;

procedure TfrmPreenchePesquisa.pCarregaRespostas;
  Var
    qryPerguntas: TUniQuery;
    qryRespostas: TUniQuery;
    rdgResposta : TcxEditRepositoryRadioGroupItem;
begin
  Try
    qryRespostas := fCriaQuery(Self);
    qryPerguntas := fCriaQuery(Self);

    With qryPerguntas Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT   DISTINCT E.PER_CODPER, E.AUTOINCREM                         ');
      SQL.Add('FROM     CADPES S INNER JOIN PESPER P ON S.AUTOINCREM = P.PER_SEQPES ');
      SQL.Add('                  INNER JOIN CADPER E ON E.PER_CODPER = P.PER_CODPER ');
      SQL.Add('WHERE    S.PES_ATIVO_ = "S"                                          ');
      SQL.Add('ORDER BY E.PER_CODPER                                                ');
      Open;

      First;
      While Not EOF Do
      begin

        With qryRespostas Do
        Begin
          rdgResposta := TcxEditRepositoryRadioGroupItem.Create(Nil);
          rdgResposta.Properties.Columns := 3;
          rdgResposta.Properties.DefaultCaption := 'Selecione a opção desejada';
          rdgResposta.Properties.WordWrap := True;

          SQL.Clear;
          SQL.Add('SELECT   AUTOINCREM, RES_DESRES ');
          SQL.Add('FROM     PERRES                 ');
          SQL.Add('WHERE    RES_SEQPER = :AUTINC   ');
          SQL.Add('ORDER BY RES_DESRES             ');
          ParamByName('AUTINC').AsString := qryPerguntas.FieldByName('AUTOINCREM').AsString;
          Open;

          First;
          While Not EOF Do
          begin
            rdgResposta.Properties.Items.Add;
            rdgResposta.Properties.Items[RecNo -1].Value   := qryRespostas.FieldByName('AUTOINCREM').AsString;
            rdgResposta.Properties.Items[RecNo -1].Caption := qryRespostas.FieldByName('RES_DESRES').AsString;

            Next;
          End;

        End;

        dicRespostas.AdicionarObjeto(qryPerguntas.FieldByName('PER_CODPER').AsString, rdgResposta);

        Next;
      End;

    End;

  finally
    FreeAndNil(qryRespostas);
    FreeAndNil(qryPerguntas);
  End;

end;

procedure TfrmPreenchePesquisa.FormDestroy(Sender: TObject);
begin
  If Assigned(cdsConsul) Then
    FreeAndNil(cdsConsul);

  If Assigned(cdsResp) Then
    FreeAndNil(cdsResp);

  If Assigned(dicRespostas) Then
  Begin
    dicRespostas.LimparObjetos;
    FreeAndNil(dicRespostas);
  End;

  inherited;  
end;

Procedure TfrmPreenchePesquisa.pAbreConsulta;
Begin
  Application.ProcessMessages;

  With qryConsul Do
  Begin
    Close;
    SQL.text := fSqlConsulta;
    Open;
  End;

  If Not Assigned(cdsConsul) Then
    cdsConsul := fCriaClientDatset(qryConsul, True);

  pCarregarClientDataSet;

  dtsConsul.DataSet := cdsConsul;

  cxgConsultaTable.ApplyBestFit;
end;

procedure TfrmPreenchePesquisa.pCarregarClientDataSet;
  Var
    prcScroll: TprcScroll;
begin
  Try
    pDisableControls(cdsConsul, prcScroll);

    cdsConsul.EmptyDataSet;
    qryConsul.First;

    While Not qryConsul.Eof Do
    Begin
      Application.ProcessMessages;

      pCopiaRegistroDataSet(qryConsul, cdsConsul);

      qryConsul.Next;
    End;
  Finally
    pEnableControls(cdsConsul, prcScroll);
  End;   

end;

function TfrmPreenchePesquisa.fPerguntasRespondidas: Boolean;
begin
  Result := True;
  With cdsConsul Do
  Begin
    First;
    While Not EOF do
    Begin
      Edit;
      FieldByName('RESPONDIDO').AsString := IIF(fEmptyStr(FieldByName('RESPOS').AsString), 'N', 'S');
      Post;

      If fEmptyStr(FieldByName('RESPOS').AsString) Then
        Result := False;

      Next;
    End;
  End;
end;

function TfrmPreenchePesquisa.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
  strSQL := strSQL + '  S.PES_CODPES AS CODPES, ';
  strSQL := strSQL + '  S.PES_DESPES AS PESQUI, ';
  strSQL := strSQL + '  E.PER_CODPER AS CODPER, ';
  strSQL := strSQL + '  CONCAT(LPAD(PER_SEQUEN,3,"0"),"-",SUBSTR(E.PER_DESPER,1,245)) AS PERGUN, ';
  strSQL := strSQL + '  LPAD(" ", 20, " ") AS CODRES, ';
  strSQL := strSQL + '  LPAD(" ", 50, " ") AS RESPOS, ';
  strSQL := strSQL + '  "S" AS RESPONDIDO, ';
  strSQL := strSQL + '  P.PER_SEQUEN ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPES S INNER JOIN PESPER P ON S.AUTOINCREM = P.PER_SEQPES ';
  strSQL := strSQL + '           INNER JOIN CADPER E ON E.PER_CODPER = P.PER_CODPER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  S.PES_ATIVO_ = "S" ';
  strSQL := strSQL + 'ORDER BY PESQUI, PER_SEQUEN ';

  Result := strSQL;
End;

end.
