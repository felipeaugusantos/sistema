{*****************************************}
{* frmModuloCons.qryCon001 -> CADCLI     *}
{**************************************MV*}

unit untFatConfPedidos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus,
  Grids, DBGridCitel, DBGrids, Menus, ComCtrls, Buttons, ExtCtrls, DB, {Qt,} untFuncFat,
  StrUtils;

type
  TfrmFatConfPedidos = class(TfrmPaiSimples)
    pnlAux2: TPanel;
    dbgDocumentos: TDBGridCitel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    btnItensDoc: TBitBtn;
    btnConfirma: TBitBtn;
    btnSairConf: TBitBtn;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label17: TLabel;
    edtQtdDoc: TEditFocus;
    edtTotLiq: TEditFocus;
    edtQtdDocSel: TEditFocus;
    edtTotLiqSel: TEditFocus;
    edtNomCli: TEditFocus;
    procedure btnSairConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensDocClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm: Boolean;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pCarregaCliente;

    procedure pCarregaItensDocumento;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pCalculaTotais;

    procedure pDeletaDocDesmarcados;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    fatVenda: TFatVenda;
  end;

var
  frmFatConfPedidos: TfrmFatConfPedidos;

implementation

uses untFuncoes, untfuncoesSimples, untModuloSPR, untModuloCons, untPesqAux, untModulo,
  untFatMostraProdConfirmacao, untModuloCadCli;

{$R *.dfm}

procedure TfrmFatConfPedidos.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatConfPedidos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If frmModuloCons.qryCon001.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    Sender.SetFocus;

end;

procedure TfrmFatConfPedidos.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

procedure TfrmFatConfPedidos.pCriaTemporaria;
  Var
    strSQL: String;
    strNumDoc: String;
    intQtdIte: Integer;
    strDocAnt: String;
    strEspAnt: String;
    intContador: Integer;
    fltVlrCon: Double;
