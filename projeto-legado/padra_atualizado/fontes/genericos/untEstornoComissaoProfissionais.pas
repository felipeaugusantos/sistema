unit untEstornoComissaoProfissionais;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, StdCtrls, Grids, DBGridCitel, DBGrids,
  EditFocus, MaskEditFocus, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, UniClientDataSet,
  Mask, AppEvnts, BitBtnLockedIncrem, frxClass, untFuncoes, untFuncoesGenerica,
  frxExportCSVTestabilidade, Datasnap.DBClient,untConsultas,untFuncoesConsulta,untTypesSistema,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, System.Variants;

type
  TfrmEstornoComissaoProfissionais = class(TfrmPaiSimples)
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    dtsComPro: TDataSource;
    pnlFundoGeral: TPanel;
    pnlCabecalho: TPanel;
    pnlGrid: TPanel;
    pnlTotais: TPanel;
    dbgComissoes: TDBGridCitel;
    pnlTotal: TPanel;
    Label23: TLabel;
    lblNumReg: TLabel;
    edtTotNroCom: TEditFocus;
    edtTotValTot: TEditFocus;
    pnlMenuBtn: TPanel;
    pnlInformativos: TPanel;
    pnlSelecionados: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtSelNroCom: TEditFocus;
    edtSelValTot: TEditFocus;
    Label6: TLabel;
    edtProfissional: TEditFocus;
    Bevel1: TBevel;
    Label5: TLabel;
    edtCodCom: TEditFocus;
    edtDtaCad: TEditFocus;
    Label1: TLabel;
    edtCreDeb: TEditFocus;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    Label7: TLabel;
    lblValComiss: TLabel;
    Label10: TLabel;
    edtValVen: TEditFocus;
    edtValCom: TEditFocus;
    edtCli: TEditFocus;
    Label11: TLabel;
    Label12: TLabel;
    edtEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    Label13: TLabel;
    lblTotComiss: TLabel;
    edtSelTotCom: TEditFocus;
    cdsRecibo: TUniClientDataSet;
    cdsReciboNOMREC: TStringField;
    cdsReciboVALREC: TFloatField;
    cdsReciboVALEXT: TStringField;
    cdsReciboHISREC: TStringField;
    cdsReciboNOMASS: TStringField;
    cdsReciboNROVIA: TIntegerField;
    cdsReciboDTAREC: TStringField;
    cdsReciboVALTOT: TFloatField;
    cdsReciboVALIMP: TFloatField;
    cdsReciboNOMLIB: TStringField;
    cdsReciboNROREC: TStringField;
    cdsReciboNUMPIS: TStringField;
    cdsReciboMARCA_: TStringField;
    BitBtn1: TBitBtnLocked;
    button: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    Button23: TBitBtnLocked;
    btnSaida: TBitBtnLocked;
    btnMarTds: TBitBtnLocked;
    btnDesTds: TBitBtnLocked;
    btnLocPro: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    cdsReciboHISREC_02: TStringField;
    edtCodPro: TEditFocus;
    btnConsultar: TBitBtnLocked;
    Label26: TLabel;
    edtComPro: TEditFocus;
    cdsReciboHISREC_03: TStringField;
    procedure FormShow(Sender: TObject);
    procedure dbgComissoesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgComissoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgComissoesDblClick(Sender: TObject);
    procedure btnMarTdsClick(Sender: TObject);
    procedure btnDesTdsClick(Sender: TObject);
    procedure btnLocProClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnSaidaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtCodProEnter(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FPais: TPais;
    strValorFiltro: String;
    strCampoFiltro: String;
    fltTotComSel: Double;
    arrSel: TConsultasArray;
    stlLisSel: TStringList;
    intRecAtu: Integer;

    cdsComPro: TUniClientDataSet;
    blnMarcando: Boolean;

    function fEstornarComissao: Boolean;
    function ValidaEstorno: Boolean;
    function LancarEstorno: Boolean;
    procedure ExcluirContasAPagar(ACadPag : TUniQuery);
    procedure ExcluirCTPCOM;

    procedure pLoadDados(blnLimit : Boolean = False);
    function  GetSql: String;
    procedure pSelecionaDocumento;
    procedure pSetMarDesAll(blnMarcar: Boolean);
    procedure pAtualizaTotais;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pAfterPost(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure MarcaRegistros;
    procedure DesmarcaRegistros;
    procedure EstornoAnalitico(Var ACtpCom : TUniQuery);
    procedure TemporarioComContasAPagar(Var ATemp : TUniQuery);
    procedure ShowManutencao;
  public
    { Public declarations }
    VS_strTCoProInterna: String;
    LChamouManutencao  : Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  end;

implementation

uses SysUtils, Graphics, strUtils, DateUtils, UniDataSetProvider,
  untfuncoesSimples, untBuscaComissao, untPai, untBaixaProfiss, untCadPag,
  untCfgRel, untValorPorExtenso,untDigInformacoesRPA, untLogCom;

{$R *.dfm}

function TfrmEstornoComissaoProfissionais.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtComPro) Then
  Begin
    If fEmptyStr(edtComPro.Text) Then
    Begin
      fMensagem('', 'O Código da comissão deve ser preenchido!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodPro) Then
  Begin
    If fEmptyStr(edtCodPro.Text) Then
    Begin
      fMensagem('', 'Profissional precisa ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If Not fEmptyStr(fRetNomeProfissional(edtCodPro.Text)) And fEmptyStr(edtProfissional.Text) Then
    Begin
      If Not fLock_Unlock('COMPRO' +edtCodPro.Text, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Profissional com o código: '+edtCodPro.Text+' está sendo utilizado por outra estação: ' + fGetHostLock('COMPRO'+  edtCodPro.Text), ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmEstornoComissaoProfissionais.GetSql: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COM_CODCOM AS "Código",       ';
  strSQL := strSQL + '  COM_DTACAD AS "Dta Cadastro", ';
  strSQL := strSQL + '  COM_CREDEB AS "C_D",          ';
  strSQL := strSQL + '  COM_NUMDOC AS "Documento",    ';
  strSQL := strSQL + '  COM_ESPDOC AS "Espécie",      ';
  strSQL := strSQL + '  COM_CODEMP AS "Empresa",      ';
  strSQL := strSQL + '  COM_VRVEND AS "Vr Venda",     ';

  If VS_strTCoProInterna = '3' Then
    strSQL := strSQL + '  COM_VRCOMI AS "Qtd Pontos",   '
  Else
    strSQL := strSQL + '  COM_VRCOMI AS "Vr Comissão",   ';

  strSQL := strSQL + '  CLI_NOMCLI AS "Nome Cliente", ';
  strSQL := strSQL + '  COMPRO.AUTOINCREM AS "AUTOINCREM", ';
  strSQL := strSQL + '  "N" AS MARDES,  ';

  strSQL := strSQL + '  CTPCOM.CTP_NUMDUP, ';
  strSQL := strSQL + '  CTPCOM.CTP_PARCEL, ';
  strSQL := strSQL + '  CTPCOM.CTP_SERIE_, ';
  strSQL := strSQL + '  CTPCOM.CTP_CODFOR, ';
  strSQL := strSQL + '  CTPCOM.CTP_CODEMP  ';

  strSQL := strSQL + 'FROM      ';
  strSQL := strSQL + '  COMPRO  ';
  strSQL := strSQL + '  LEFT JOIN CTPCOM ON (CTPCOM.CTP_COMPRO = COMPRO.AUTOINCREM) ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON (CLI_CODCLI = COM_CODCLI) ';
  strSQL := strSQL + '  LEFT JOIN CADDIV ON (DIV_CODDIV = COM_CODPRO) ';
  strSQL := strSQL + 'WHERE     ';

  Result := strSQL;
end;

function TfrmEstornoComissaoProfissionais.LancarEstorno: Boolean;
  Var
    LCtpCom : TUniQuery;
    LSql    : String;
    intCont : Integer;
Begin
  Try
    LCtpCom := fCriaQuery;

    LSql := LSql + 'SELECT                    ';
    LSql := LSql + '  *                       ';
    LSql := LSql + 'FROM                      ';
    LSql := LSql + '  CTPCOM                  ';
    LSql := LSql + 'WHERE CTP_COMPRO IN (     ';

    For intCont := 0 To stlLisSel.Count -1 Do
    Begin
       LSql := LSql + QuotedStr(stlLisSel[intCont]);
      If intCont + 1 < stlLisSel.Count Then
        LSql := LSql + ',';
    End;

    LSql := LSql + ')';

    Try
      LCtpCom.Close;
      LCtpCom.Sql.Clear;
      LCtpCom.Sql.Add(LSql);
      LCtpCom.Open;

      If Not LCtpCom.IsEmpty Then
      Begin
        ExcluirContasAPagar(LCtpCom);

        Try
          LCtpCom.First;
          While Not LCtpCom.Eof Do
          Begin
            fVerificaIntegridade(Self.Name, 'CTPCOM', LCtpCom); // aqui grava a DEL_CTPCOM
            LCtpCom.Next;
          End;
        Except
          On E : Exception Do
          Begin
            Exit(False);
          End;
        End;

        ExcluirCTPCOM;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.LancarEstorno]');
      End;
    End;
  Finally
    FreeAndNil(LCtpCom);
  End;
End;

procedure TfrmEstornoComissaoProfissionais.MarcaRegistros;
  Var
    LCtpCom : TUniQuery;
    LSql    : String;
    intIndex : Integer;
Begin
  Try
    LCtpCom := fCriaQuery;

    LSql := LSql + 'SELECT                     ';
    LSql := LSql + '  *                        ';
    LSql := LSql + 'FROM                       ';
    LSql := LSql + '  CTPCOM                   ';
    LSql := LSql + 'WHERE CTP_COMPRO = :COMPRO ';

    Try
      LCtpCom.Close;
      LCtpCom.Sql.Clear;
      LCtpCom.Sql.Add(LSql);
      LCtpCom.ParamByName('COMPRO').AsString := cdsComPro.FieldByName('AUTOINCREM').AsString;
      LCtpCom.Open;

      If Not LCtpCom.IsEmpty Then
      Begin
        EstornoAnalitico(LCtpCom);
        LCtpCom.First;
        While Not LCtpCom.Eof  Do
        Begin
          If cdsComPro.Locate('AUTOINCREM', VarArrayOf([LCtpCom.FieldByName('CTP_COMPRO').AsString]), []) Then
          Begin
            cdsComPro.Edit;
            cdsComPro.FieldByName('MARDES').AsString := 'S';
            cdsComPro.Post;
            If Not stlLisSel.Find(cdsComPro.FieldByName('AUTOINCREM').AsString,intIndex) Then
              stlLisSel.Add(cdsComPro.FieldByName('AUTOINCREM').AsString);
          End;
          LCtpCom.Next;
        End;
      End
      Else
      Begin
        cdsComPro.Edit;
        cdsComPro.FieldByName('MARDES').AsString := 'S';
        cdsComPro.Post;
        If Not stlLisSel.Find(cdsComPro.FieldByName('AUTOINCREM').AsString,intIndex) Then
          stlLisSel.Add(cdsComPro.FieldByName('AUTOINCREM').AsString);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.MarcaRegistros]');
      End;
    End;
  Finally
    FreeAndNil(LCtpCom);
  End;
End;

procedure TfrmEstornoComissaoProfissionais.EstornoAnalitico(var ACtpCom: TUniQuery);
  Var
    LTabela : TUniQuery;
    LSql    : String;
Begin
  Try
    LTabela := fCriaQuery;

    LSql := '';
    LSql := LSql + 'SELECT                      ';
    LSql := LSql + '  *                         ';
    LSql := LSql + 'FROM                        ';
    LSql := LSql + '  CTPCOM                    ';
    LSql := LSql + 'WHERE CTP_NUMDUP = :NUMDUP  ';
    LSql := LSql + '  AND CTP_PARCEL = :PARCEL  ';
    LSql := LSql + '  AND CTP_SERIE_ = :SERIE_  ';
    LSql := LSql + '  AND CTP_CODFOR = :CODFOR  ';
    LSql := LSql + '  AND CTP_CODEMP = :CODEMP  ';

    Try

      LTabela.Close;
      LTabela.Sql.Clear;
      LTabela.Sql.Add(LSql);
      LTabela.ParamByName('NUMDUP').AsString := ACtpCom.FieldByName('CTP_NUMDUP').AsString;
      LTabela.ParamByName('PARCEL').AsString := ACtpCom.FieldByName('CTP_PARCEL').AsString;
      LTabela.ParamByName('SERIE_').AsString := ACtpCom.FieldByName('CTP_SERIE_').AsString;
      LTabela.ParamByName('CODFOR').AsString := ACtpCom.FieldByName('CTP_CODFOR').AsString;
      LTabela.ParamByName('CODEMP').AsString := ACtpCom.FieldByName('CTP_CODEMP').AsString;
      LTabela.Open;

      ACtpCom := LTabela;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.ExcluirContasAPagar]');
      End;
    End;

  Finally
    //FreeAndNil(LTabela);
  End;

End;

procedure TfrmEstornoComissaoProfissionais.ExcluirContasAPagar(ACadPag : TUniQuery);
  Var
    LTabela : TUniQuery;
    LSql    : String;
Begin
  Try
    LTabela := fCriaQuery;

    LSql := '';
    LSql := LSql + 'SELECT                      ';
    LSql := LSql + '  *                         ';
    LSql := LSql + 'FROM                        ';
    LSql := LSql + '  CADPAG                    ';
    LSql := LSql + 'WHERE CTP_NUMDUP = :NUMDUP  ';
    LSql := LSql + '  AND CTP_PARCEL = :PARCEL  ';
    LSql := LSql + '  AND CTP_SERIE_ = :SERIE_  ';
    LSql := LSql + '  AND CTP_CODFOR = :CODFOR  ';
    LSql := LSql + '  AND CTP_CODEMP = :CODEMP  ';

    Try
      ACadPag.First;
      While Not ACadPag.Eof Do
      Begin
        LTabela.Close;
        LTabela.Sql.Clear;
        LTabela.Sql.Add(LSql);
        LTabela.ParamByName('NUMDUP').AsString := ACadPag.FieldByName('CTP_NUMDUP').AsString;
        LTabela.ParamByName('PARCEL').AsString := ACadPag.FieldByName('CTP_PARCEL').AsString;
        LTabela.ParamByName('SERIE_').AsString := ACadPag.FieldByName('CTP_SERIE_').AsString;
        LTabela.ParamByName('CODFOR').AsString := ACadPag.FieldByName('CTP_CODFOR').AsString;
        LTabela.ParamByName('CODEMP').AsString := ACadPag.FieldByName('CTP_CODEMP').AsString;
        LTabela.Open;

        If Not LTabela.IsEmpty Then
          fApagaDuplicataContasPagar(LTabela,Self.Name,'EXCLUSAO - ESTORNO COMISSAO DE PROFISSIONAIS');

        ACadPag.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.ExcluirContasAPagar]');
      End;
    End;

  Finally
    FreeAndNil(LTabela);
  End;

