unit untEntImportaNotaEletDivFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Uni,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untZClient, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmEntImportaNotaEletDivFiscal = class(TfrmPaiSimples)
    cxgXmlValDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgXmlValLevel1: TcxGridLevel;
    cxgXmlVal: TcxGridCitel;
    cxGridCitelDTAENI: TcxGridDBColumn;
    cxGridCitelSERIE_: TcxGridDBColumn;
    cxGridCitelNUMDOC: TcxGridDBColumn;
    cxGridCitelVALTOT: TcxGridDBColumn;
    cxGridCitelCODFOR: TcxGridDBColumn;
    cxGridCitelNOMFAN: TcxGridDBColumn;
    cxGridCitelNOMFOR: TcxGridDBColumn;
    pnlBottom: TPanel;
    btnImporta: TBitBtnLocked;
    btnAtualiza: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    procedure btnAtualizaClick(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure cxgXmlValDBTableViewCitelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    cdsXmlVal : TZClient;
    function fGetSQL : String;
    procedure pGravacao(strInformacao: String; intPosicao, intMaximo: Integer);
  public
    strAutoincrem : String;

    procedure pCriaCdsXmlVal;
    procedure pCarregaDados;

  end;

var
  frmEntImportaNotaEletDivFiscal: TfrmEntImportaNotaEletDivFiscal;

implementation

uses
  untFuncoesSimples, untEntNfeXml, untTValidaNFeCapa, untTypesSistema,
  untEntNFEDivergencias;

{$R *.dfm}

{ TfrmEntImportaNotaEletDivFiscal }

procedure TfrmEntImportaNotaEletDivFiscal.btnAtualizaClick(Sender: TObject);
begin
  inherited;
  pCarregaDados();
end;

procedure TfrmEntImportaNotaEletDivFiscal.pGravacao(strInformacao: String; intPosicao, intMaximo: Integer);
begin
  pnlInfo.Caption := strInformacao;
  pgbProgresso.Max := intMaximo;
  pgbProgresso.Position := intPosicao;
  Application.ProcessMessages;
End;

procedure TfrmEntImportaNotaEletDivFiscal.btnImportaClick(Sender: TObject);
  var
    objEntNfeXml: TNFeXml;
    objValidaNFeCapa : TValidaNFeCapa;
    cdsDadosFornec: TZClient;
    cdsDiverg: TZClient;
    strArquivo : String;
    blnSuspendeuGnre,
    blnPreGnre,
    blnCSTCadastro,
    blnConfirma: Boolean;
    qryDel : TUniQuery;
    strOpeLib : String;
    horLib: TTime;
begin
  if not btnImporta.Visible then
    exit;
  horLib := 0;
  strOpeLib := '';
  if (not cdsXmlVal.Active) or cdsXmlVal.isEmpty then
  begin
    pMensagemOk('Não existem xmls com divergência!');
    exit;
  end;

  Try
    pgbProgresso.Visible := True;
    blnConfirma := True;
    blnCSTCadastro := False;
    blnPreGnre := False;

    If (not DirectoryExists(fCfgSis('PATTMP', varString))) Or (fEmptyStr(fCfgSis('PATTMP', varString))) Then
    Begin
      fMensagem('', 'Informe um diretório válido na CFG_PATTMP', ['&OK']);
      Exit;
    End;

    strArquivo := IncludeTrailingPathDelimiter(fCfgSis('PATTMP', varString));
    strArquivo := strArquivo + cdsXmlVal.FieldByName('AUTOINCREM').AsString + '.xml';

    TBlobField(cdsXmlVal.FieldByName('ARQXML')).SaveToFile( strArquivo );

    objValidaNFeCapa := TValidaNFeCapa.Create();

    cdsDadosFornec := TZClient.Create(Self, TNFeXml.fSQLDadosFornec);
    cdsDadosFornec.fLeDados('TfrmEntImportaNotaEletDivFiscal.btnImportaClick');
    cdsDadosFornec.IndexFieldNames := 'CODFOR';

    objEntNfeXml := TNFeXml.Create(Self, True, tpeFinalidadeXML(cdsXmlVal.FieldByName('TIPXML').AsInteger) );
    objEntNfeXml.blnValidarXMLVal := False;
    objEntNfeXml.objValidaNFeCapa := objValidaNFeCapa;
    objEntNfeXml.onLogErro := Nil;//pLogErro;
    objEntNfeXml.OnGravando := pGravacao;
    objEntNfeXml.OnNaoEncontrouItem := Nil; //pItemNaoEncontrado;
    objEntNfeXml.OnAlteraClaIPI := Nil;//pAlteraClaIPI;

    objEntNfeXml.cdsDadosFornec := cdsDadosFornec;

    objEntNfeXml.frmGravandoNotas := Nil;//frmGravandoNotas;

    If objEntNfeXml.fCarregarDoArquivo(strArquivo, cdsDiverg) Then
    Begin

      If Assigned(cdsDiverg) Then
      Begin
        cdsDiverg.Filter   := 'MOSTRA = ' + QuotedStr('S');
        cdsDiverg.Filtered := True;

        If (Not cdsDiverg.IsEmpty) Then
        Begin
          Try
            pCriarFormularios(TfrmEntNFEDivergencias, frmEntNFEDivergencias);


            cdsDiverg.IndexFieldNames := 'FORNEC;NUMDOC;DESITE;CODITE;ELETRO';

            objValidaNFeCapa.pSetaValoresCorrigidos(TUniClientDataSet(cdsDiverg));

            frmEntNFEDivergencias.strAutIncXMLVAL := strAutoincrem;

            frmEntNFEDivergencias.cxgItensView.DataController.DataSource := cdsDiverg.dtsSource;

            frmEntNFEDivergencias.blnBloqueiaNFE := frmEntNFEDivergencias.fCalculaBloqueio;

            frmEntNFEDivergencias.rdgCSTCad.Visible := cdsDiverg.FieldByName('DIF_CODSIT').AsString = 'S';

            frmEntNFEDivergencias.ShowModal;

            //blnReprocessa := frmEntNFEDivergencias.blnReprocessar;

            blnConfirma    := frmEntNFEDivergencias.blnConfirma;


            strOpeLib := frmEntNFEDivergencias.strOpeLib;
            horLib := frmEntNFEDivergencias.HoraLiberacao;
            blnCSTCadastro := frmEntNFEDivergencias.rdgCSTCad.ItemIndex = 1;
            If blnConfirma Then
            Begin
              blnPreGnre := frmEntNFEDivergencias.fPreparaGNRE(blnSuspendeuGnre);
              blnConfirma := Not blnSuspendeuGnre;
            End;

          Finally
            FreeAndNil(frmEntNFEDivergencias);
          end;

        End;
      End;
    End;

    If blnConfirma Then
    Begin
      If objEntNfeXml.fGravarNotaFiscal(blnCSTCadastro, 0, blnPreGnre, cdsDiverg, strOpeLib, horLib) Then
      Begin
        objEntNfeXml.fRenomearArquivo;

        qryDel := fCriaQuery;
        qryDel.SQL.Text := 'DELETE FROM XMLVAL WHERE AUTOINCREM = :AUTINC ';
        qryDel.ParamByName('AUTINC').AsString := cdsXmlVal.FieldByName('AUTOINCREM').AsString;
        qryDel.ExecSQL;

        pCarregaDados;

        fMensagem('', 'Nota fiscal importada com sucesso!', ['&OK']);

        if not fEmptyStr(strAutoincrem) then
          Self.Close;

      End;
    End;

  Finally
    FreeAndNil(objEntNfeXml);
    FreeAndNil(objValidaNFeCapa);
    FreeAndNil(cdsDadosFornec);
    FreeAndNil(cdsDiverg);

    pgbProgresso.Visible := False;
    pnlInfo.Caption := '';
  End;
end;

procedure TfrmEntImportaNotaEletDivFiscal.cxgXmlValDBTableViewCitelKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    btnImportaClick(btnImporta);
end;

function TfrmEntImportaNotaEletDivFiscal.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT X.AUTOINCREM,         ';
  Result := Result + '        XML_DTAENI AS DTAENI, ';
  Result := Result + '        XML_SERIE_ AS SERIE_, ';
  Result := Result + '        XML_NUMDOC AS NUMDOC, ';
  Result := Result + '        XML_VALTOT AS VALTOT, ';
  Result := Result + '        XML_TIPXML AS TIPXML, ';
  Result := Result + '        FOR_CODFOR AS CODFOR, ';
  Result := Result + '        FOR_NOMFAN AS NOMFAN, ';
  Result := Result + '        FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '        XML_ARQXML AS ARQXML, ';
  Result := Result + '        XML_CODEMP AS CODEMP  ';
  Result := Result + ' FROM XMLVAL X                ';
  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = XML_CODFOR ';
  Result := Result + ' WHERE XML_CODEMP = ' + QuotedStr(VS_StrCodEmp);

  if not fEmptyStr(strAutoincrem) then
    Result := Result + '   AND X.AUTOINCREM = ' + QuotedStr(strAutoincrem);
end;

procedure TfrmEntImportaNotaEletDivFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  strAutoincrem := '';
end;

procedure TfrmEntImportaNotaEletDivFiscal.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F5: pCarregaDados();
  end;
end;

procedure TfrmEntImportaNotaEletDivFiscal.pCriaCdsXmlVal;
begin
  cdsXmlVal := TZClient.Create(Self, fGetSQL);
End;

procedure TfrmEntImportaNotaEletDivFiscal.FormShow(Sender: TObject);
begin
  inherited;

  btnAtualiza.Visible := fEmptyStr(strAutoincrem);

  cdsXmlVal := TZClient.Create(Self, fGetSQL);
  pCarregaDados;
  pSetFocus(btnAtualiza);
end;

procedure TfrmEntImportaNotaEletDivFiscal.pCarregaDados();
Begin
  If cdsXmlVal.Active Then
    cdsXmlVal.EmptyDataSet();

  cdsXmlVal.fAbreClient(True);

  if (Assigned(cdsXmlVal.FindField('VALTOT'))) then
    TFloatField(cdsXmlVal.FieldByName('VALTOT')).DisplayFormat := fMskDigitos(2);

  cxgXmlValDBTableViewCitel.DataController.DataSource := cdsXmlVal.dtsSource;
  cxgXmlValDBTableViewCitel.ApplyBestFit();

  cdsXmlVal.First;
  pSetFocus(cxgXmlVal);
End;

end.