begin

  pDeletaTemporaria;

  {*******************************************}
  {* PEGA OS PEDIDOS AINDA NÃO CONFIRMADOS   *}
  {* DO CLIENTE                              *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FGO_NUMDOC, ';
  strSQL := strSQL + '  FGO_ESPDOC, ';
  strSQL := strSQL + '  FGO_DTAENT, ';
  strSQL := strSQL + '  FGO_JAFATU, ';
  strSQL := strSQL + '  FGO_CODVEN, ';
  strSQL := strSQL + '  FGO_DESESP - FGO_DEESPB AS FGO_DESESP, ';
  strSQL := strSQL + '  FGO_VLRCON, ';
  strSQL := strSQL + '  FGO_CODS01, ';
  strSQL := strSQL + '  FGO_CODS02, ';
  strSQL := strSQL + '  FGO_CODS03, ';
  strSQL := strSQL + '  FGO_CODS04, ';
  strSQL := strSQL + '  FGO_CODS05, ';
  strSQL := strSQL + '  FGO_CODS06, ';
  strSQL := strSQL + '  FGO_DESS01, ';
  strSQL := strSQL + '  FGO_DESS02, ';
  strSQL := strSQL + '  FGO_DESS03, ';
  strSQL := strSQL + '  FGO_DESS04, ';
  strSQL := strSQL + '  FGO_DESS05, ';
  strSQL := strSQL + '  FGO_DESS06, ';
  strSQL := strSQL + '  FGO_VALS01 - FGO_VSE01B AS FGO_VALS01, ';
  strSQL := strSQL + '  FGO_VALS02 - FGO_VSE02B AS FGO_VALS02, ';
  strSQL := strSQL + '  FGO_VALS03 - FGO_VSE03B AS FGO_VALS03, ';
  strSQL := strSQL + '  FGO_VALS04 - FGO_VSE04B AS FGO_VALS04, ';
  strSQL := strSQL + '  FGO_VALS05 - FGO_VSE05B AS FGO_VALS05, ';
  strSQL := strSQL + '  FGO_VALS06 - FGO_VSE06B AS FGO_VALS06 ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATGOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FGO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  FGO_ESPDOC = "PD" AND ';
  strSQL := strSQL + '  FGO_JAFATU = FALSE AND ';
  strSQL := strSQL + '  FGO_CODCLI = :CODCLI ';

  With frmModuloSPR.qryGen003 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  {*******************************************}
  {* PEGA OS PRODUTOS REFERENTES AOS PEDIDOS *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FDO_NUMDOC, ';
  strSQL := strSQL + '  FDO_ESPDOC, ';
  strSQL := strSQL + '  FDO_CODCLI, ';
  strSQL := strSQL + '  (FDO_QTDITE - FDO_QTDBAI) * FDO_UNITAR AS FDO_VLRCON ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  FDO_PROEMB <> "S" AND ';
  strSQL := strSQL + '  FDO_JAFATU = FALSE AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  FDO_NUMDOC, FDO_ESPDOC ';

  {*****************************************}
  {* MOVDET                                *}
  {**************************************MV*}
  With frmModuloSPR.qryGen004 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  pAtualizaTemporaria;

  With frmModuloSPR.qryGen003 Do
  Begin

    {*****************************************}
    {* PROCESSA MOVGER                       *}
    {**************************************MV*}
    While Not Eof Do
    Begin

      intQtdIte := 0;
      strDocAnt := frmModuloSPR.qryGen004.FieldByName('FDO_NUMDOC').AsString;
      strEspAnt := frmModuloSPR.qryGen004.FieldByName('FDO_ESPDOC').AsString;

      {*****************************************}
      {* CALCULA QUANTIDADE DE ITENS NO DOC.   *}
      {**************************************MV*}
      fltVlrCon := 0.0;
      While (Not frmModuloSPR.qryGen004.Eof)                                        And
            (frmModuloSPR.qryGen004.FieldByName('FDO_NUMDOC').AsString = strDocAnt) And
            (frmModuloSPR.qryGen004.FieldByName('FDO_ESPDOC').AsString = strEspAnt) Do
      Begin
        fltVlrCon := fltVlrCon + frmModuloSPR.qryGen004.FieldByName('FDO_VLRCON').AsFloat;
        Inc(intQtdIte);
        frmModuloSPR.qryGen004.Next;
      End;

      {*****************************************}
      {* INSERE REGISTRO NA TEMPORARIA         *}
      {**************************************MV*}
      fatVenda.qryTemporariaConfirmacao.Append;
      strNumDoc := FieldByName('FGO_NUMDOC').AsString + IIF(FieldByName('FGO_JAFATU').AsInteger = 1, 'q', '');

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DTAENT').AsDateTime := FieldByName('FGO_DTAENT').AsDateTime;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString   := strNumDoc;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString   := FieldByName('FGO_ESPDOC').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString   := VS_strCodEmp;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString   := FieldByName('FGO_CODVEN').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat    := fltVlrCon;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESESP').AsFloat    := FieldByName('FGO_DESESP').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ITEDOC').AsInteger  := intQtdIte;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString   := IIF(FieldByName('FGO_JAFATU').AsInteger = 1, 'S', 'N');
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString   := 'D';

      For intContador := 1 To 6 Do
      Begin
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODS0' + IntToStr(intContador)).AsString := FieldByName('FGO_CODS0' + IntToStr(intContador)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESS0' + IntToStr(intContador)).AsString := FieldByName('FGO_DESS0' + IntToStr(intContador)).AsString;
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VALS0' + IntToStr(intContador)).AsFloat  := FieldByName('FGO_VALS0' + IntToStr(intContador)).AsFloat;
      End;

      fatVenda.qryTemporariaConfirmacao.Post;

      Next;

    End;
    fatVenda.qryTemporariaConfirmacao.First;

  End;

  frmModuloSPR.qryGen003.Close;
  frmModuloSPR.qryGen004.Close;

  pCalculaTotais;

end;

procedure TfrmFatConfPedidos.pDeletaTemporaria;
begin

  If (Not fTabelaExiste(fatVenda.strTabelaConfMi)) Then
    Exit;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ' + fatVenda.strTabelaConfMi);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatConfPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma             := False;
  blnFecharForm           := False;
  frmModuloCons.qryCon001 := frmModuloCadCli.qryCadCli;
end;

procedure TfrmFatConfPedidos.pCarregaCliente;
begin
  pPesquisaCadCli(frmModuloCadCli.qryCadCli, frmModuloCons.qryCon001, edtCodCli.Text);
  With frmModuloCons.qryCon001 Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmFatConfPedidos.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If fMensagem('', 'Abandona?', ['&Sim', '&Não']) = 1 Then
    Begin
      pDeletaTemporaria;
      Close;
    End;
  End
  Else If (Key = VK_Return) Then
  Begin
    pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
  End
  Else If (Key = VK_F5) Then
  Begin
    btnItensDoc.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmFatConfPedidos.pMarcaDocumento(blnMarcar: Boolean);
begin

  If blnMarcar Then
  Begin
    fatVenda.qryTemporariaConfirmacao.Edit;
    fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString := 'M';
    fatVenda.qryTemporariaConfirmacao.Post;
  End
  Else
  Begin
    fatVenda.qryTemporariaConfirmacao.Edit;
    fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString := 'D';
    fatVenda.qryTemporariaConfirmacao.Post;
  End;

  pCalculaTotais;
end;

procedure TfrmFatConfPedidos.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('TMP_MARDES').AsString = 'M' Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;
    End;

  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  
end;

procedure TfrmFatConfPedidos.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
end;