End;


procedure TfrmEstornoComissaoProfissionais.ExcluirCTPCOM;
  Var
    LCtpCom : TUniQuery;
    LSql    : String;
    intCont : Integer;
Begin
  Try
    LCtpCom := fCriaQuery;

    LSql := LSql + 'DELETE                    ';
    LSql := LSql + 'FROM                      ';
    LSql := LSql + '  CTPCOM                  ';
    LSql := LSql + 'WHERE CTP_COMPRO IN (     ';

    For intCont := 0 To stlLisSel.Count -1 Do
    Begin
       LSql := LSql + QuotedStr(stlLisSel[intCont]);
      If intCont + 1 < stlLisSel.Count Then
        LSql := LSql + ',';
    End;

    LSql := LSql + ')';

    Try
      LCtpCom.Close;
      LCtpCom.Sql.Clear;
      LCtpCom.Sql.Add(LSql);
      LCtpCom.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.ExcluirCTPCOM]');
      End;
    End;
  Finally
    FreeAndNil(LCtpCom);
  End;
End;

{***********************************}
{* CARREGA OS DADOS PARA DBGRID    *}
{********************************JB*}
procedure TfrmEstornoComissaoProfissionais.pLoadDados(blnLimit : Boolean);
  Var
    strSQL: String;
    qryComPro: TUniQuery;
    pvdComPro: TUniDataSetProvider;
