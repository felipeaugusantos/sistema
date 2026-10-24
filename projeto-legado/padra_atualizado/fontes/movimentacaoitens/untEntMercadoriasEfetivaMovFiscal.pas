unit untEntMercadoriasEfetivaMovFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB, untTypesSistema,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider, untHelperCitel,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, cxProgressBar,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem,
  untFechamentoEstoque, untFechamentoFiscal;

type
  TfrmEntMercadoriasEfetivaMovFiscal = class(TfrmPaiOrdena)
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    Label2: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FGerEle   : TStringList;
    arrCodFor : TConsultasArray;
    arrCodTra : TConsultasArray;
    FblnMOVGER : Boolean;

    objFechamentoEstoque: TFechamentoEstoque;
    objFechamentoFiscal : TFechamentoFiscal;

    procedure pSetEnabled;
    procedure pAfterOpen(DataSet : TDataSet);
    function fConfirmaProgress(cxProgress: TcxProgressBar): Boolean;
    function fGetSqlConf(AStrField: String; blnResultadoAs: Boolean = True): String;
    procedure pCarregaNota;
    function fGetSqlConfSimplificada(AStrField: String;
      blnResultadoAs: Boolean = true): String;
  public
    class procedure pEfetivaMovimentoConferencia(stlGerEle : TStringList);
  protected
     function fGetOrderBy: String; override;
     function fGetSql(blnLike: Boolean): String; override;
     function fSetParametros: Boolean; override;
     procedure pAddListaQuery; Override;
     function fValidaCampos(Sender : TWinControl; blnBuscaPorChave: Boolean) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untFuncoesConsulta,
  untEntMerEfeMovFisDatas, untGravando, untEfetivaMovimentoFiscal;

{ TfrmEntMercadoriasEfetivaMovFiscal }

procedure TfrmEntMercadoriasEfetivaMovFiscal.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fConfirmaProgress;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
    fAbreConsulta;
  End;

end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.edtCodTraExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodTra, edtNomTra, arrCodTra, fRetNomTransportadora, nil, 'da Transportadora');
end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrCodTra, False) then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmEntMercadoriasEfetivaMovFiscal.fGetOrderBy: String;
begin
  Result := Result + ' ORDER BY G.GER_DTADOC, FOR_NOMFOR ';
end;

