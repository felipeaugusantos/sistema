{***************************}
{* qryConEmp -> CADEMP     *}
{* qryConFor -> CADFOR     *}
{************************JB*}
unit untEstornoCtaPagar;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  EditFocus, Grids, DBGridCitel, DBGrids, DB, Menus, StrUtils, AppEvnts,
  UniDataSetProvider, UniClientDataSet, untEntPagtoAntecipado, BitBtnLockedIncrem, MemDS, DBAccess,
  Provider, frxClass, frxExportCSVTestabilidade, untTCadPag;

type
  TfrmEstornoCtaPagar = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtNumDup: TEditFocus;
    edtParcel: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtCodEmp: TEditFocus;
    edtCodFor: TEditFocus;
    pnlDados: TPanel;
    dbgDuplicatas: TDBGridCitel;
    pnlBotoesEstorno: TPanel;
    Label4: TLabel;
    edtSerie: TEditFocus;
    edtNomEmp: TEditFocus;
    edtNomFor: TEditFocus;
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;
    cpvDados: TUniDataSetProvider;
    qryDados: TUniQuery;
    btnConfirma: TBitBtnLocked;
    btnSairEst: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure dbgDuplicatasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairEstClick(Sender: TObject);
    procedure dbgDuplicatasDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDuplicatasDblClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    objPgoAnt: TEntPagtoAntecipado;

    strTabelaMovBan: String;
    intPrimSeqBai  : Integer;

    objLogCtp: TCadPag;

    procedure pGravaDelCadPag;
    procedure pCarregaEmpresa;
    procedure pCarregaFornecedor;
    procedure pLimpaCampos;
    procedure pCriaTemporaria;
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(strMarDes: String);
    procedure pConfirmaEstorno;
    procedure pEstornaDuplicataSimples;
    procedure pEstornaDuplicataResumoCaixa;
    procedure pEstornaDuplicataParcial;

    procedure pDeterminaModalidadeEstorno(strSeqCon: String;  fltValDup: Double;
                var fltValDin, fltValCar, fltChqVis, fltChqPre, fltOrdRec: Double);

    function fVerificaDuplicataPrincipal: Boolean;
    function fRetDuplicatasSelecionadas: Integer;
    function fEspecieRcx(intSeqCon: Integer): String;

    procedure pGravaLogCtp(strCodEmp : String = ''; strAutInc : string = ''; strTipoEstorno : string = '');
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnResCai: Boolean;
    strOpeRcx: String;
    dtaDtaCai: TDate;
  end;

var
  frmEstornoCtaPagar: TfrmEstornoCtaPagar;

implementation

uses untFuncoes, untFuncoesSimples, untPesqAux, untConsultas, untTypesSistema,
     untMovBan, untCadRcxx, untCadPag;

{$R *.dfm}

{ TfrmEstornoCtaPagar }

function TfrmEstornoCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O NUMERO DA DUPLICATA          *}
    {**************************************MV*}
    If (Sender = edtNumDup) Then
    Begin
      If fEmptyStr(edtNumDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Duplicata deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A PARCELA                      *}
    {**************************************MV*}
    Else If (Sender = edtParcel) Then
    Begin
    End

    {*****************************************}
    {* VALIDA O CODIGO DA EMPRESA            *}
    {**************************************MV*}
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaEmpresa;
          If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}
    Else If (Sender = edtCodFor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          pConfirmaEstorno;
        End;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEstornoCtaPagar.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmEstornoCtaPagar.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmEstornoCtaPagar.pConfirmaEstorno;
begin

  If Not fVerificaCampos Then
  Begin
    blnMudarFoco := False;
    Exit;
  End;

  pCriaTemporaria;

  intPrimSeqBai := cdsDados.FieldByName('CTP_SEQBAI').AsInteger;

  If cdsDados.RecordCount = 0 Then
  Begin
    fMensagem('', 'Não há duplicatas a serem estornadas!', ['&O k']);
    pSetFocus(edtNumDup);
    pLimpaCampos;
    blnMudarFoco := False;
  End

  Else If (blnResCai) And
          (cdsDados.FieldByName('CTP_DTAPAG').AsDateTime <> VS_Date) Then
  Begin
    fMensagem('', 'Estorno não permitido, o resumo de caixa somente estorna a duplicata quando a data de recebimento for a mesma do dia.' + #13#10 +
                  'Por favor, estornar pelo financeiro.', ['&Ok']);
    Exit;
  End
  
  Else If (Not blnRescai)                                    And
          (cdsDados.FieldByName('CTP_RESCAI').AsInteger = 1) And
          (cdsDados.FieldByName('CTP_DTAPAG').AsDateTime = VS_Date) Then
  Begin
    fMensagem('', 'Duplicata referente a PG. Faça o estorno pelo Resumo de Caixa!', ['&O k']);
    cdsDados.EmptyDataSet;
    pSetFocus(edtNumDup);
    pLimpaCampos;
    blnMudarFoco := False;
  End

 (*
  Else If objPgoAnt.fDuplicadaVinculada(cdsDados.FieldByName('AUTOINCREM').AsString, strNumDoc) Then
  Begin
    fMensagem('', 'Duplicata utilizada como pagamento antecipado da nota ' + strNumDoc + '.' + #13#10 +
                  'Para fazer o estorno é preciso cancelar a nota!', ['&O k']);
    cdsDados.EmptyDataSet;
    pSetFocus(edtNumDup);
    pLimpaCampos;
    blnMudarFoco := False;
  End *)

  Else If (cdsDados.RecordCount = 1) And (cdsDados.FieldByName('CTP_SEQBAI').AsInteger = 0) Then
  Begin

    If fMensagem('', 'Confirma estorno?', ['&Sim', '&Não']) = 1 Then
    Begin
      If Not (fEmptyStr(cdsDados.FieldByName('CTP_RCXCON').AsString)) And
         (cdsDados.FieldByName('CTP_RESCAI').AsInteger = 1) and
         (fEspecieRcx(cdsDados.FieldByName('CTP_RCXCON').AsInteger) = 'PG') Then
        pEstornaDuplicataResumoCaixa
      Else
        pEstornaDuplicataSimples;
    End;

    pSetFocus(edtNumDup);
    blnMudarFoco := False;
  End
  Else
  Begin
    pSetFocus(dbgDuplicatas);
    blnMudarFoco := False;
  End;
end;

procedure TfrmEstornoCtaPagar.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTP_CODCTA, ';
  strSQL := strSQL + '  CTP_NUMDUP AS NRODUP, ';
  strSQL := strSQL + '  CTP_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(CTP_NUMDUP, CTP_PARCEL) AS CTP_NUMDUP, ';
  strSQL := strSQL + '  CTP_RCXCON, ';
  strSQL := strSQL + '  CTP_RESCAI, ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  CTP_SEQBAI, ';
  strSQL := strSQL + '  CTP_SEQCON, ';
  strSQL := strSQL + '  CTP_CODFOR, ';
  strSQL := strSQL + '  CTP_CODEMP, ';
  strSQL := strSQL + '  CTP_SERIE_, ';
  strSQL := strSQL + '  CTP_CTABAI, ';
  strSQL := strSQL + '  CTP_OPEBAI, ';
  strSQL := strSQL + '  CTP_PORBAI, ';
  strSQL := strSQL + '  CTP_DOCBAI, ';
  strSQL := strSQL + '  CTP_DTAPAG, ';
  strSQL := strSQL + '  CTP_VALPAG, ';
  strSQL := strSQL + '  CTP_VALORI, ';
  strSQL := strSQL + '  CTP_VALJUR, ';
  strSQL := strSQL + '  CTP_VALDES, ';
  strSQL := strSQL + '  CTP_CODEVE, ';
  strSQL := strSQL + QuotedStr(strNomeTabela) + ' AS CTP_TABELA, ';
  strSQL := strSQL + '  "D" AS CTP_MARDES ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomeTabela;
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTP_DTAPAG IS NOT NULL ';

  strSQL := strSQL + IIF(fEmptyStr(edtSerie.Text), ' AND ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) ', ' AND CTP_SERIE_ = :SERIE_ ');
  strSQL := strSQL + IIF(fEmptyStr(edtNumDup.Text), '', ' AND CTP_NUMDUP = :NUMDUP ');
  strSQL := strSQL + IIF(fEmptyStr(edtParcel.Text), '', ' AND CTP_PARCEL = :PARCEL ');
  strSQL := strSQL + IIF(fEmptyStr(edtCodEmp.Text), '', ' AND CTP_CODEMP = :CODEMP ');
  strSQL := strSQL + IIF(fEmptyStr(edtCodFor.Text), '', ' AND CTP_CODFOR = :CODFOR ');

  If blnResCai Then
  Begin
    strSQL := strSQL + '  AND CTP_RESCAI  = 1 ';
    strSQL := strSQL + '  AND CTP_DTAPAG  = :DTAPAG ';
  End;

  If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (IFNULL(CTP_CODPOR, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + '  AND (IFNULL(CTP_PORBAI, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(CTP_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(edtSerie.Text)  Then ParamByName('SERIE_').AsString := edtSerie.Text;
    If Not fEmptyStr(edtNumDup.Text) Then ParamByName('NUMDUP').AsString := edtNumDup.Text;
    If Not fEmptyStr(edtParcel.Text) Then ParamByName('PARCEL').AsString := edtParcel.Text;
    If Not fEmptyStr(edtCodEmp.Text) Then ParamByName('CODEMP').AsString := edtCodEmp.Text;
    If Not fEmptyStr(edtCodFor.Text) Then ParamByName('CODFOR').AsString := edtCodFor.Text;

    If (BlnResCai) Then
      ParamByName('DTAPAG').AsDate := VS_Date;

    Open;

    pSetaClient(qryDados);

    cdsDados.Close;
    cdsDados.SetProvider(cpvDados);
    cdsDados.Open;

    (cdsDados.FieldByName('CTP_VALPAG') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

{******************************************}
{* strMarDes:                             *}
{* -> 'M': Marca                          *}
{* -> 'D': Desmarca                       *}
{* -> 'T': Desmarca Todas as relacionadas *}
{***************************************MV*}
procedure TfrmEstornoCtaPagar.pMarcaDuplicata(strMarDes: String);
  Var
    intRec: Integer;
begin
  intRec := 0;
  Try
    intRec := cdsDados.RecNo;
    cdsDados.DisableControls;

    cdsDados.Filter := 'CTP_NUMDUP = ' + QuotedStr(cdsDados.FieldByName('CTP_NUMDUP').AsString) + ' AND ' +
                       'CTP_CODEMP = ' + QuotedStr(cdsDados.FieldByName('CTP_CODEMP').AsString) + ' AND ' +
                       'CTP_CODFOR = ' + QuotedStr(cdsDados.FieldByName('CTP_CODFOR').AsString) +
                       IIF(strMarDes <> 'T', ' AND CTP_SEQBAI = ' + QuotedStr(cdsDados.FieldByName('CTP_SEQBAI').AsString), '');
    cdsDados.Filtered := True;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('CTP_MARDES').AsString := strMarDes;
      cdsDados.Post;

      cdsDados.Next;
    End;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.EnableControls;
    cdsDados.RecNo := intRec;
    Application.ProcessMessages;
  End;

end;

procedure TfrmEstornoCtaPagar.pSelecionaDuplicata;
  Var
    strMarcar: String;
begin
  strMarcar := 'D';

  If (Not cdsDados.Active) Or (cdsDados.IsEmpty) Then
    Exit;

  With cdsDados Do
  Begin

    If FieldByName('CTP_MARDES').AsString <> 'M' Then
    Begin
      {*****************************************}
      {* CASO FOR A DUPLICATA PRINCIPAL, MARCA *}
      {**************************************MV*}
      If FieldByName('CTP_SEQBAI').AsInteger = 0 Then
        strMarcar := 'M'

      Else
      {*****************************************}
      {* CASO NÃO FOR, VERIFICA SE JÁ TEM AL-  *}
      {* GUMA DUPLICATA PRINCIPAL SELECIONADA  *}
      {**************************************MV*}
      Begin          
        If (fVerificaDuplicataPrincipal)              Or
           ((FieldByName('CTP_SEQBAI').AsInteger > 0) And
            (intPrimSeqBai > 0))                      Then
          strMarcar := 'M'
        Else
          fMensagem('', 'Primeiro você deve selecionar a duplicata principal!', ['&O k']);

      End;
    End

    Else If FieldByName('CTP_SEQBAI').AsInteger = 0 Then
      strMarcar := 'T';

  End;

  pMarcaDuplicata(strMarcar);
  dbgDuplicatas.Refresh;

end;

function TfrmEstornoCtaPagar.fVerificaDuplicataPrincipal: Boolean;
  Var
    intRec: Integer;
begin
  intRec := 0;
  Result := False;

  Try
    intRec := cdsDados.RecNo;
    cdsDados.DisableControls;

    {****************************************}
    {* FILTRA REGISTRO                      *}
    {*************************************AF*}
    cdsDados.Filter := 'CTP_NUMDUP = ' + QuotedStr(cdsDados.FieldByName('CTP_NUMDUP').AsString) + ' AND ' +
                       'CTP_CODEMP = ' + QuotedStr(cdsDados.FieldByName('CTP_CODEMP').AsString) + ' AND ' +
                       'CTP_CODFOR = ' + QuotedStr(cdsDados.FieldByName('CTP_CODFOR').AsString) + ' AND ' +
                       'CTP_SEQBAI = 0 AND ' +
                       'CTP_MARDES = ' + QuotedStr('M');
    cdsDados.Filtered := True;

    If cdsDados.RecordCount = 1 Then
      Result := True;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.EnableControls;
    cdsDados.RecNo := intRec;
  End;

end;

function TfrmEstornoCtaPagar.fEspecieRcx(intSeqCon : Integer):String;
  Var
    qrySelTmp : TUniQuery;
Begin
  qrySelTmp := fCriaQuery;
  Try
    With qrySelTmp, SQL Do
    Begin
      Add(' SELECT SQL_NO_CACHE        ');
      Add('        RCX_ESPDOC          ');
      Add(' FROM CADRCXX               ');
      Add(' WHERE RCX_SEQCON = :SEQCON ');

      ParamByName('SEQCON').AsInteger := intSeqCon;
      Open;
      Result := FieldByName('RCX_ESPDOC').AsString;
    End;

  Finally
    FreeAndNil(qrySelTmp);
  End;
End;

procedure TfrmEstornoCtaPagar.pEstornaDuplicataParcial;
  Var
    blnSomenteParcial: Boolean;
    fltValLan        : Double;
    fltValBan        : Double;
    fltValorTotal    : Double;
    intFatMult       : Integer;
    strSeqBai        : String;
    strSQL           : String;
    strCreDeb        : String;
    strCtaBai        : String;
    qryGen           : TUniQuery;
    strSeqRcx        : String;
    intSeqCon        : Integer;
    fltDinRec,
    fltChqRec,
    fltChqPre,
    fltCarRec,
    fltOrdRec,
    fltValCre        : Double;
    dtaEstorn        : TDateTime;
    blnPagarUC: Boolean;
    blnEstDtaDoc: Boolean;
begin

  Try
    blnEstDtaDoc := False;

//    blnPagarUC := fEhCadPagUsoConsumo(strNomeTabela,
//                                      cdsDados.FieldByName('NRODUP').AsString,
//                                      cdsDados.FieldByName('PARDUP').AsString,
//                                      cdsDados.FieldByName('CTP_CODEMP').AsString,
//                                      cdsDados.FieldByName('CTP_CODFOR').AsString,
//                                      cdsDados.FieldByName('CTP_SERIE_').AsString);
//
//    If blnPagarUC Then
//    Begin
//      fMensagem('ATENÇÃO', 'Não é possível estornar um contas a pagar originado de um documento de Uso e Consumo!', ['&O k']);
//      Exit;
//    End;

    qryGen := fCriaQuery;
    blnSomenteParcial := False;

    If (Not blnResCai) Or (blnResCai And fCfgSis('CTBPAG', varBoolean)) Then
      blnEstDtaDoc := fTipDtaEstBai(fVerificaAcessoSistema('DTAOEP')) = 2;

    pGravaLogCtp(cdsDados.FieldByName('CTP_CODEMP').AsString, cdsDados.FieldByName('AUTOINCREM').AsString, 'pEstornaDuplicataParcial');

    fStartTransaction;

    With cdsDados Do
    Begin
      intFatMult    := 1;
      fltValorTotal := 0.0;
      fltValCre     := 0.0;

      DisableControls;
      First;

      {*****************************************}
      {* CASO TENHA SOMENTE DUPLICATAS BAIXA-  *}
      {* DAS SOMENTE 'PARCIAIS', OU SEJA, A    *}
      {* DUPLICATA PRINCIPAL JÁ FOI ESTORNADA, *}
      {* DEVE-SE SOMAR O VALOR RECEBIDO DAS    *}
      {* DUPLICATAS PARCIAIS AO VALOR ORIGINAL *}
      {* DA DUPLICATA, E NÃO SOBRESCREVER O    *}
      {* MESMO                                 *}
      {**************************************MV*}
      If FieldByName('CTP_SEQBAI').AsInteger > 0 Then
        blnSomenteParcial := True;

      {*****************************************}
      {* PROCESSA AS DUPLICATAS SOMANDO OS     *}
      {* VALORES RECEBIDOS E GUARDANDO OS SE-  *}
      {* QUENCIAIS DE BAIXA QUE SERÃO APAGADOS *}
      {**************************************MV*}
      While Not Eof Do
      Begin

        If FieldByName('CTP_VALPAG').AsFloat < 0 Then
          intFatMult := -1;

        If FieldByName('CTP_MARDES').AsString = 'M' Then
        Begin
          fltValBan := FieldByName('CTP_VALPAG').AsFloat;

          fltValLan := (FieldByName('CTP_VALPAG').AsFloat -
                        FieldByName('CTP_VALJUR').AsFloat +
                        FieldByName('CTP_VALDES').AsFloat);

          strCreDeb := IIF(fltValLan > 0, 'C', 'D');
          fltValBan := fltValBan * intFatMult;
          fltValLan := fltValLan * intFatMult;

          If FieldByName('CTP_SEQBAI').AsInteger > 0 Then
            strSeqBai := strSeqBai + FieldByName('CTP_SEQBAI').AsString + ', ';

          If fEmptyStr(FieldByName('CTP_CTABAI').AsString) Then
            strCtaBai := FieldByName('CTP_CODCTA').AsString
          Else
            strCtaBai := FieldByName('CTP_CTABAI').AsString;

          {***************************}
          {* DELETA CHEQUES EMITIDOS *}
          {************************JU*}
          strSQL := '';
          strSQL := strSQL + 'DELETE FROM ';
          strSQL := strSQL + '  CHQEMI ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  EMI_CODFOR = :CODFOR AND ';
          strSQL := strSQL + '  EMI_NUMDUP = :NRODUP AND ';
          strSQL := strSQL + '  EMI_PARCEL = :PARDUP AND ';
          strSQL := strSQL + '  EMI_CODEMP = :CODEMP AND ';
          strSQL := strSQL + '  EMI_SEQBAI = :SEQBAI AND ';

          If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
            strSQL := strSQL + '  ((EMI_SERIE_ IS NULL) OR (EMI_SERIE_ = "")) '
          Else
            strSQL := strSQL + '  EMI_SERIE_ = IFNULL(:SERIE_,"") ';

          With qryGen Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;
            ParamByName('NRODUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
            ParamByName('PARDUP').AsString := cdsDados.FieldByName('PARDUP').AsString;
            ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
            ParamByName('SEQBAI').AsString := cdsDados.FieldByName('CTP_SEQBAI').AsString;

            If Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
              ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

            ExecSQL;
            Close;
          End;

          {*****************************************}
          {* GRAVA MOVBAN                          *}
          {**************************************MV*}
          If (Not blnResCai) Or (blnResCai And fCfgSis('CTBPAG', varBoolean)) Then
          Begin

            If Not blnEstDtaDoc Then
              dtaEstorn := VS_Date
            Else dtaEstorn := FieldByName('CTP_DTAPAG').AsDateTime;

            If fEmptyStr(fGravaMovBan(strTabelaMovBan,
                                      strCtaBai,                                                     // Centro de Custo
                                      FieldByName('CTP_PORBAI').AsString,                            // Portador da Baixa
                                      strLoginUsuarioLogado,                                         // Operador da Baixa
                                      dtaEstorn{VS_Date},                                            // Data do Lançamento
                                      Time,                                                          // Hora do Lançamento
                                      FieldByName('CTP_NUMDUP').AsString,                            // Numero do Documento
                                      strCreDeb,                                                     // Credito / Debito
                                      FieldByName('CTP_CODEMP').AsString,                            // Empresa da Baixa
                                      fltValBan,                                                     // Valor Do Lançamento
                                      'ESTORNO BX. CT. PAGAR ' + FieldByName('CTP_NUMDUP').AsString, // Histórico 1
                                      '',                                                            // Histórico 2
                                      '',                                                            // Cliente da Duplicata
                                      FieldByName('CTP_CODFOR').AsString,                            // Fornecedor da Duplicata
                                      FieldByName('NRODUP').AsString,                                // Número da Duplicata
                                      0,                                                             // Sequencial de Baixa
                                       FieldByName('PARDUP').AsString,                                // Parcela da Duplicata
                                      VS_strCodEmp,                                                  // Empresa da Duplicata
                                      FieldByName('CTP_SERIE_').AsString,                            // Série
                                      FieldByName('CTP_CODEVE').AsString,                            // Codigo do Evento
                                      '')) Then
            Begin
              fRollBack;
              fMensagem('','Não foi possível gravar moviento bancário!', ['&Ok']);
              Break;
            End;

          End;

          fltValorTotal := fltValorTotal + (fltValLan * intFatMult);

          If(blnResCai) Then
          Begin
            intSeqCon := StrToInt(fRetRcxCon);

            pDeterminaModalidadeEstorno(FieldByName('CTP_RCXCON').AsString,
                                        fltValLan,
                                        fltDinRec,
                                        fltCarRec,
                                        fltChqRec,
                                        fltChqPre,
                                        fltOrdRec);

            If fltDinRec < 0 Then
              fltDinRec := -fltDinRec;

            If fltCarRec < 0 Then
              fltCarRec := -fltCarRec;

            If fltChqRec < 0 Then
              fltChqRec := -fltChqRec;

            If fltChqPre < 0 Then
              fltChqPre := -fltChqPre;

            If fltOrdRec < 0 Then
              fltOrdRec := -fltOrdRec;

            fGravaCadRcx(strSeqRcx,                                         //autoincrem
                        '',                                                //Código do Cliente
                        strOpeRcx,                                         //Operador
                        RightStr(FieldByName('CTP_NUMDUP').AsString, 6),   //Documento
                        'LC',                                              //Espécie
                        VS_strCodEmp,                                      //Empresa
                        dtaDtaCai,                                         //Data de Cadastro
                        Time,                                              //Hora de Cadastro
                        '',                                                //Duplicata
                        '',                                                //Parcela
                        'REF.ESTORNO ' +  FieldByName('CTP_NUMDUP').AsString + '-' +
                        FieldByName('PARDUP').AsString + '-' +
                        VS_strCodEmp + '-' +
                        FieldByName('CTP_CODFOR').AsString,                //Descrição
                        '',                                                //Juros / Dessconto
                        '',                                                //Identificação de Fechamento
                        '',                                                //Forma de Pagamento
                        fltValLan,                                         //Valor do Documento
                        0,                                                 //Desconto Recebido
                        0,                                                 //Juros Recebido
                        fltDinRec,                                         //Valor em dinheiro
                        fltChqRec,                                         //Valor em Cheque à Vista
                        fltChqPre,                                         //Valor em Cheque Pré
                        fltCarRec,                                         //Valor em Cartão
                        fltOrdRec,                                         //Valor em Ordem de Pagamento
                        fltValCre,                                         //Valor de Crédito de Cliente
                        0,                                                 //Valor em Financiamento
                        0.0,                                               //Valor em outras modalidades
                        0.0,                                               //Valor de venda a prazo
                        '',                                                //Num. do Romaneio
                        intSeqCon,                                         //Sequencial de Controle
                        0,                                                 //Sequencial de Baixa (Duplicata)
                        fCfgSisL('SQFCRX'),                                //Sequencial de Fechamento parcial de caixa
                        VS_strCodEmp,                                      //Empresa da duplicata
                        '',                                                //Motivo do desconto
                        IIF(SameText(strNomeTabela, 'CADPAG'), 1, 0),      //Identificação do Caixa
                        0,
                        0,
                        0,
                        0,
                        0);

          End;

        End;

        Next;
      End;
      {*****************************************}
      {* VOLTA PARA A DUPLICATA PRINCIPAL      *}
      {**************************************MV*}
      First;
      EnableControls;
    End;

    strSeqBai := Trim(strSeqBai);

    If RightStr(strSeqBai, 1) = ',' Then
      strSeqBai[Length(strSeqBai)] := ' ';

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + strNomeTabela + ' ';
    strSQL := strSQL + 'SET ';

    If blnSomenteParcial Then
    Begin
      strSQL := strSQL + '  CTP_VALDUP = CTP_VALDUP + :VALORI, ';
      strSQL := strSQL + '  CTP_VALORI = CTP_VALDUP, ';
    End
    Else
    Begin
      strSQL := strSQL + '  CTP_VALORI = :VALORI, ';
      strSQL := strSQL + '  CTP_VALDUP = :VALORI, ';
    End;

    strSQL := strSQL + '  CTP_CTABAI = NULL, ';
    strSQL := strSQL + '  CTP_PORBAI = NULL, ';
    strSQL := strSQL + '  CTP_DOCBAI = NULL, ';
    strSQL := strSQL + '  CTP_HISBAI = NULL, ';
    strSQL := strSQL + '  CTP_OPEBAI = NULL, ';
    strSQL := strSQL + '  CTP_VALPAG = 0, ';
    strSQL := strSQL + '  CTP_DTAPAG = NULL, ';
    strSQL := strSQL + '  CTP_VALDES = 0, ';
    strSQL := strSQL + '  CTP_SEQCON = NULL, ';
    strSQL := strSQL + '  CTP_VALJUR = 0, ';
    strSQL := strSQL + '  CTP_RESCAI = 0  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

    If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '  CTP_SEQBAI = 0 ';

    {*****************************************}
    {* ESTORNA A DUPLICATA PRINCIPAL         *}
    {**************************************MV*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALORI').AsFloat := fltValorTotal;
      ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
      ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
      ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;

      If (Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString)) Then
        ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

      ExecSQL;
      Close;
    End;

    If Not fEmptyStr(strSeqBai) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + strNomeTabela + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

      If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
        strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
      Else
        strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

      strSQL := strSQL + '  CTP_SEQBAI IN ( ' + strSeqBai + ' )';

      {*****************************************}
      {* DELETA AS DUPLICATAS PARCIAIS         *}
      {**************************************MV*}
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
        ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
        ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
        ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;

        If Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
          ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

        ExecSQL;
        Close;
      End;
    End;

    pGravaLogCtp;

    fCommit;

    pCriaTemporaria;
    fMensagem('', 'Duplicatas estornadas com sucesso!', ['&O k']);
    pLimpaCampos;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      cdsDados.EnableControls;
      FreeAndNil(qryGen);
      pMensagensErro('Erro: ' + E.Message,'[pEstornaDuplicataParcial]');
    End;
  End;

end;

procedure TfrmEstornoCtaPagar.pGravaDelCadPag;
  Var
    qryTabDel,
    qryTabOri: TUniQuery;
Begin
  qryTabDel := fCriaQuery(Self);
  qryTabOri := fCriaQuery(Self);

  With cdsDados Do
  Begin

    qryTabOri.SQL.Clear;
    qryTabOri.SQL.Add('SELECT * FROM');
    qryTabOri.SQL.Add(strNomeTabela);
    qryTabOri.SQL.Add('WHERE');
    qryTabOri.SQL.Add('  AUTOINCREM = :AUTINC');
    qryTabOri.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
    qryTabOri.Open;

    qryTabDel.SQL.Text := fVerificaIntegridade(Self.Name, strNomeTabela, qryTabOri, False, False,
                            'REF.ESTORNO PG ' +  FieldByName('CTP_NUMDUP').AsString + '-' +
                            FieldByName('PARDUP').AsString + '-' +
                            VS_strCodEmp + '-' +
                            FieldByName('CTP_CODFOR').AsString);
  End;
  
  qryTabDel.ExecSQL;
  qryTabOri.Close;

  FreeAndNil(qryTabDel);
  FreeAndNil(qryTabOri);
End;

procedure TfrmEstornoCtaPagar.pGravaLogCtp(strCodEmp : String = ''; strAutInc : string = ''; strTipoEstorno : string = '');
var
  qryAuxLogCtp : TUniQuery;
begin
  If Assigned(objLogCtp) And fEmptyStr(strCodEmp) And fEmptyStr(strAutInc) Then
  Begin
//    objLogCtp.fGravaLogCtp;
    FreeAndNil(objLogCtp);
  End
  Else
  Begin
    With qryAuxLogCtp do
    Begin
      qryAuxLogCtp := fCriarQuery('SELECT * FROM ' + strNomeTabela +
      ' WHERE AUTOINCREM = ' + QuotedStr(strAutInc) +
      ' AND CTP_CODEMP = ' + QuotedStr(StrCodEmp) );

      Open;

      if Not(IsEmpty) then
      Begin
        objLogCtp := TCadPag.Create( nil(*,
                                     FieldByName('CTP_BCOENV').AsString {BcoEnv},
                                     FieldByName('CTP_CODBAR').AsString {CodBar},
                                     FieldByName('CTP_CODCTA').AsString {CodCta},
                                     FieldByName('CTP_CODEMP').AsString {CodEmp},
                                     FieldByName('CTP_CODEVE').AsString {CodEve},
                                     FieldByName('CTP_CODFOR').AsString {CodFor},
                                     FieldByName('CTP_CODPOR').AsString {CodPor},
                                     FieldByName('CTP_CODVEL').AsString {CodVel},
                                     FieldByName('CTP_CODVEN').AsString {CodVen},
                                     FieldByName('CTP_CTABAI').AsString {CtaBai},
                                     FieldByName('CTP_DEPOSI').AsString {Deposi},
                                     FieldByName('CTP_DOCBAI').AsString {DocBai},
                                     FieldByName('CTP_DTABAI').AsString {DtaBai},
                                     FieldByName('CTP_DTACAD').AsString {DtaCad},
                                     FieldByName('CTP_DTAENV').AsString {DtaEnv},
                                     FieldByName('CTP_DTAPAG').AsString {DtaPag},
                                     FieldByName('CTP_DTAVEN').AsString {DtaVen},
                                     FieldByName('CTP_EMPBAI').AsString {EmpBai},
                                     FieldByName('CTP_EMPGER').AsString {EmpGer},
                                     LeftStr(FieldByName('CTP_HISBAI').AsString, 50){HisBai},
                                     FieldByName('CTP_HIST01').AsString {Hist01},
                                     FieldByName('CTP_HIST02').AsString {Hist02},
                                     FieldByName('CTP_LINDIG').AsString {LinDig},
                                     FieldByName('CTP_NUMDOC').AsString {NumDoc},
                                     FieldByName('CTP_NUMDUP').AsString {NumDup},
                                     FieldByName('CTP_OPEBAI').AsString {OpeBai},
                                     FieldByName('CTP_PAGANT').AsString {PagAnt},
                                     FieldByName('CTP_PARCEL').AsString {Parcel},
                                     FieldByName('CTP_PORBAI').AsString{PorBai},
                                     FieldByName('CTP_PREVIS').AsString {Previs},
                                     FieldByName('CTP_SERIE_').AsString {Serie},
                                     FieldByName('CTP_TIPDES').AsString {TipDes},
                                     FieldByName('CTP_USACHQ').AsString {UsaChq},
                                     FieldByName('CTP_USOCLI').AsString {UsoCli},
                                     FieldByName('CTP_USODOC').AsString {UsoDoc},
                                     FieldByName('CTP_USOEMP').AsString {UsoEmp},
                                     FieldByName('CTP_USOESP').AsString {UsoEsp},
                                     FieldByName('CTP_COMPET').AsString {Compet},
                                     FieldByName('CTP_CTPCOM').AsString {CtpCom},
                                     FieldByName('CTP_DOCTER').AsString {DocTer},
                                     FieldByName('CTP_EMPTER').AsString {EmpTer},
                                     FieldByName('CTP_ESPTER').AsString {EspTer},
                                     FieldByName('CTP_NOTENT').AsString {NotEnt},
                                     FieldByName('CTP_NOTTIP').AsString {NotTip},
                                     FieldByName('CTP_USOCON').AsString {UsoCon},
                                     FieldByName('CTP_VEIONF').AsString {VeioNF},
                                     FieldByName('CTP_VEIOBO').AsString {VeioBo},
                                     FieldByName('AUTOINCREM').AsString {AutInc},
                                     FieldByName('CTP_CLITER').AsString {CliTer},
                                     FieldByName('CTP_DESSUJ').AsCurrency{DesSuj},
                                     FieldByName('CTP_JURSUJ').AsCurrency{JurSuj},
                                     FieldByName('CTP_VALDES').AsCurrency{ValDes},
                                     FieldByName('CTP_VALDUP').AsCurrency{ValDup},
                                     FieldByName('CTP_VALJUR').AsCurrency{ValJur},
                                     FieldByName('CTP_VALORI').AsCurrency{ValOri},
                                     FieldByName('CTP_VALPAG').AsCurrency{ValPag},
                                     FieldByName('CTP_VENDOR').AsCurrency{Vendor},
                                     FieldByName('CTP_SEQBAI').AsInteger{SeqBai},
                                     FieldByName('CTP_SEQCON').AsInteger{SeqCon},
                                     FieldByName('CTP_TIPDOC').AsInteger{TipDoc},
                                     FieldByName('CTP_RCXCON').AsInteger{RcxCon},
                                     FieldByName('CTP_RESCAI').AsInteger{Rescai},
                                     Self.Name {NomFrm},
                                     'ESTORNO CONTAS A PAGAR ' + strTipoEstorno {Descri}*));
      End;

      FreeAndNil(qryAuxLogCtp);
    End;

  End;
end;

procedure TfrmEstornoCtaPagar.pEstornaDuplicataResumoCaixa;
  Var
    strSQL       : String;
//    fltNovoValOri: Double;
    strCreDeb    : String;
    fltValLan    : Double;
    strCtaBai    : String;
    qryGen       : TUniQuery;
    strSeqRcx    : String;
    intSeqCon    : Integer;
    fltDinRec,
    fltChqRec,
    fltChqPre,
    fltCarRec,
    fltOrdRec,
    fltValCre    : Double;
    dtaEstorn    : TDateTime;
    blnPagarUC: Boolean;
    blnEstDtaDoc: Boolean;
begin

  Try
    blnEstDtaDoc := False;

    fltValCre := 0.00;

    pMensagemOk('Duplicata proviniênte de caixa! Portanto ela será excluída!');

//    blnPagarUC := fEhCadPagUsoConsumo(strNomeTabela,
//                                      cdsDados.FieldByName('NRODUP').AsString,
//                                      cdsDados.FieldByName('PARDUP').AsString,
//                                      cdsDados.FieldByName('CTP_CODEMP').AsString,
//                                      cdsDados.FieldByName('CTP_CODFOR').AsString,
//                                      cdsDados.FieldByName('CTP_SERIE_').AsString);
//
//    If blnPagarUC Then
//    Begin
//      fMensagem('ATENÇÃO', 'Não é possível estornar um contas a pagar originado de um documento de Uso e Consumo!', ['&O k']);
//      Exit;
//    End;

    If fCfgSis('CTBPAG', varBoolean) Then
      blnEstDtaDoc := fTipDtaEstBai(fVerificaAcessoSistema('DTAOEP')) = 2;

    pGravaLogCtp(cdsDados.FieldByName('CTP_CODEMP').AsString, cdsDados.FieldByName('AUTOINCREM').AsString, 'pEstornaDuplicataResumoCaixa');

    fStartTransaction;

    pGravaDelCadPag;

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + strNomeTabela + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

    If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_  ';

    {*****************************************}
    {* EXLCUI A DUPLICATA                    *}
    {**************************************LA*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
      ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
      ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;

      If Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
        ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

      ExecSQL;
      Close;
    End;

    With cdsDados Do
    Begin

      If FieldByName('CTP_VALPAG').AsFloat > 0 Then
      Begin
        fltValLan := FieldByName('CTP_VALPAG').AsFloat;
        strCreDeb := 'C';
      End
      Else
      Begin
        fltValLan := -FieldByName('CTP_VALPAG').AsFloat; // Inverto o valor
        strCreDeb := 'D';
      End;

      If fEmptyStr(FieldByName('CTP_CTABAI').AsString) Then
        strCtaBai := FieldByName('CTP_CODCTA').AsString
      Else
        strCtaBai := FieldByName('CTP_CTABAI').AsString;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CHQEMI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  EMI_CODFOR = :CODFOR AND ';
      strSQL := strSQL + '  EMI_NUMDUP = :NRODUP AND ';
      strSQL := strSQL + '  EMI_PARCEL = :PARDUP AND ';
      strSQL := strSQL + '  EMI_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  EMI_SEQBAI = :SEQBAI AND ';

      If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
        strSQL := strSQL + '  ((EMI_SERIE_ IS NULL) OR (EMI_SERIE_ = "")) '
      Else
        strSQL := strSQL + '  EMI_SERIE_ = IFNULL(:SERIE_,"") ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;
        ParamByName('NRODUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
        ParamByName('PARDUP').AsString := cdsDados.FieldByName('PARDUP').AsString;
        ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
        ParamByName('SEQBAI').AsString := cdsDados.FieldByName('CTP_SEQBAI').AsString;

        If Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
          ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

        ExecSQL;
        Close;
      End;


      {*****************************************}
      {* GRAVA MOVBAN                          *}
      {**************************************LA*}
      If fCfgSis('CTBPAG', varBoolean) Then
      Begin

        If Not blnEstDtaDoc Then
          dtaEstorn := VS_Date
        Else dtaEstorn := FieldByName('CTP_DTAPAG').AsDateTime;

        If fEmptyStr(fGravaMovBan(strTabelaMovBan,
                                  strCtaBai,                                                     // Centro de Custo
                                  FieldByName('CTP_PORBAI').AsString,                            // Portador da Baixa
                                  strLoginUsuarioLogado,                                         // Operador da Baixa
                                  dtaEstorn{VS_Date},                                            // Data do Lançamento
                                  Time,                                                          // Hora do Lançamento
                                  FieldByName('CTP_NUMDUP').AsString,                            // Numero do Documento
                                  strCreDeb,                                                     // Credito / Debito
                                  FieldByName('CTP_CODEMP').AsString,                            // Empresa da Baixa
                                  fltValLan,                                                     // Valor Do Lançamento
                                  'REF.ESTORNO PG ' +  FieldByName('CTP_NUMDUP').AsString + '-' +
                                      FieldByName('PARDUP').AsString + '-' +
                                      VS_strCodEmp + '-' +
                                      FieldByName('CTP_CODFOR').AsString, // Histórico 1
                                  '',                                                            // Histórico 2
                                  '',                                                            // Cliente da Duplicata
                                  FieldByName('CTP_CODFOR').AsString,                            // Fornecedor da Duplicata
                                  FieldByName('NRODUP').AsString,                                // Número da Duplicata
                                  0,                                                             // Sequencial de Baixa
                                  FieldByName('PARDUP').AsString,                                // Parcela da Duplicata
                                  VS_strCodEmp,                                                  // Empresa da Duplicata
                                  FieldByName('CTP_SERIE_').AsString,                            // Série
                                  FieldByName('CTP_CODEVE').AsString,                            // Codigo do Evento
                                  '')) Then
        Begin
          fRollBack;
          fMensagem('', 'Não foi possível gravar movimento bancário!', ['&Ok']);
          FreeAndNil(qryGen);
          Exit;
        End;

      End;


      intSeqCon := StrToInt(fRetRcxCon);

      pDeterminaModalidadeEstorno(FieldByName('CTP_RCXCON').AsString,
                                  fltValLan,
                                  fltDinRec,
                                  fltCarRec,
                                  fltChqRec,
                                  fltChqPre,
                                  fltOrdRec);

      If fltDinRec < 0 Then
        fltDinRec := -fltDinRec;

      If fltCarRec < 0 Then
        fltCarRec := -fltCarRec;

      If fltChqRec < 0 Then
        fltChqRec := -fltChqRec;

      If fltChqPre < 0 Then
        fltChqPre := -fltChqPre;

      If fltOrdRec < 0 Then
        fltOrdRec := -fltOrdRec;

      If cdsDados.FieldByName('CTP_DTAPAG').AsDateTime = VS_Date Then
      Begin
        If Not fGravaCadRcx(strSeqRcx,                                         //autoincrem
                        '',                                                //Código do Cliente
                        strOpeRcx,                                         //Operador
                        RightStr(FieldByName('CTP_NUMDUP').AsString, 6),   //Documento
                        'LC',                                              //Espécie
                        VS_strCodEmp,                                      //Empresa
                        dtaDtaCai,                                         //Data de Cadastro
                        Time,                                              //Hora de Cadastro
                        '',                                                //Duplicata
                        '',                                                //Parcela
                        'REF.ESTORNO PG ' +  FieldByName('CTP_NUMDUP').AsString + '-' +
                        FieldByName('PARDUP').AsString + '-' +
                        VS_strCodEmp + '-' +
                        FieldByName('CTP_CODFOR').AsString,                //Descrição
                        '',                                                //Juros / Dessconto
                        '',                                                //Identificação de Fechamento
                        '',                                                //Forma de Pagamento
                        fltValLan,                                         //Valor do Documento
                        0,                                                 //Desconto Recebido
                        0,                                                 //Juros Recebido
                        fltDinRec,                                         //Valor em dinheiro
                        fltChqRec,                                         //Valor em Cheque à Vista
                        fltChqPre,                                         //Valor em Cheque Pré
                        fltCarRec,                                         //Valor em Cartão
                        fltOrdRec,                                         //Valor em Ordem de Pagamento
                        fltValCre,                                         //Valor de Crédito de Cliente
                        0,                                                 //Valor em Financiamento
                        0.0,                                               //Valor em outras modalidades
                        0.0,                                               //Valor de venda a prazo
                        '',                                                //Num. do Romaneio
                        intSeqCon,                                         //Sequencial de Controle
                        0,                                                 //Sequencial de Baixa (Duplicata)
                        fCfgSisL('SQFCRX'),                                //Sequencial de Fechamento parcial de caixa
                        VS_strCodEmp,                                      //Empresa da duplicata
                        '',                                                //Motivo do desconto
                        IIF(SameText(strNomeTabela, 'CADPAG'), 1, 0),
                        0,
                        0,
                        0,
                        0,
                        0) Then //Identificação do Caixa
        Begin
          fRollBack;
          fMensagem('', 'Não foi possível gravar resumo de caixa!', ['&Ok']);
          FreeAndNil(qryGen);
          Exit;
        End;
      End;

      pGravaLogCtp;

      fCommit;
      fMensagem('', 'Duplicata estornada com sucesso!', ['&O k']);      
    End;
    
    pLimpaCampos;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryGen);
      pMensagensErro('Erro ao tentar estornar duplicata:' + #13 + E.Message, '[pEstornaDuplicataResumoCaixa]');
    End;
  End;

End;

procedure TfrmEstornoCtaPagar.pEstornaDuplicataSimples;
  Var
    strSQL       : String;
    fltNovoValOri: Double;
    strCreDeb    : String;
    fltValLan    : Double;
    strCtaBai    : String;
    qryGen       : TUniQuery;
    strSeqRcx    : String;
    intSeqCon    : Integer;
    fltDinRec,
    fltChqRec,
    fltChqPre,
    fltCarRec,
    fltOrdRec,
    fltValCre    : Double;
    dtaEstorn    : TDateTime;
    blnPagarUC  : Boolean;
    blnEstDtaDoc: Boolean;
begin
  blnEstDtaDoc := False;

//  blnPagarUC := fEhCadPagUsoConsumo(strNomeTabela,
//                                    cdsDados.FieldByName('NRODUP').AsString,
//                                    cdsDados.FieldByName('PARDUP').AsString,
//                                    cdsDados.FieldByName('CTP_CODEMP').AsString,
//                                    cdsDados.FieldByName('CTP_CODFOR').AsString,
//                                    cdsDados.FieldByName('CTP_SERIE_').AsString);
//
//  If blnPagarUC Then
//  Begin
//    fMensagem('ATENÇÃO', 'Não é possível estornar um contas a pagar originado de um documento de Uso e Consumo!', ['&O k']);
//    Exit;
//  End;

  If (Not blnResCai ) Or (blnResCai And fCfgSis('CTBPAG', varBoolean)) Then
    blnEstDtaDoc := fTipDtaEstBai(fVerificaAcessoSistema('DTAOEP')) = 2;

  pGravaLogCtp(cdsDados.FieldByName('CTP_CODEMP').AsString, cdsDados.FieldByName('AUTOINCREM').AsString, 'pEstornaDuplicataSimples');

  fStartTransaction;

  Try
    qryGen := fCriaQuery;

    fltValCre     := 0.0;
    fltNovoValOri := cdsDados.FieldByName('CTP_VALPAG').AsFloat -
                     cdsDados.FieldByName('CTP_VALJUR').AsFloat +
                     cdsDados.FieldByName('CTP_VALDES').AsFloat;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + strNomeTabela + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTP_VALORI = :VALORI, ';
    strSQL := strSQL + '  CTP_VALDUP = :VALORI, ';
    strSQL := strSQL + '  CTP_VALJUR = 0, ';
    strSQL := strSQL + '  CTP_VALDES = 0, ';
    strSQL := strSQL + '  CTP_VALPAG = 0, ';
    strSQL := strSQL + '  CTP_RESCAI = 0, ';
    strSQL := strSQL + '  CTP_DTAPAG = NULL, ';
    strSQL := strSQL + '  CTP_PORBAI = NULL, ';
    strSQL := strSQL + '  CTP_HISBAI = NULL, ';
    strSQL := strSQL + '  CTP_DOCBAI = NULL, ';
    strSQL := strSQL + '  CTP_CTABAI = NULL, ';
    strSQL := strSQL + '  CTP_SEQCON = NULL, ';
    strSQL := strSQL + '  CTP_OPEBAI = NULL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

    If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_  ';

    {*****************************************}
    {* ESTORNA A DUPLICATA                   *}
    {**************************************MV*}
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALORI').AsFloat := fltNovoValOri;
      ParamByName('NUMDUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
      ParamByName('PARCEL').AsString := cdsDados.FieldByName('PARDUP').AsString;
      ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;

      If Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
        ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

      ExecSQL;
      Close;
    End;

    {*****************************}
    {* APAGA O CHEQUE DO CHQEMI  *}
    {**************************JB*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CHQEMI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMI_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  EMI_NUMDUP = :NRODUP AND ';
    strSQL := strSQL + '  EMI_PARCEL = :PARDUP AND ';
    strSQL := strSQL + '  EMI_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMI_SEQBAI = :SEQBAI AND ';

    If fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
      strSQL := strSQL + '  ((EMI_SERIE_ IS NULL) OR (EMI_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  EMI_SERIE_ = IFNULL(:SERIE_,"") ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := cdsDados.FieldByName('CTP_CODFOR').AsString;
      ParamByName('NRODUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
      ParamByName('PARDUP').AsString := cdsDados.FieldByName('PARDUP').AsString;
      ParamByName('CODEMP').AsString := cdsDados.FieldByName('CTP_CODEMP').AsString;
      ParamByName('SEQBAI').AsString := cdsDados.FieldByName('CTP_SEQBAI').AsString;

      If Not fEmptyStr(cdsDados.FieldByName('CTP_SERIE_').AsString) Then
        ParamByName('SERIE_').AsString := cdsDados.FieldByName('CTP_SERIE_').AsString;

      ExecSQL;
      Close;
    End;                 

    With cdsDados Do
    Begin

      If FieldByName('CTP_VALPAG').AsFloat > 0 Then
      Begin
        fltValLan := FieldByName('CTP_VALPAG').AsFloat;
        strCreDeb := 'C';
      End
      Else
      Begin
        fltValLan := -FieldByName('CTP_VALPAG').AsFloat; // Inverto o valor
        strCreDeb := 'D';
      End;

      If fEmptyStr(FieldByName('CTP_CTABAI').AsString) Then
        strCtaBai := FieldByName('CTP_CODCTA').AsString
      Else
        strCtaBai := FieldByName('CTP_CTABAI').AsString;

      If Not fEmptyStr(FieldByName('CTP_DOCBAI').AsString)  Or
        (fCfgSis('CTP_AS', varString) = 'S')                Then
      Begin

        {*****************************************}
        {* GRAVA MOVBAN                          *}
        {**************************************MV*}
        If (Not blnResCai ) Or (blnResCai And fCfgSis('CTBPAG', varBoolean)) Then
        Begin

          If Not blnEstDtaDoc Then
            dtaEstorn := VS_Date
          Else dtaEstorn := FieldByName('CTP_DTAPAG').AsDateTime;

          If fEmptyStr(fGravaMovBan(strTabelaMovBan,
                                    strCtaBai,                                                     // Centro de Custo
                                    FieldByName('CTP_PORBAI').AsString,                            // Portador da Baixa
                                    strLoginUsuarioLogado,                                         // Operador da Baixa
                                    dtaEstorn{VS_Date},                                            // Data do Lançamento
                                    Time,                                                          // Hora do Lançamento
                                    FieldByName('CTP_NUMDUP').AsString,                            // Numero do Documento
                                    strCreDeb,                                                     // Credito / Debito
                                    FieldByName('CTP_CODEMP').AsString,                            // Empresa da Baixa
                                    fltValLan,                                                     // Valor Do Lançamento
                                    'ESTORNO BX. CT. PAGAR ' + FieldByName('CTP_NUMDUP').AsString, // Histórico 1
                                    '',                                                            // Histórico 2
                                    '',                                                            // Cliente da Duplicata
                                    FieldByName('CTP_CODFOR').AsString,                            // Fornecedor da Duplicata
                                    FieldByName('NRODUP').AsString,                                // Número da Duplicata
                                    0,                                                             // Sequencial de Baixa
                                    FieldByName('PARDUP').AsString,                                // Parcela da Duplicata
                                    VS_strCodEmp,                                                  // Empresa da Duplicata
                                    FieldByName('CTP_SERIE_').AsString,                            // Série
                                    FieldByName('CTP_CODEVE').AsString,                            // Codigo do Evento
                                    '')) Then
          Begin
            fRollBack;
            fMensagem('', 'Não foi possível gravar o movimento bancário!', ['&Ok']);
            Exit;
          End;

        End;
      End;

      If(blnResCai) Then
      Begin
        intSeqCon := StrToInt(fRetRcxCon);

        pDeterminaModalidadeEstorno(FieldByName('CTP_RCXCON').AsString,
                                    fltValLan,
                                    fltDinRec,
                                    fltCarRec,
                                    fltChqRec,
                                    fltChqPre,
                                    fltOrdRec);

        If fltDinRec < 0 Then
          fltDinRec := -fltDinRec;

        If fltCarRec < 0 Then
          fltCarRec := -fltCarRec;

        If fltChqRec < 0 Then
          fltChqRec := -fltChqRec;

        If fltChqPre < 0 Then
          fltChqPre := -fltChqPre;

        If fltOrdRec < 0 Then
          fltOrdRec := -fltOrdRec;

        fGravaCadRcx(strSeqRcx,                                         //autoincrem
                    '',                                                //Código do Cliente
                    strOpeRcx,                                         //Operador
                    RightStr(FieldByName('CTP_NUMDUP').AsString, 6),   //Documento
                    'LC',                                              //Espécie
                    VS_strCodEmp,                                      //Empresa
                    dtaDtaCai,                                         //Data de Cadastro
                    Time,                                              //Hora de Cadastro
                    '',                                                //Duplicata
                    '',                                                //Parcela
                    'REF.ESTORNO ' +  FieldByName('CTP_NUMDUP').AsString + '-' +
                    FieldByName('PARDUP').AsString + '-' +
                    VS_strCodEmp + '-' +
                    FieldByName('CTP_CODFOR').AsString,                //Descrição
                    '',                                                //Juros / Dessconto
                    '',                                                //Identificação de Fechamento
                    '',                                                //Forma de Pagamento
                    fltValLan,                                         //Valor do Documento
                    0,                                                 //Desconto Recebido
                    0,                                                 //Juros Recebido
                    fltDinRec,                                         //Valor em dinheiro
                    fltChqRec,                                         //Valor em Cheque à Vista
                    fltChqPre,                                         //Valor em Cheque Pré
                    fltCarRec,                                         //Valor em Cartão
                    fltOrdRec,                                         //Valor em Ordem de Pagamento
                    fltValCre,                                         //Valor de Crédito de Cliente
                    0,                                                 //Valor em Financiamento
                    0.0,                                               //Valor em outras modalidades
                    0.0,                                               //Valor de venda a prazo
                    '',                                                //Num. do Romaneio
                    intSeqCon,                                         //Sequencial de Controle
                    0,                                                 //Sequencial de Baixa (Duplicata)
                    fCfgSisL('SQFCRX'),                                //Sequencial de Fechamento parcial de caixa
                    VS_strCodEmp,                                      //Empresa da duplicata
                    '',                                                //Motivo do desconto
                    IIF(SameText(strNomeTabela, 'CADPAG'), 1, 0),      //Identificação do Caixa
                    0,
                    0,
                    0,
                    0,
                    0);
      End;

    End;

    pGravaLogCtp;

    fCommit;

    fMensagem('', 'Duplicata estornada com sucesso!', ['&O k']);
    pLimpaCampos;

    FreeAndNil(qryGen);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryGen);
      pMensagensErro('Erro ao tentar estornar duplicata:' + #13 + E.Message, '[pEstornaDuplicataSimples]');
    End;
  End;

end;

procedure TfrmEstornoCtaPagar.pLimpaCampos;
begin
  edtNomFor.Clear;
  edtNumDup.Clear;
  edtCodFor.Clear;
  edtSerie.Clear;

  cdsDados.Close;

  edtParcel.Text := 'A';

  pSetFocus(edtNumDup);
end;

procedure TfrmEstornoCtaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objPgoAnt);
  
end;

procedure TfrmEstornoCtaPagar.FormCreate(Sender: TObject);
begin
  inherited;

  blnResCai := False;

  If intCaixa = 1 Then
  Begin
    strNomeTabela   := 'CADPAG';
    strTabelaMovBan := 'MOVBAN';
  End
  Else
  Begin
    strNomeTabela   := 'CADPAGX';
    strTabelaMovBan := 'MOVBANX';
  End;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);

  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;

end;

procedure TfrmEstornoCtaPagar.FormShow(Sender: TObject);
begin
  inherited;

  If Not blnResCai Then
    strOpeRcx := strLoginUsuarioLogado;

end;

procedure TfrmEstornoCtaPagar.dbgDuplicatasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: pSelecionaDuplicata;
    VK_Escape: pLimpaCampos;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;

end;

function TfrmEstornoCtaPagar.fRetDuplicatasSelecionadas: Integer;
  Var
    intRec: Integer;
begin
  intRec := 0;

  Try
    intRec := cdsDados.RecNo;
    cdsDados.DisableControls;

    {****************************************}
    {* FILTRA REGISTRO                      *}
    {*************************************AF*}
    cdsDados.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
    cdsDados.Filtered := True;

    Result := cdsDados.RecordCount;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter   := '';
    cdsDados.EnableControls;
    cdsDados.RecNo := intRec;
  End;

end;

procedure TfrmEstornoCtaPagar.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  Try
    btnConfirma.Enabled := False;

    If cdsDados.IsEmpty Then
      Exit;
      
    If Not cdsDados.Active Then
      pCriaTemporaria;

    If fRetDuplicatasSelecionadas <= 0 Then
      Exit;

    If (pnlDados.Visible) And ((fVerificaDuplicataPrincipal) Or (cdsDados.FieldByName('CTP_SEQBAI').AsInteger > 0)) Then
    Begin

      If fMensagem('', 'Confirma estorno da(s) duplicata(s) selecionada(s)?', ['', '']) = 1 Then
        If Not (fEmptyStr(cdsDados.FieldByName('CTP_RCXCON').AsString)) And
          (cdsDados.FieldByName('CTP_RCXCON').AsInteger > 0) and
          (fEspecieRcx(cdsDados.FieldByName('CTP_RCXCON').AsInteger) = 'PG') Then
          pEstornaDuplicataResumoCaixa
        Else
          pEstornaDuplicataParcial;

      pSetFocus(edtNumDup);
    End;

  Finally
    btnConfirma.Enabled := True;
  End;

end;

procedure TfrmEstornoCtaPagar.btnSairEstClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmEstornoCtaPagar.dbgDuplicatasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If Not cdsDados.Active Then
    Exit;

  If cdsDados.FieldByName('CTP_MARDES').AsString = 'M' Then
  Begin
    dbgDuplicatas.Canvas.Font.Color := clBlue;
    dbgDuplicatas.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmEstornoCtaPagar.dbgDuplicatasDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmEstornoCtaPagar.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEstornoCtaPagar.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEstornoCtaPagar.pDeterminaModalidadeEstorno(strSeqCon: String; fltValDup: Double;
  var fltValDin, fltValCar, fltChqVis, fltChqPre, fltOrdRec: Double);
  Var
    qryAux: TUniQuery;
    qryDupUni: TUniQuery;
    intQtdMod: Integer;

    procedure pDeterminaModalidades;
      Var
        blnDupUnica: Boolean;
    begin
      intQtdMod := 0;
      fltValDin := 0.0;
      fltValCar := 0.0;
      fltChqVis := 0.0;
      fltChqPre := 0.0;
      fltOrdRec := 0.0;

      If qryAux.IsEmpty Then
      Begin
        Exit;
      End;

      blnDupUnica := True;

      If blnDupUnica Then
        intQtdMod := 1;

      If qryAux.FieldByName('RCX_DINREC').AsFloat <> 0.0 Then
      Begin
        fltValDin := qryAux.FieldByName('RCX_DINREC').AsFloat;
      End;

      If qryAux.FieldByName('RCX_CARREC').AsFloat <> 0.0 Then
      Begin
        fltValCar := qryAux.FieldByName('RCX_CARREC').AsFloat;
      End;

      If qryAux.FieldByName('RCX_CHQAVI').AsFloat <> 0.0 Then
      Begin
        fltChqVis := qryAux.FieldByName('RCX_CHQAVI').AsFloat;
      End;

      If qryAux.FieldByName('RCX_CHQPRE').AsFloat <> 0.0 Then
      Begin
        fltChqPre := qryAux.FieldByName('RCX_CHQPRE').AsFloat;
      End;

      If qryAux.FieldByName('RCX_ORDREC').AsFloat <> 0.0 Then
      Begin
        fltOrdRec := qryAux.FieldByName('RCX_ORDREC').AsFloat;
      End;
    end;

begin
  qryAux := fCriaQuery(Self);
  qryDupUni := fCriaQuery(Self);

  {***************************************}
  {* ACHA A DUPLICATA NO CAIXA           *}
  {************************************LA*}
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  RCX_DINREC, ');
  qryAux.SQL.Add('  RCX_CARREC, ');
  qryAux.SQL.Add('  RCX_CHQAVI, ');
  qryAux.SQL.Add('  RCX_CHQPRE, ');
  qryAux.SQL.Add('  RCX_ORDREC  ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADRCXX ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  RCX_ESPDOC = "PG"    AND ');
  qryAux.SQL.Add('  RCX_SEQCON = :SEQCON AND ');
  qryAux.SQL.Add('  RCX_CODEMP = :CODEMP     ');
  qryAux.SQL.Add('ORDER BY ');
  qryAux.SQL.Add('  RCX_DTACAD DESC, RCX_HORCAD DESC ');
  qryAux.SQL.Add('LIMIT 1');

  qryAux.ParamByName('CODEMP').AsString  := VS_strCodEmp;
  qryAux.ParamByName('SEQCON').AsInteger := StrToIntDef(strSeqCon, 0);

  qryAux.Open;
  pDeterminaModalidades;
  qryAux.Close;

  FreeAndNil(qryAux);
  FreeAndNil(qryDupUni);

  {***************************************}
  {* SEGURANÇA!                          *}
  {************************************LA*}
  If fFormataFloat((fltValDin + fltValCar + fltChqVis + fltChqPre + fltOrdRec), 2) = 0.0 Then
    fltValDin := fltValDup;

end;

end.