begin

  strSql := GetSql;

  strSQL := strSQL + ' IF(IFNULL(COM_TCOPRO, "") = "", ' + QuotedStr(VS_strTCoProInterna) +
                                       ', COM_TCOPRO) = ' + QuotedStr(VS_strTCoProInterna) + ' AND ';

  strSQL := strSQL + '  COM_DTABAI IS NOT NULL AND  ';
  strSQL := strSQL + '  COM_CODPRO = :CODPRO  ';

  If Not blnLimit Then
    strSQL := strSQL + '  AND COM_CODCOM = :CODCOM '
  Else
    strSQL := strSQL + '  LIMIT 0 ';

  qryComPro := fCriaQuery(Self);


  qryComPro.Close;
  qryComPro.SQL.Clear;
  qryComPro.SQL.Add(strSQL);
  qryComPro.ParamByName('CODPRO').AsString := edtCodPro.Text;

  If Not blnLimit Then
  Begin
    qryComPro.ParamByName('CODCOM').AsString := edtComPro.Text;
  End;

  qryComPro.Open;

  If Not fEmptyStr(qryComPro.FieldByName('CTP_NUMDUP').AsString) Then
    TemporarioComContasAPagar(qryComPro);

  pvdComPro := TUniDataSetProvider.Create(Self);
  pvdComPro.DataSet := qryComPro;

  pSetaClient(qryComPro);

  If Assigned(cdsComPro) Then
    FreeAndNil(cdsComPro);

  cdsComPro := TUniClientDataSet.Create(Self);
  cdsComPro.SetProvider(pvdComPro);
  cdsComPro.Open;
  pSetaClient(cdsComPro);


  dtsComPro.DataSet := cdsComPro;
  cdsComPro.AfterPost := pAfterPost;
  cdsComPro.AfterScroll := pAtualizaDados;
  cdsComPro.OnFilterRecord := pFilterRecord;


  FreeAndNil(pvdComPro);
  FreeAndNil(qryComPro);

  (cdsComPro.FieldByName('Dta Cadastro') As TDateField).EditMask      := '99/99/9999';
  (cdsComPro.FieldByName('Vr Venda') As TFloatField).DisplayFormat    := '#,##0.00';
  (cdsComPro.FieldByName('Vr Venda') As TFloatField).EditFormat       := '#,##0.00';
  (cdsComPro.FieldByName('Vr Venda') As TFloatField).Alignment        := taRightJustify;

  If VS_strTCoProInterna = '3' Then
  Begin
    (cdsComPro.FieldByName('Qtd Pontos') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsComPro.FieldByName('Qtd Pontos') As TFloatField).EditFormat    := '#,##0.00';
    (cdsComPro.FieldByName('Qtd Pontos') As TFloatField).Alignment     := taRightJustify;
  End
  Else
  Begin
    (cdsComPro.FieldByName('Vr Comissão') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsComPro.FieldByName('Vr Comissão') As TFloatField).EditFormat    := '#,##0.00';
    (cdsComPro.FieldByName('Vr Comissão') As TFloatField).Alignment     := taRightJustify;
  End;

  dbgComissoes.Columns[02].Title.Caption := 'C/D';

  dbgComissoes.Columns[06].Title.Alignment := taRightJustify;
  dbgComissoes.Columns[07].Title.Alignment := taRightJustify;

  dbgComissoes.Columns[09].Visible := False;
  dbgComissoes.Columns[10].Visible := False;

  pAtualizaTotais;