function TfrmEntMercadoriasEfetivaMovFiscal.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT G.AUTOINCREM, ';
  Result := Result + '        G.GER_NUMDOC, ';
  Result := Result + '        G.GER_ESPDOC, ';
  Result := Result + '        G.GER_SERIE_, ';
  Result := Result + '        G.GER_CODFOR, ';
  Result := Result + '        G.GER_CODEMP, ';
  Result := Result + '        FOR_NOMFOR,   ';
  Result := Result + '        G.GER_DTADOC, ';
  Result := Result + '        G.GER_TOTPRO, ';
  Result := Result + '        G.GER_VLRCON, ';
  Result := Result + '        G.GER_CODTRA, ';
  Result := Result + fGetSqlConf('GER_OPECON') + ',';
  Result := Result + fGetSqlConf('GER_DTACON') + ',';
  Result := Result + '        TRA_NOMTRA,   ';
  Result := Result + '        CAST(NULL AS DATE) AS DTASFO, ';
  Result := Result + '        CAST(NULL AS DATE) AS DTACTR, ';
  Result := Result + '        CAST(NULL AS DATE) AS DTACEM, ';
  Result := Result + '        CAST("" AS CHAR(20)) AS NATOPE, ';
  Result := Result + '        CURRENT_DATE AS DTAENT, ';
  Result := Result + '        "N" AS EFETIVADA, ';
  Result := Result + fGetSqlConf('GER_IDEDIG', False) + ' AS GER_IDEDIG, ';
  Result := Result + fGetSqlConf('AUTOINCREM', False) + ' AS GER_AUTINC, ';
  Result := Result + fGetSqlConf('GER_DTACON', False) + ' AS GER_DTACON, ';
  Result := Result + fGetSqlConfSimplificada('AUX_ENTSIM', False) + ' AS AUX_ENTSIM ';
  Result := Result + ' FROM MOVGER G       ';
  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  Result := Result + ' LEFT  JOIN CADTRA ON TRA_CODTRA = GER_CODTRA ';

  if Assigned(FGerEle) And (Not FblnMOVGER) Then
  Begin
    Result := Result + ' INNER JOIN GERELE L ON L.GER_DOCENT = G.GER_NUMDOC ';
    Result := Result + '                    AND L.GER_ESPENT = G.GER_ESPDOC ';
    Result := Result + '                    AND L.GER_EMPENT = G.GER_CODEMP ';
    Result := Result + '                    AND L.GER_CODFOR = G.GER_CODFOR ';
  End;

  Result := Result + ' WHERE G.GER_CODEMP = :CODEMP ';
  Result := Result + '   AND G.GER_DTAENT IS NULL   ';
  if Assigned(FGerEle) And FblnMOVGER Then
    Result := Result + '   AND G.AUTOINCREM IN (' + fCommaText(FGerEle, True) +  ')'
  Else If Assigned(FGerEle) And (Not FblnMOVGER) Then
    Result := Result + '   AND L.AUTOINCREM IN (' + fCommaText(FGerEle, True) +  ')';

  Result := Result + fStrLocate(edtCodFor, arrCodFor, 'G.GER_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodTra, arrCodTra, 'G.GER_CODTRA', 'CODTRA');

end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  objFechamentoEstoque := TFechamentoEstoque.Create(Self);
  objFechamentoFiscal  := TFechamentoFiscal.Create(Self);

  blnSempreRelerBanco := False;
  FGerEle := Nil;
  FblnMOVGER := False;
end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.FormShow(Sender: TObject);
begin
  inherited;
  if Assigned(FGerEle) Then
    pCarregaNota;
end;

function TfrmEntMercadoriasEfetivaMovFiscal.fSetParametros: Boolean;
  Var
    strCodFor : String;
begin
  Result := Inherited;
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  pSetaParam(edtCodFor.Text, arrCodFor, strCodFor, 'CODFOR', qryConsulta);
  pSetaParam(edtCodTra.Text, arrCodTra, strCodFor, 'CODTRA', qryConsulta);

  cdsConsulta.AfterOpen := pAfterOpen;
end;

function TfrmEntMercadoriasEfetivaMovFiscal.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodFor) Then
    Begin
      pDesmarcaLista(edtCodFor, arrCodFor);
    End
    Else
    If (Sender = edtCodTra) Then
    Begin
      pDesmarcaLista(edtCodTra, arrCodTra);

      If blnBuscaPorChave Then
      Begin
        fAbreConsulta;
        Result := Not cdsConsulta.IsEmpty;
        If not Result Then
          pMensagemOK('Sem dados para exibir!');
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.pAddListaQuery;
begin
  inherited;
  pSetEnabled;

  If fInLista Then
  Begin
    Try
      pCriarFormularios(TfrmEntMerEfeMovFisDatas, frmEntMerEfeMovFisDatas);

      If cdsConsulta.FieldByName('DTASFO').AsDateTime = 0 Then
        frmEntMerEfeMovFisDatas.mskDtaSFo.Clear
      Else
        frmEntMerEfeMovFisDatas.mskDtaSFo.Text := FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('DTASFO').AsDateTime);

      If cdsConsulta.FieldByName('DTACTR').AsDateTime = 0 Then
        frmEntMerEfeMovFisDatas.mskDtaCTr.Clear
      Else
        frmEntMerEfeMovFisDatas.mskDtaCTr.Text := FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('DTACTR').AsDateTime);

      If cdsConsulta.FieldByName('DTACEM').AsDateTime = 0 Then
        frmEntMerEfeMovFisDatas.mskDtaCEm.Clear
      Else
        frmEntMerEfeMovFisDatas.mskDtaCEm.Text := FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('DTACEM').AsDateTime);

      If cdsConsulta.FieldByName('DTAENT').AsDateTime = 0 Then
        frmEntMerEfeMovFisDatas.mskDtaEnt.Clear
      Else
        frmEntMerEfeMovFisDatas.mskDtaEnt.Text := FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('DTAENT').AsDateTime);

      frmEntMerEfeMovFisDatas.strNUMDOC := cdsConsulta.FieldByName('GER_NUMDOC').AsString;
      frmEntMerEfeMovFisDatas.strESPDOC := cdsConsulta.FieldByName('GER_ESPDOC').AsString;
      frmEntMerEfeMovFisDatas.strSERIE_ := cdsConsulta.FieldByName('GER_SERIE_').AsString;
      frmEntMerEfeMovFisDatas.strCODFOR := cdsConsulta.FieldByName('GER_CODFOR').AsString;
      frmEntMerEfeMovFisDatas.strCODEMP := cdsConsulta.FieldByName('GER_CODEMP').AsString;
      frmEntMerEfeMovFisDatas.pCarregaNaturezaOperacao;

      if (frmEntMerEfeMovFisDatas.ShowModal = mrOk) then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('DTASFO').AsDateTime := StrToDateDef(frmEntMerEfeMovFisDatas.mskDtaSFo.Text, 0);
        cdsConsulta.FieldByName('DTACTR').AsDateTime := StrToDateDef(frmEntMerEfeMovFisDatas.mskDtaCTr.Text, 0);
        cdsConsulta.FieldByName('DTACEM').AsDateTime := StrToDateDef(frmEntMerEfeMovFisDatas.mskDtaCEm.Text, 0);
        cdsConsulta.FieldByName('DTAENT').AsDateTime := StrToDateDef(frmEntMerEfeMovFisDatas.mskDtaEnt.Text, 0);
        cdsConsulta.FieldByName('NATOPE').AsString   := frmEntMerEfeMovFisDatas.AutoincremNaturezaOperacao;
        cdsConsulta.Post;
      End
      Else
        pAddListaQuery; // Desmarca

    Finally
      FreeAndNil(frmEntMerEfeMovFisDatas);
    End;
  End;