procedure TfrmFatConfPedidos.FormShow(Sender: TObject);
begin
  inherited;
  dbgDocumentos.DataSource := fatVenda.dtsTemporariaConfirmacao;
  edtCodCli.Text           := fatVenda.strCodCli;
  pCarregaCliente;
  pCriaTemporaria;

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If fatVenda.qryTemporariaConfirmacao.IsEmpty Then
  Begin
    blnFecharForm := True;
  End;
end;

procedure TfrmFatConfPedidos.pCalculaTotais;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
  strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  With frmModuloSPR.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    edtQtdDoc.Text := FieldByName('TOTDOC').AsString;
    edtTotLiq.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
  strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TMP_MARDES = "M" ';

  With frmModuloSPR.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    edtQtdDocSel.Text := FieldByName('TOTDOC').AsString;
    edtTotLiqSel.Text := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);

    Close;
  End;

end;

procedure TfrmFatConfPedidos.pCarregaItensDocumento;
  Var
    strSQL: String;
    fltTotGer: Double;
    fltDesEsp: Double;
    fltTotSer: Double;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FDO_CODITE AS CODITE, ';
  strSQL := strSQL + '  FDO_DESCRI AS DESCRI, ';
  strSQL := strSQL + '  FDO_UNIDAD AS UNIDAD, ';
  strSQL := strSQL + '  FDO_QTDITE AS QTDITE, ';
  strSQL := strSQL + '  FDO_UNITAR AS UNITAR, ';
  strSQL := strSQL + '  FDO_TOTITE AS TOTITE, ';
  strSQL := strSQL + '  FDO_DESESP AS DESESP, ';
  strSQL := strSQL + '  FDO_CLAFIS AS CLAFIS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_JAFATU = FALSE AND ';
  strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

  {*******************************************}
  {* TOTALIZA O SERVIÇO                      *}
  {****************************************MV*}
  With frmModuloSPR.qryGen003 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL + ' AND FDO_CODITE = :CODITE ');
    ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := VS_strIteSer;
    Open;

    fltTotGer := 0.0;
    fltDesEsp := 0.0;
    fltTotSer := 0.0;

    While Not Eof Do
    Begin
      fltTotSer := fltTotSer + FieldByName('TOTITE').AsFloat;
      Next;
    End;
    
  End;


  With frmModuloSPR.qryGen003 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL + ' AND FDO_CODITE <> :CODITE ');
    ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := fatVenda.strCodCli;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODITE').AsString := VS_strIteSer;
    Open;

    (FieldByName('QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

    While Not Eof Do
    Begin
      fltTotGer := fltTotGer + FieldByName('TOTITE').AsFloat;
      fltDesEsp := fltDesEsp + FieldByName('DESESP').AsFloat;
      Next;
    End;

    First;

    Try
      Application.CreateForm(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
      frmFatMostraProdConfirmacao.dbgItens.DataSource := frmModuloSPR.dtsGen003;
      frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', fltTotSer);
      frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
      frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', fltDesEsp);
      frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fltTotGer - fltDesEsp + fltTotSer);
      frmFatMostraProdConfirmacao.Caption             := frmFatMostraProdConfirmacao.Caption + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + ' - ' +
                                                                                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
      frmFatMostraProdConfirmacao.showModal;
    Finally
      FreeAndNil(frmFatMostraProdConfirmacao);
    End;
  End;

end;

procedure TfrmFatConfPedidos.btnItensDocClick(Sender: TObject);
begin
  inherited;

  pCarregaItensDocumento;
  dbgDocumentos.SetFocus;

end;

procedure TfrmFatConfPedidos.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If StrToInt(edtQtdDocSel.Text) <= 0 Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
    dbgDocumentos.SetFocus;
    Exit;
  End;

  If (fStrToFloat(edtTotLiqSel.Text) < 0.0) Then
  Begin
    fMensagem('', 'Não é possivel confirmar um valor negativo!', ['&O k']);
    dbgDocumentos.SetFocus;
    Exit;
  End;

  If fMensagem('', 'Confirma pedidos?', ['&Sim', '&Não']) = 1 Then
  Begin

    pDeletaDocDesmarcados;
    pAtualizaTemporaria;
    blnConfirma := True;
    Close;

  End;

end;

{*****************************************}
{* APAGA DOCUMENTOS QUE NAO ESTÃO SELE-  *}
{* CIONADOS                              *}
{**************************************MV*}
procedure TfrmFatConfPedidos.pDeletaDocDesmarcados;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
  strSQL := strSQL + 'WHERE TMP_MARDES <> "M" ';

  With frmModuloSPR.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;

end;

procedure TfrmFatConfPedidos.FormActivate(Sender: TObject);
begin
  inherited;

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If blnFecharForm Then
  Begin
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;
{  If fatVenda.qryTemporariaConfirmacao.IsEmpty Then
  Begin
    Self.Hide;
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;}

end;

end.