end;


procedure TfrmEstornoComissaoProfissionais.FormShow(Sender: TObject);
begin
  inherited;

  If VS_strTCoProInterna = '3' Then
  Begin
    lblValComiss.Caption := 'Pontuação:';
    lblTotComiss.Caption := 'Total pontos:';
  End;

  pLoadDados(False);

  pSetFocus(edtCodPro);

  If LChamouManutencao Then
  Begin
    ShowManutencao;
  End;
end;

procedure TfrmEstornoComissaoProfissionais.dbgComissoesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  {**************************************************}
  {* ALTERA A COR PARA AS LINHAS MARCADAS NA DBGRID *}
  {***********************************************JB*}
  If cdsComPro.FieldByName('MARDES').AsString = 'S' Then
    If (intRecAtu = cdsComPro.RecNo) Then
      dbgComissoes.Canvas.Font.Color := clLime
    Else
      dbgComissoes.Canvas.Font.Color := clBlue;

  dbgComissoes.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

{************************************}
{* SELECIONA COMISSOES DA DBGRID    *}
{*********************************JB*}
procedure TfrmEstornoComissaoProfissionais.pSelecionaDocumento;
  Var
    BookMark : TBookmark;
    strValOld: String;
begin
  If (Not cdsComPro.IsEmpty) Then
  Begin
    BookMark := cdsComPro.GetBookmark;
    cdsComPro.DisableControls;
    Try
      strValOld := cdsComPro.FieldByName('MARDES').AsString;
      If (strValOld = 'N') Then
      Begin
        MarcaRegistros;
      End Else
      Begin
        DesmarcaRegistros;
      End;
    Finally
      cdsComPro.GotoBookmark(BookMark);
      cdsComPro.FreeBookmark(BookMark);
      cdsComPro.EnableControls;
    End;
  End;