end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(cdsConsulta.FieldByName('GER_TOTPRO')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';
end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.pCarregaNota;
var
  qryAux: TUniQuery;
begin
  If Not Assigned(FGerEle) Then
    Exit;

  If fEmptyStr(fCommaText(FGerEle, True)) Then
    Exit;

  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD ');
    qryAux.SQL.Add(' FROM GERELE ');
    qryAux.SQL.Add(' WHERE AUTOINCREM IN ('+ fCommaText(FGerEle, True) +')');
    qryAux.Open;
    FblnMOVGER := (qryAux.FieldByName('QTD').AsInteger = 0);
  finally
    FreeAndNil(qryAux);
  end;

  fAbreConsulta;
end;

class procedure TfrmEntMercadoriasEfetivaMovFiscal.pEfetivaMovimentoConferencia(stlGerEle: TStringList);
  Var
    frmEntMercadoriasEfetivaMovFiscal : TfrmEntMercadoriasEfetivaMovFiscal;
begin
  Try
    pCriarFormularios(TfrmEntMercadoriasEfetivaMovFiscal, frmEntMercadoriasEfetivaMovFiscal);
    With frmEntMercadoriasEfetivaMovFiscal Do
    Begin
      FGerEle := stlGerEle;
      pnlHeader.Visible := False;
      ShowModal;
    End;

  Finally
    FreeAndNil(frmEntMercadoriasEfetivaMovFiscal);
  End;

end;

procedure TfrmEntMercadoriasEfetivaMovFiscal.pSetEnabled;
begin
  btnConfirma.Enabled := (stlListSelecao.Count > 0) And (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0);
end;

function TfrmEntMercadoriasEfetivaMovFiscal.fConfirmaProgress(cxProgress : TcxProgressBar) : Boolean;
VAR   lNotaEletInfConf: TNotaEletInfConf;

Begin
  Result := True;
  With cdsConsulta Do
  Begin
    Try
      If Not objFechamentoEstoque.fVeSeTravaFechamentoEstoque(traMovimentacao, 0) Then
      Begin
        Result := False;
        Exit;
      End;

      If Not objFechamentoFiscal.fVeSeTravaFechamentoFiscal(trfMovimentacao, 0) Then
      Begin
        Result := False;
        Exit;
      End;

      DisableControls;
      First;

      cxProgress.pSetMax(RecordCount);

      Try

        While Not Eof Do
        Begin
          If fInLista and SameText(cdsConsulta.FieldByName('EFETIVADA').AsString, 'N') Then
          Begin
            If (cdsConsulta.FieldByName('DTAENT').AsDateTime = VS_Date) Or
               TFechamentoEstoque.fDataDeEntradaPermitida(cdsConsulta.FieldByName('DTAENT').AsDateTime) And
               TFechamentoFiscal.fDataFiscalPermitida(cdsConsulta.FieldByName('DTAENT').AsDateTime) Then
            Begin
              lNotaEletInfConf := TNotaEletInfConf.Create;
              Try
                lNotaEletInfConf.FEntSim := cdsConsulta.FieldByName('AUX_ENTSIM').AsString;
                lNotaEletInfConf.FMovGer := cdsConsulta.FieldByName('AUTOINCREM').AsString;
                lNotaEletInfConf.FAutInc := cdsConsulta.FieldByName('GER_AUTINC').AsString;
                lNotaEletInfConf.FDigEle := cdsConsulta.FieldByName('GER_IDEDIG').AsString;
                lNotaEletInfConf.FDtaCon := cdsConsulta.FieldByName('GER_DTACON').AsDateTime;

                TEfetivaMovimentoFiscal.pEfetiva(cdsConsulta.FieldByName('GER_NUMDOC').AsString,
                                                 cdsConsulta.FieldByName('GER_ESPDOC').AsString,
                                                 cdsConsulta.FieldByName('GER_SERIE_').AsString,
                                                 cdsConsulta.FieldByName('GER_CODFOR').AsString,
                                                 cdsConsulta.FieldByName('GER_CODEMP').AsString,
                                                 cdsConsulta.FieldByName('DTAENT').AsDateTime,
                                                 cdsConsulta.FieldByName('DTASFO').AsDateTime,
                                                 cdsConsulta.FieldByName('DTACTR').AsDateTime,
                                                 cdsConsulta.FieldByName('DTACEM').AsDateTime,
                                                 True,
                                                 cdsConsulta.FieldByName('NATOPE').AsString,
                                                lNotaEletInfConf );
              Finally
                FreeAndNil(lNotaEletInfConf);
              end;

              If Result Then
              Begin
                cdsConsulta.Edit;
                cdsConsulta.FieldByName('EFETIVADA').AsString := 'S';
                cdsConsulta.Post;
              End;

            End Else
            Begin
              Result := False;
              Break;
            End;

          End;

          Next;

          cxProgress.pStepBy;
        End;

        If Result Then
          pMensagemOK('Documento(s) efetivado(s) com sucesso!');


      Except
        On E : Exception Do
        Begin
          Result := False;
          pMensagensErro(e.message, 'TfrmEntMercadoriasEfetivaMovFiscal.fConfirmaProgress');
        End;

      End;

    Finally
      First;
      EnableControls;

      objFechamentoEstoque.pDestravaFechamentoEstoque(traMovimentacao);
      objFechamentoFiscal.pDestravaFechamentoFiscal(trfMovimentacao);

      If (not pnlHeader.Visible) and Result Then
        Self.Close;
    End;
  End;


End;

function TfrmEntMercadoriasEfetivaMovFiscal.fGetSqlConf(AStrField: String; blnResultadoAs: Boolean = True): String;
begin
  Result := '';
  Result := Result + '   (SELECT ' + AStrField + ' FROM GERELE ';
  Result := Result + '       WHERE GER_DOCENT = G.GER_NUMDOC   ';
  Result := Result + '         AND GER_ESPENT = G.GER_ESPDOC   ';
  Result := Result + '         AND GER_EMPENT = G.GER_CODEMP   ';
  Result := Result + '         AND B07_SERIE  = G.GER_SERIE_   ';
  Result := Result + '         AND GER_CODFOR = G.GER_CODFOR)  ';

  if blnResultadoAs then
    Result := Result + ' AS ' + AStrField;
end;

function TfrmEntMercadoriasEfetivaMovFiscal.fGetSqlConfSimplificada(AStrField: String; blnResultadoAs: Boolean = True): String;
begin
  Result := '';
  Result := Result + '   (SELECT AUXMOV.' + AStrField + ' FROM AUXMOV ';
  Result := Result + '       WHERE AUX_SEQGER = G.AUTOINCREM)  ';
  if blnResultadoAs then
    Result := Result + ' AS ' + AStrField;
end;

end.