end;

procedure TfrmEstornoComissaoProfissionais.dbgComissoesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = Vk_Return) Then
    pSelecionaDocumento
  Else If Key = VK_Escape Then
  Begin
    edtComPro.Clear;

    pLoadDados(True);

    edtComPro.Enabled := True;
    edtCodPro.Enabled := True;
    pSetFocus(edtCodPro);

  End;


end;

procedure TfrmEstornoComissaoProfissionais.DesmarcaRegistros;
  Var
    LCtpCom : TUniQuery;
    LSql    : String;
    intIndex : Integer;
Begin
  Try
    LCtpCom := fCriaQuery;

    LSql := LSql + 'SELECT                     ';
    LSql := LSql + '  *                        ';
    LSql := LSql + 'FROM                       ';
    LSql := LSql + '  CTPCOM                   ';
    LSql := LSql + 'WHERE CTP_COMPRO = :COMPRO ';

    Try
      LCtpCom.Close;
      LCtpCom.Sql.Clear;
      LCtpCom.Sql.Add(LSql);
      LCtpCom.ParamByName('COMPRO').AsString := cdsComPro.FieldByName('AUTOINCREM').AsString;
      LCtpCom.Open;

      If Not LCtpCom.IsEmpty Then
      Begin
        EstornoAnalitico(LCtpCom);
        LCtpCom.First;
        While Not LCtpCom.Eof  Do
        Begin
          If cdsComPro.Locate('AUTOINCREM', VarArrayOf([LCtpCom.FieldByName('CTP_COMPRO').AsString]), []) Then
          Begin
            cdsComPro.Edit;
            cdsComPro.FieldByName('MARDES').AsString := 'N';
            cdsComPro.Post;
            If stlLisSel.Find(cdsComPro.FieldByName('AUTOINCREM').AsString,intIndex) Then
              stlLisSel.Delete(intIndex);
          End;
          LCtpCom.Next;
        End;
      End
      Else
      Begin
        cdsComPro.Edit;
        cdsComPro.FieldByName('MARDES').AsString := 'N';
        cdsComPro.Post;
        If stlLisSel.Find(cdsComPro.FieldByName('AUTOINCREM').AsString,intIndex) Then
          stlLisSel.Delete(intIndex);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.DesmarcaRegistros]');
      End;
    End;
  Finally
    FreeAndNil(LCtpCom);
  End;
End;


procedure TfrmEstornoComissaoProfissionais.edtCodProEnter(Sender: TObject);
begin
  inherited;
  edtProfissional.Clear;
  if Not fEmptyStr(fRetNomeProfissional(edtCodPro.Text)) Then
    fLock_Unlock('COMPRO'+edtCodPro.Text, False);
end;

procedure TfrmEstornoComissaoProfissionais.edtCodProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPro, edtProfissional, arrSel, Nil, fRetNomeProfissional, 'do Profissional');
end;

procedure TfrmEstornoComissaoProfissionais.edtCodProKeyPress(Sender: TObject;var Key: Char);
begin
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodPro, edtProfissional, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodPro, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

function TfrmEstornoComissaoProfissionais.ValidaEstorno: Boolean;
  Var
    LCtpCom : TUniQuery;
    LSql    : String;
    intCont : Integer;
Begin

  Try
    LCtpCom := fCriaQuery;

    LSql := '';
    LSql := LSql + 'SELECT                                  ';
    LSql := LSql + '  B.CTP_DTABAI AS BAIXADO,              ';
    LSql := LSql + '  R.COM_DTABAI AS ESTORNADO,            ';
    LSql := LSql + '  CONCAT(A.CTP_NUMDUP,"-", A.CTP_PARCEL, "-", A.CTP_CODEMP, "-",A.CTP_CODFOR) AS DUPLICATA, ';
    LSql := LSql + '  CONCAT(P.CTP_NUMAGR,"-", P.CTP_CODFOR, "-", P.CTP_EMPAGR) AS AGRUPADO    ';
    LSql := LSql + 'FROM                                    ';
    LSql := LSql + '  CTPCOM A                              ';
    LSql := LSql + '    LEFT JOIN CADPAG B                  ';
    LSql := LSql + '    ON B.CTP_NUMDUP = A.CTP_NUMDUP      ';
    LSql := LSql + '    AND B.CTP_PARCEL = A.CTP_PARCEL     ';
    LSql := LSql + '    AND B.CTP_SERIE_ = A.CTP_SERIE_     ';
    LSql := LSql + '    AND B.CTP_CODFOR = A.CTP_CODFOR     ';
    LSql := LSql + '    AND B.CTP_CODEMP = A.CTP_CODEMP     ';
    LSql := LSql + '   LEFT JOIN DUPAGP P                   ';
    LSql := LSql + '    ON P.CTP_NUMDUP = A.CTP_NUMDUP      ';
    LSql := LSql + '    AND P.CTP_PARCEL = A.CTP_PARCEL     ';
    LSql := LSql + '    AND P.CTP_SERIE_ = A.CTP_SERIE_     ';
    LSql := LSql + '    AND P.CTP_CODFOR = A.CTP_CODFOR     ';
    LSql := LSql + '    AND P.CTP_CODEMP = A.CTP_CODEMP     ';
    LSql := LSql + '   LEFT JOIN COMPRO R                   ';
    LSql := LSql + '    ON R.AUTOINCREM = A.CTP_COMPRO      ';
    LSql := LSql + 'WHERE (                                 ';
    LSql := LSql + '    B.CTP_DTABAI IS NOT NULL            ';
    LSql := LSql + '    OR P.CTP_NUMDUP IS NOT NULL         ';
    LSql := LSql + '    OR R.COM_DTABAI IS NULL             ';
    LSql := LSql + '  )   AND A.CTP_COMPRO IN (             ';

    For intCont := 0 To stlLisSel.Count -1 Do
    Begin
      LSql := LSql + QuotedStr(stlLisSel[intCont]);
      If intCont + 1 < stlLisSel.Count Then
        LSql := LSql + ',';
    End;

    LSql := LSql + ')';

    Try
      LCtpCom.Close;
      LCtpCom.Sql.Clear;
      LCtpCom.Sql.Add(LSql);
      LCtpCom.Open;

      If (LCtpCom.RecordCount <= 0) Then Exit(True);

      If fEmptyStr(LCtpCom.FieldByName('ESTORNADO').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Existem comissões selecionadas que já sofreram Estorno! '+#13#10+
                              'Realize a pesquisa novamente.', ['&O k']);
        Exit(False);
      End;

      If Not fEmptyStr(LCtpCom.FieldByName('BAIXADO').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Foi Lançado o contas a pagar referente a essa comissão e o mesmo está baixado.'+#13#10+
                              'Favor realizar o estorno do contas a pagar primeiro!' +#13#10+
                              'Duplicata a ser estornada N°: '+ LCtpCom.FieldByName('DUPLICATA').AsString, ['&O k']);
        Exit(False);
      End;

      If Not fEmptyStr(LCtpCom.FieldByName('AGRUPADO').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Foi Lançado o contas a pagar referente a essa comissão e o mesmo está agrupado.'+#13#10+
                              'Favor realizar o desagrupamento do contas a pagar primeiro!' +#13#10+
                              'Duplicata a ser desagrupada N°: '+ LCtpCom.FieldByName('AGRUPADO').AsString, ['&O k']);
        Exit(False);
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.ValidaEstorno]');
      End;
    End;
  Finally
    FreeAndNil(LCtpCom);
  End;
End;

procedure TfrmEstornoComissaoProfissionais.dbgComissoesDblClick(
  Sender: TObject);
begin
  inherited;

  pSelecionaDocumento;

end;

procedure TfrmEstornoComissaoProfissionais.btnMarTdsClick(Sender: TObject);
begin
  inherited;

  pSetMarDesAll(True);

end;

{*******************************************}
{* MARCA E DESMAR TODOS OS ITENS DA DBGRID *}
{****************************************JB*}
procedure TfrmEstornoComissaoProfissionais.pSetMarDesAll(blnMarcar: Boolean);
begin
  If cdsComPro.IsEmpty Then
  Begin
    fMensagem('', 'É necessário ter registros para a consulta!', ['&Ok']);
    Exit;
  End;

  stlLisSel.Clear;
  blnMarcando := True;
  Try

    cdsComPro.DisableControls;

    cdsComPro.First;

    While Not cdsComPro.Eof DO
    Begin
      cdsComPro.Edit;
      cdsComPro.FieldByName('MARDES').AsString := IfThen(blnMarcar, 'S', 'N');
      cdsComPro.Post;

      If blnMarcar Then
        stlLisSel.Add(cdsComPro.FieldByName('AUTOINCREM').AsString);

      cdsComPro.Next
    End;

  Finally
    cdsComPro.First;
    cdsComPro.EnableControls;
    blnMarcando := False;
    pAtualizaTotais;
  End;

end;


procedure TfrmEstornoComissaoProfissionais.ShowManutencao;
begin
  If fVerificaCampos Then
  Begin
    edtCodProExit(edtCodPro);
    btnConsultar.Click;
  End;
end;

procedure TfrmEstornoComissaoProfissionais.TemporarioComContasAPagar(var ATemp: TUniQuery);
  Var
    LTabela : TUniQuery;
    LSql    : String;
Begin
  Try
    LTabela := fCriaQuery;

    LSql := GetSql;
    LSql := LSql + '      CTP_NUMDUP = :NUMDUP  ';
    LSql := LSql + '  AND CTP_PARCEL = :PARCEL  ';
    LSql := LSql + '  AND CTP_SERIE_ = :SERIE_  ';
    LSql := LSql + '  AND CTP_CODFOR = :CODFOR  ';
    LSql := LSql + '  AND CTP_CODEMP = :CODEMP  ';

    Try

      LTabela.Close;
      LTabela.Sql.Clear;
      LTabela.Sql.Add(LSql);
      LTabela.ParamByName('NUMDUP').AsString := ATemp.FieldByName('CTP_NUMDUP').AsString;
      LTabela.ParamByName('PARCEL').AsString := ATemp.FieldByName('CTP_PARCEL').AsString;
      LTabela.ParamByName('SERIE_').AsString := ATemp.FieldByName('CTP_SERIE_').AsString;
      LTabela.ParamByName('CODFOR').AsString := ATemp.FieldByName('CTP_CODFOR').AsString;
      LTabela.ParamByName('CODEMP').AsString := ATemp.FieldByName('CTP_CODEMP').AsString;
      LTabela.Open;

      ATemp := LTabela;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.TemporarioComContasAPagar]');
      End;
    End;

  Finally
    //FreeAndNil(LTabela);
  End;

End;


procedure TfrmEstornoComissaoProfissionais.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If fEstornarComissao Then
    Begin
      pMensagemOk('Estorno realizado com sucesso!');
      edtComPro.Clear;
      pLoadDados(True);
      edtComPro.Enabled := True;
      edtCodPro.Enabled := True;
      pSetFocus(edtCodPro);
    End;
  End;
end;

procedure TfrmEstornoComissaoProfissionais.btnConsultarClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    pLoadDados;

    If cdsComPro.IsEmpty Then
    Begin
      fMensagem('', 'Nenhum registro foi encontrado!', ['&Ok']);
      pSetFocus(edtCodPro);
    End
    Else
    Begin
      edtComPro.Enabled := False;
      edtCodPro.Enabled := False;
      pSetFocus(dbgComissoes);
    End;
  End;
end;

procedure TfrmEstornoComissaoProfissionais.btnDesTdsClick(Sender: TObject);
begin
  inherited;

  pSetMarDesAll(False);

end;

{*****************************************}
{* MOSTRA OS TOTAIS (SELECIONADAS\TODOS) *}
{**************************************JB*}
procedure TfrmEstornoComissaoProfissionais.pAfterPost(DataSet: TDataSet);
begin
  If not blnMarcando Then
    pAtualizaTotais;
end;

procedure TfrmEstornoComissaoProfissionais.pAtualizaDados(DataSet: TDataSet);
begin
  If blnMarcando Then
    Exit;
    
  {***********************************}
  {* CARREGA OS DADOS NAS EDITS      *}
  {********************************JB*}

  edtCodCom.Text := cdsComPro.FieldByName('Código').AsString;
  edtDtaCad.Text := FormatDateTime('dd/MM/yyyy', cdsComPro.FieldByName('Dta Cadastro').AsDateTime);
  edtCreDeb.Text := cdsComPro.FieldByName('C_D').AsString;
  edtNumDoc.Text := cdsComPro.FieldByName('Documento').AsString;
  edtEspDoc.Text := cdsComPro.FieldByName('Espécie').AsString;
  edtEmp.Text    := cdsComPro.FieldByName('Empresa').AsString;
  edtValVen.Text := FloatToStrF(cdsComPro.FieldByName('Vr Venda').AsFloat, ffFixed, 15, 2);
  If VS_strTCoProInterna =  '3' Then
    edtValCom.Text := FloatToStrF(cdsComPro.FieldByName('Qtd Pontos').AsFloat, ffFixed, 15, 2)
  Else
    edtValCom.Text := FloatToStrF(cdsComPro.FieldByName('Vr Comissão').AsFloat, ffFixed, 15, 2);
  edtCli.Text    := cdsComPro.FieldByName('Nome Cliente').AsString;

  intRecAtu := cdsComPro.RecNo;
end;

procedure TfrmEstornoComissaoProfissionais.pAtualizaTotais;
  Var
    fltValCom: Double;
    intQtdCom: Integer;

    BookMark : TBookmark;

    fltValComSel: Double;
    intQtdComSel: Integer;

begin
  intQtdCom := 0;
  fltValCom := 0;
  intQtdComSel := 0;
  fltValComSel := 0;
  fltTotComSel := 0;

  BookMark := cdsComPro.GetBookmark;


  cdsComPro.DisableControls;
  cdsComPro.First;
  While (Not cdsComPro.Eof) Do
  Begin
    If cdsComPro.FieldByName('C_D').AsString = 'C' Then
      fltValCom := fltValCom + cdsComPro.FieldByName('Vr Venda').AsFloat
    Else
      fltValCom := fltValCom - cdsComPro.FieldByName('Vr Venda').AsFloat;

    Inc(intQtdCom);

    If cdsComPro.FieldByName('MARDES').AsString = 'S' Then
    Begin
      If cdsComPro.FieldByName('C_D').AsString = 'C' Then
      Begin
        fltValComSel := fltValComSel + cdsComPro.FieldByName('Vr Venda').AsFloat;
        If VS_strTCoProInterna = '3' Then
          fltTotComSel := fltTotComSel + cdsComPro.FieldByName('Qtd Pontos').AsFloat
        Else
          fltTotComSel := fltTotComSel + cdsComPro.FieldByName('Vr Comissão').AsFloat;
      End Else
      Begin
        fltValComSel := fltValComSel - cdsComPro.FieldByName('Vr Venda').AsFloat;
        If VS_strTCoProInterna = '3' Then
          fltTotComSel := fltTotComSel - cdsComPro.FieldByName('Qtd Pontos').AsFloat
        Else
          fltTotComSel := fltTotComSel - cdsComPro.FieldByName('Vr Comissão').AsFloat;
      End;
      Inc(intQtdComSel);
    End;

    cdsComPro.Next;
  End;

  cdsComPro.EnableControls;


  cdsComPro.GotoBookmark(BookMark);
  cdsComPro.FreeBookmark(BookMark);

  edtTotNroCom.Text := FloatToStrF(intQtdCom, ffFixed, 15, 2);
  edtTotValTot.Text := FloatToStrF(fltValCom, ffFixed, 15, 2);

  edtSelNroCom.Text := FloatToStrF(intQtdComSel, ffFixed, 15, 2);
  edtSelValTot.Text := FloatToStrF(fltValComSel, ffFixed, 15, 2);

  edtSelTotCom.Text := FloatToStrF(fltTotComSel, ffFixed, 15, 2);

end;

procedure TfrmEstornoComissaoProfissionais.btnLocProClick(Sender: TObject);
begin
  inherited;

  If cdsComPro.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If (cdsComPro.Active) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsComPro.FindNext Then
      fMensagem('ATENÇÃO!', 'Nenhum registro encontrado!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmEstornoComissaoProfissionais.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmEstornoComissaoProfissionais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsComPro) Then
    FreeAndNil(cdsComPro);
end;

procedure TfrmEstornoComissaoProfissionais.FormCreate(Sender: TObject);
begin
  inherited;
  stlLisSel := TStringList.Create;
  stlLisSel.Sorted := True;
  FPais := fSetaPais;
  VS_strTCoProInterna := fCfgSis('TCOPRO');
end;

procedure TfrmEstornoComissaoProfissionais.btnIniBusClick(Sender: TObject);
  Var
    frmBuscaComissao : TfrmBuscaComissao;
begin
  inherited;

  If (Not cdsComPro.Active) Or
     (cdsComPro.IsEmpty)    Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    btnLocPro.Enabled := False;
    Exit;

  End;

  Try
    pCriarFormularios(TfrmBuscaComissao, frmBuscaComissao);
    frmBuscaComissao.ShowModal;

    If (Not fEmptyStr(frmBuscaComissao.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBuscaComissao.strValorFiltro;
      strCampoFiltro := frmBuscaComissao.strCampoFiltro;
      If Not cdsComPro.FindFirst Then
      Begin
        fMensagem('ATENÇÃO!', 'Nenhum registro encontrado!', ['&O k']);
      End;

      btnLocPro.Enabled := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEstornoComissaoProfissionais.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaComissao);

end;

procedure TfrmEstornoComissaoProfissionais.btnSaidaClick(Sender: TObject);
begin
  inherited;

  Close;

end;

procedure TfrmEstornoComissaoProfissionais.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6    : btnIniBus.Click;
    VK_F7    : btnLocPro.Click;
    VK_F8    : btnDesTds.Click;
    VK_F9    : btnMarTds.Click;
    VK_F10   : btnConfirma.Click;
    VK_ESCAPE: Begin
                 If edtComPro.Enabled Then
                   btnSaida.Click;
               End;
  End;

end;

function TfrmEstornoComissaoProfissionais.fEstornarComissao: Boolean;
  Var
    LComPro: TUniQuery;
    intCont: Integer;
Begin
  Result := True;

  If Not (stlLisSel.Count > 0) Then
  Begin
    fMensagem('','Selecione ao menos um documento !', ['&O k']);
    Exit(False);
  End;

  If Not ValidaEstorno Then
  Begin
    Exit(False);
  End;


  Try
    fStartTransaction;

    If Not LancarEstorno Then
    Begin
      Exit(False);
    End;

    LComPro := fCriaQuery;
    Try
      LComPro.Sql.Clear;
      LComPro.Sql.Add('UPDATE COMPRO');
      LComPro.Sql.Add('SET');
      LComPro.Sql.Add('  COM_DTABAI = NULL,');
      LComPro.Sql.Add('  COM_HORBAI = NULL,');
      LComPro.Sql.Add('  COM_OPEBAI = NULL ');
      LComPro.Sql.Add('WHERE');
      LComPro.Sql.Add('  AUTOINCREM IN (');

      For intCont := 0 To stlLisSel.Count -1 Do
      Begin
        LComPro.Sql.Add(QuotedStr(stlLisSel[intCont]));

        If intCont + 1 < stlLisSel.Count Then
          LComPro.Sql.Add(',');
      End;

      LComPro.Sql.Add(')');
      LComPro.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmEstornoComissaoProfissionais.fEstornarComissao]');
      End;
    End;

  Finally
    If Assigned(LComPro) Then FreeAndNil(LComPro);

    // Grava log
    If Result then
    begin

      Result := fGravalogComLst( stlLisSel, 'ESTORNO', self.name );

      If Result Then
         fCommit
      Else
         fRollBack;

    end;

  End;
End;

procedure TfrmEstornoComissaoProfissionais.FormDestroy(Sender: TObject);
begin
  if Not fEmptyStr(fRetNomeProfissional(edtCodPro.Text)) Then
    fLock_Unlock('COMPRO'+edtCodPro.Text, False);
  inherited;
  FreeAndNil(stlLisSel);
end;

end.
