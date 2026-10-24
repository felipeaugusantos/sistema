{*********************************************************}
{* CLASSE TORDSER PARA ORDEM DE SERVICO                  *}
{*                                                       *}
{* DATA......: 04/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untFatOrdSer;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  UniClientDataSet,
  ComCtrls,
  Forms,
  cxProgressBar,
  untQckOrdemServico,
  untCfgRel,
  TypesRel,
  untFuncoesEtiquetas,
  untFuncoesSimples,
{$ENDIF}
  SysUtils, StrUtils, Uni, DB, Classes,
  untTypesSistema, System.UITypes, System.Variants, frxClass;

Type

  TOperacaoServico = (opeBaixaSer, opeEtiquetasSer);

  TOrdSer = Class(TObject)
  private

    FAutInc: String;
    FNumOrd: String;
    FCodEmp: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodIte: String;
    FCodCli: String;
    FTarja_: String;
    FRecLoc: String;
    FObserv: String;
    FBaixad: String;
    FDtaCad: TDateTime;
    FQtdSer: Integer;
    FLargur: Double;
    FAltura: Double;
    FTot_M2: Double;
    FQtdEti: Integer;
    FTrava : Boolean;
    FCodGru: String;
    FSeqInd: Integer;
    FTotGerM2: String;
    FSeqIndProd: Integer;
    FTipoFiltro: TFiltroOrdServProd;
    FLimpar : Boolean;

    {**************************************}
    {* FUNȏES DA CLASSE                  *}
    {***********************************AF*}
    function getAltura: String;
    function getDtaCad: String;
    function getLargur: String;
    function getQtdSer: String;
    function getTot_M2: String;

    {**************************************}
    {* PROCEDURES DA CLASSE               *}
    {***********************************AF*}
    procedure setDtaCad(const Value: String);
    procedure setAltura(const Value: String);
    procedure setLargur(const Value: String);
    procedure setQtdSer(const Value: String);
    procedure setTot_M2(const Value: String);
    procedure setQtdEti(const Value: Integer);

    procedure pSetaQtdEti;

    Function fGetRegistrosParaImpressao: Boolean;

    procedure pCriarClientDataSet;
    procedure pCriarCampos;
    procedure pLimparDados;
    procedure pInicializarQryImpEti;

  {$IFNDEF LINUX}
    procedure pAtualizarQtdEti(blnLimpar: Boolean);
    Function fImprimeRegistroEtiquetas: Boolean;
  {$ENDIF}

    function fGetSQLInsert: String;
    function fGetSQL: String;
    function fGetSQL_FATGOS: String;
    function fPossuiItensAjuste: Boolean;
    function fAtualizarQtdEtiInterna(cxProgressBar: TcxProgressBar) : Boolean;
    function fCarregaManOrdSerInterna(cxProgressBar: TcxProgressBar): Boolean;
  public

    qryImpEti: TUniQuery;
    qryOrdSer: TUniquery;
    qryCfgRel: TUniquery;
    dtsOrdSer: TDataSource;
    cdsOrdSer: TUniClientDataSet;

    opeTipOpe: TOperacaoServico;

    property strAutInc: String      Read FAutInc   Write FAutInc;
    property strNumOrd: String      Read FNumOrd   Write FNumOrd;
    property strCodEmp: String      Read FCodEmp   Write FCodEmp;
    property strNumDoc: String      Read FNumDoc   Write FNumDoc;
    property strEspDoc: String      Read FEspDoc   Write FEspDoc;
    property strCodIte: String      Read FCodIte   Write FCodIte;
    property strCodCli: String      Read FCodCli   Write FCodCli;
    property strTarja_: String      Read FTarja_   Write FTarja_;
    property strRecLoc: String      Read FRecLoc   Write FRecLoc;
    property strObserv: String      Read FObserv   Write FObserv;
    property strBaixad: String      Read FBaixad   Write FBaixad;
    property strDtaCad: String      Read getDtaCad Write setDtaCad;
    property strQtdSer: String      Read getQtdSer Write setQtdSer;
    property strLargur: String      Read getLargur Write setLargur;
    property strAltura: String      Read getAltura Write setAltura;
    property strTot_M2: String      Read getTot_M2 Write setTot_M2;
    property intQtdEti: Integer     Read FQtdEti   Write setQtdEti;
    property blnTrava : Boolean     Read FTrava    Write FTrava;
    property strCodGru: String      Read FCodGru   Write FCodGru;
    property intSeqInd: Integer     Read FSeqInd   Write FSeqInd;
    property strTotGerM2: String    Read FTotGerM2 Write FTotGerM2;
    property intSeqIndProd: Integer Read FSeqIndProd;

    Constructor Create;
    Destructor Destroy; Override;

    procedure pAtuDados;

    {$IFNDEF LINUX}
    procedure pCarregaManOrdSer(odTipoFiltro: TFiltroOrdServProd);
    procedure pImprimeOrdSerIndiv(strNumDoc: String = ''; strEspDoc: String = '');
    function fAdicionarItemOrdemServico(AEditar: Boolean = False): Boolean;
    Function fImprimeEtiquetas: Boolean;
    {$ENDIF}

    procedure pMarcaManOrdSer;
    procedure pDeletaManOrdSer;
    procedure pBaixaManOrdSer;
    procedure pAtualizaDados(strNumDoc, strEspDoc, strCodEmp, strCodIte: String; intSeqInd: Integer; blnConsulta: Boolean = True);
    procedure pExcluirItem(strCodIte: String; intSeqInd: Integer);
    procedure pAtualizaSeqIndItens(cdsVenda: TUniClientDataSet);
    function  fGetSeqIndProduto(strCodIte: String): Integer;

    function fExisteOrdemServicoBaixada(strNumDoc, strEspDoc: String): Boolean;
    function fCancelaOrdSer(strNumDoc, strEspDoc: String): Boolean;

    function fSalvarDados(strNumDoc, strEspDoc, strNumOrc, strEspOrc, strCodCli: String): Boolean;
    function fGravaOrdSerOrc(strAutInc, strNumDoc, strEspDoc: String): Boolean;
    function fGetSeqInd: Integer;

    procedure pAjustarItensOrcamentoOrdSer(cdsVenda: TUniClientDataSet);

  end;


implementation

{$IFNDEF LINUX}
uses
   untFatQtdOrdSer, untGravando;
{$ENDIF}

{ TOrdSer }

{**************************************}
{* CONSTRUTOR DA CLASSE               *}
{***********************************AF*}
constructor TOrdSer.Create;
begin
  inherited;

  cdsOrdSer := TUniClientDataSet.Create(Nil);
  pCriarClientDataSet();

  dtsOrdSer := TDataSource.Create(Nil);
  dtsOrdSer.DataSet := cdsOrdSer;

  qryOrdSer := fCriaQuery;
  qryCfgRel := fCriaQuery;
  qryImpEti := fCriaQuery;

  opeTipOpe := opeBaixaSer;

  pLimparDados();
end;

{**************************************}
{* DESTRUTOR DA CLASSE                *}
{***********************************AF*}
destructor TOrdSer.Destroy;
begin

  FreeAndNil(qryImpEti);
  FreeAndNil(qryOrdSer);
  FreeAndNil(qryCfgRel);
  FreeAndNil(dtsOrdSer);
  FreeAndNil(cdsOrdSer);

  inherited;
end;

function TOrdSer.getAltura: String;
begin
  Result := FloatToStrF(FAltura, ffFixed, 12, 2);
end;

function TOrdSer.getDtaCad: String;
begin

  If FDtaCad = 0 Then
    Result := ''
  Else
    Result := FormatDateTime('dd/mm/yyyy',FDtaCad);

end;

function TOrdSer.getLargur: String;
begin
  Result := FloatToStrF(FLargur, ffFixed, 12, 2);
end;

function TOrdSer.getQtdSer: String;
begin
  Result := IntToStr(FQtdSer);
end;

function TOrdSer.getTot_M2: String;
begin
  Result := FloatToStrF(FTot_M2, ffFixed, 12, 2);
end;

procedure TOrdSer.setDtaCad(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDtaCad := StrToDate(Value);

end;

procedure TOrdSer.setAltura(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FAltura := fStrToFloat(Value);

end;

procedure TOrdSer.setLargur(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FLargur := fStrToFloat(Value);

end;

procedure TOrdSer.setQtdSer(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FQtdSer := StrToInt(Value);

end;

procedure TOrdSer.setTot_M2(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FTot_M2 := fStrToFloat(Value);

end;

procedure TOrdSer.setQtdEti(const Value: Integer);
begin

  If Value <> FQtdEti Then
  Begin
    FQtdEti := Value;
    pSetaQtdEti;
  End;

end;

{**********************************}
{* CARREGA TABELA PARA MODULO DE  *}
{* MANUTENȃO DE ORDEM DE SERVIȏ *}
{*******************************AF*}
{$IFNDEF LINUX}
procedure TOrdSer.pCarregaManOrdSer(odTipoFiltro: TFiltroOrdServProd);
Begin
  FTipoFiltro := odTipoFiltro;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fCarregaManOrdSerInterna;
    frmGravando.lblGravando.Caption := 'Carregando ordens de serviço...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;
{$ENDIF}

function TOrdSer.fCarregaManOrdSerInterna(cxProgressBar : TcxProgressBar) : Boolean;
Begin
  Try

    With qryOrdSer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQL());
      SQL.Add(' AND ORD_CODEMP = :CODEMP');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open();
    End;

    qryOrdSer.First();

    cxProgressBar.Properties.Max := qryOrdSer.RecordCount;

    cdsOrdSer.DisableControls;
    While (Not qryOrdSer.Eof) Do Begin
      cdsOrdSer.Append();

      cdsOrdSer.FieldByName('MARDES').AsString       := 'D';
      cdsOrdSer.FieldByName('ORD_ITEDEL').AsString   := 'N';
      cdsOrdSer.FieldByName('ORD_AJUSTE').AsString   := 'N';
      cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger  := qryOrdSer.FieldByName('ORD_QTDETI').AsInteger;

      cdsOrdSer.FieldByName('AUTOINCREM').AsString   := qryOrdSer.FieldByName('AUTOINCREM').AsString;
      cdsOrdSer.FieldByName('ORD_NUMORD').AsString   := qryOrdSer.FieldByName('ORD_NUMORD').AsString;
      cdsOrdSer.FieldByName('ORD_CODEMP').AsString   := qryOrdSer.FieldByName('ORD_CODEMP').AsString;
      cdsOrdSer.FieldByName('ORD_NUMDOC').AsString   := qryOrdSer.FieldByName('ORD_NUMDOC').AsString;
      cdsOrdSer.FieldByName('ORD_ESPDOC').AsString   := qryOrdSer.FieldByName('ORD_ESPDOC').AsString;
      cdsOrdSer.FieldByName('ORD_TARJA_').AsString   := qryOrdSer.FieldByName('ORD_TARJA_').AsString;
      cdsOrdSer.FieldByName('ORD_RECLOC').AsString   := qryOrdSer.FieldByName('ORD_RECLOC').AsString;
      cdsOrdSer.FieldByName('ORD_OBSERV').AsString   := qryOrdSer.FieldByName('ORD_OBSERV').AsString;
      cdsOrdSer.FieldByName('ORD_BAIXAD').AsString   := qryOrdSer.FieldByName('ORD_BAIXAD').AsString;
      cdsOrdSer.FieldByName('ORD_OPEBAI').AsString   := qryOrdSer.FieldByName('ORD_OPEBAI').AsString;
      cdsOrdSer.FieldByName('ORD_CODITE').AsString   := qryOrdSer.FieldByName('ORD_CODITE').AsString;
      cdsOrdSer.FieldByName('ORD_CODCLI').AsString   := qryOrdSer.FieldByName('ORD_CODCLI').AsString;

      cdsOrdSer.FieldByName('ORD_DOCUME').AsString   := qryOrdSer.FieldByName('ORD_DOCUME').AsString;
      cdsOrdSer.FieldByName('ORD_NOMCLI').AsString   := qryOrdSer.FieldByName('ORD_NOMCLI').AsString;
      cdsOrdSer.FieldByName('ORD_DESITE').AsString   := qryOrdSer.FieldByName('ORD_DESITE').AsString;

      cdsOrdSer.FieldByName('ORD_QTDSER').AsFloat    := qryOrdSer.FieldByName('ORD_QTDSER').AsFloat;
      cdsOrdSer.FieldByName('ORD_LARGUR').AsFloat    := qryOrdSer.FieldByName('ORD_LARGUR').AsFloat;
      cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat    := qryOrdSer.FieldByName('ORD_ALTURA').AsFloat;
      cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat    := qryOrdSer.FieldByName('ORD_TOT_M2').AsFloat;

      cdsOrdSer.FieldByName('ORD_DTACAD').AsDateTime := qryOrdSer.FieldByName('ORD_DTACAD').AsDateTime;
      cdsOrdSer.FieldByName('ORD_DTABAI').AsDateTime := qryOrdSer.FieldByName('ORD_DTABAI').AsDateTime;

      cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger  := qryOrdSer.FieldByName('ORD_SEQIND').AsInteger;

      cdsOrdSer.Post();

      cxProgressBar.Position := cxProgressBar.Position + 1;
      Application.ProcessMessages;
      qryOrdSer.Next();
    End;
    cdsOrdSer.First;
    cdsOrdSer.EnableControls;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  Result := True;

End;

{**************************************}
{* CARREGA DADOS PARA AS VAIRAVEIS    *}
{***********************************AF*}
procedure TOrdSer.pAtuDados;
Begin

  Try

    With cdsOrdSer Do
    Begin
      FAutInc := FieldByName('AUTOINCREM').AsString;
      FNumOrd := FieldByName('ORD_NUMORD').AsString;
      FCodEmp := VS_strCodEmp;
      FNumDoc := FieldByName('ORD_NUMDOC').AsString;
      FEspDoc := FieldByName('ORD_ESPDOC').AsString;
      FCodIte := FieldByName('ORD_CODITE').AsString;
      FCodCli := FieldByName('ORD_CODCLI').AsString;
      FTarja_ := FieldByName('ORD_TARJA_').AsString;
      FRecLoc := FieldByName('ORD_RECLOC').AsString;
      FObserv := FieldByName('ORD_OBSERV').AsString;
      FBaixad := FieldByName('ORD_BAIXAD').AsString;
      FDtaCad := FieldByName('ORD_DTACAD').AsDateTime;
      FQtdSer := FieldByName('ORD_QTDSER').AsInteger;
      FLargur := FieldByName('ORD_LARGUR').AsFloat;
      FAltura := FieldByName('ORD_ALTURA').AsFloat;
      FTot_M2 := FieldByName('ORD_TOT_M2').AsFloat;
      FQtdEti := FieldByName('ORD_QTDETI').AsInteger;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

End;

{**************************************}
{* MARCA OU DESMARCA REGISTRO DA TMP  *}
{***********************************AF*}
procedure TOrdSer.pMarcaManOrdSer;
Begin
  If (cdsOrdSer.IsEmpty) Then Exit;

  Try
    cdsOrdSer.Edit();

    If cdsOrdSer.FieldByName('MARDES').AsString = 'D' Then Begin
      cdsOrdSer.FieldByName('MARDES').AsString      := 'M';
      cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger := 1;
    End Else Begin
      cdsOrdSer.FieldByName('MARDES').AsString      := 'D';
      cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger := 0;
    End;

    cdsOrdSer.Post();

    FQtdEti := 1;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure TOrdSer.pSetaQtdEti;
Begin
  If (cdsOrdSer.IsEmpty) Then Exit;

  Try
    cdsOrdSer.Edit();
    cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger := FQtdEti;
    cdsOrdSer.Post();
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

{*******************************************}
{* DELETE REGISTROS MARCADOS NA TEMPORARIA *}
{****************************************AF*}
procedure TOrdSer.pDeletaManOrdSer;
  Var
    strSQL: String;
    qryTemp: TUniQuery;
Begin
  Try
    qryTemp := fCriaQuery;

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'MARDES = ' + QuotedStr('M') + ' AND ORD_BAIXAD = ' + QuotedStr('N');
    cdsOrdSer.Filtered := True;

    If Not cdsOrdSer.IsEmpty Then Begin

      If fMensagem('','Tem certeza que deseja excluir estes registros?',['&Sim','&Não']) = 1 Then Begin
        fStartTransaction();

        cdsOrdSer.DisableControls();

        cdsOrdSer.First();

        While (Not cdsOrdSer.Eof) Do Begin
          strSQL := '';
          strSQL := strSQL + 'DELETE FROM            ';
          strSQL := strSQL + '  ORDSER               ';
          strSQL := strSQL + 'WHERE                  ';
          strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

          qryTemp.Close;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add(strSQL);
          qryTemp.ParamByName('AUTINC').AsString := cdsOrdSer.FieldByName('AUTOINCREM').AsString;
          qryTemp.ExecSQL;
          qryTemp.Close;

          cdsOrdSer.Next();
        End;

        cdsOrdSer.EnableControls();

        fCommit;

        fMensagem('','Registros apagados com sucesso!',['&OK']);

        cdsOrdSer.EmptyDataSet();
        pAtualizaDados('', '', VS_strCodEmp, '', 0);
      End;

    End
    Else
      fMensagem('','Não registros selecionados!', ['&OK']);

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := '' ;

    FreeAndNil(qryTemp);
  Except
    On E: Exception Do Begin
      fRollback();
      Raise Exception.Create(E.Message);
    End;
  End;
End;

procedure TOrdSer.pExcluirItem(strCodIte: String; intSeqInd: Integer);
begin
  If (cdsOrdSer.IsEmpty) Then Exit;

  Try
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'ORD_CODITE = ' + QuotedStr(strCodIte) + ' AND ORD_SEQIND = ' + QuotedStr(IntToStr(intSeqInd));
    cdsOrdSer.Filtered := True;

    If (Not cdsOrdSer.IsEmpty) Then Begin
      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := '';

      While (cdsOrdSer.Locate('ORD_CODITE;ORD_SEQIND', VarArrayOf([strCodIte, IntToStr(intSeqInd)]), [])) Do Begin
        cdsOrdSer.Delete();
      End;
    End;
  Finally
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := '';
  End;
end;

{**********************************************}
{* IMPRIME A ORDEM DE SERVIȏ INDIVIDUALMENTE *}
{*******************************************AF*}
{$IFNDEF LINUX}
procedure TOrdSer.pImprimeOrdSerIndiv(strNumDoc: String = ''; strEspDoc: String = '');
  Var
    frmQckOrdemServico: TfrmQckOrdemServico;
    strNomeFila: String;
    strTipImp  : String;
    frxRel: TfrxReport;
Begin

  If fEmptyStr(strNumDoc) Then
  Begin
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'MARDES = ' + QuotedStr('M');
    cdsOrdSer.Filtered := True;

    If cdsOrdSer.IsEmpty Then Begin
      fMensagem('','Não há registros selecionados!', ['&OK']);

      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := '';

      Exit;
    End;
  End;

  Try
    cdsOrdSer.DisableControls();

    cdsOrdSer.First();

    While (Not cdsOrdSer.Eof) Do Begin
      Try
        pCriarFormularios(TfrmQckOrdemServico,frmQckOrdemServico);
        Try
          pCarregaConfImpr(qryCfgRel, 'frmFatVendas_ORDEMSERVICO');
          fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

          If strTipImp = 'M' Then
            frxRel := frmQckOrdemServico.frxRelatorioM
          Else
            frxRel := frmQckOrdemServico.frxRelatorioJ;

          frxRel.Script.Variables['NOMREL']      := '* * *   O R D E M   D E   S E R V I C O   No ' + cdsOrdSer.FieldByName('ORD_NUMORD').AsString + '   * * *';
          frxRel.Script.Variables['CLIENTE']     := cdsOrdSer.FieldByName('ORD_CODCLI').AsString + '-' + fRetNomCliente(cdsOrdSer.FieldByName('ORD_CODCLI').AsString);
          frxRel.Script.Variables['PRODUTO']     := cdsOrdSer.FieldByName('ORD_CODITE').AsString + '-' + fRetNomProduto(cdsOrdSer.FieldByName('ORD_CODITE').AsString);
          frxRel.Script.Variables['MEDIDAS']     := 'Altura ==> ' + FloatToStrF(cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat,ffFixed,12,2) + ' Largura ==> ' + FloatToStrF(cdsOrdSer.FieldByName('ORD_LARGUR').AsFloat,ffFixed,12,2);
          frxRel.Script.Variables['QUANTIDADE']  := IntToStr(cdsOrdSer.FieldByName('ORD_QTDSER').AsInteger) + ' TOTAL M2 ==> ' + FloatToStrF(cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat,ffFixed,12,2);
          frxRel.Script.Variables['OBSERVACAO']  := cdsOrdSer.FieldByName('ORD_OBSERV').AsString;
          frxRel.Script.Variables['DATA']        := FormatDateTime('dd/mm/yyyy',VS_Date);

          If (Not fEmptyStr(cdsOrdSer.FieldByName('ORD_NUMDOC').AsString)) Then
            frxRel.Script.Variables['DOCUMENTO'] := cdsOrdSer.FieldByName('ORD_NUMDOC').AsString + '-' + cdsOrdSer.FieldByName('ORD_ESPDOC').AsString
          Else
            frxRel.Script.Variables['DOCUMENTO'] := strNumDoc + '-' + strEspDoc;

          frxRel.Script.Variables['TARJA']       := IIF(cdsOrdSer.FieldByName('ORD_TARJA_').AsString = 'S', '[*] TARJA', '[ ] TARJA');
          frxRel.Script.Variables['RECORTE']     := IIF(cdsOrdSer.FieldByName('ORD_RECLOC').AsString = 'S', '[*] RECORTE NO LOCAL', '[ ] RECORTE NO LOCAL');

          pPrintReport('frmFatVendas_ORDEMSERVICO', 'Impressão de Ordem de Serviço', strNomeFila, frxRel);

          If frxRel.PrepareReport Then
          Begin
            frxRel.PrintOptions.Printer := strNomeFila;
            frxRel.PrintOptions.ShowDialog := strNomeFila.IsEmpty;
            pPrintReport('frmFatVendas_ORDEMSERVICO', 'Impressão de Ordem de Serviço', strNomeFila, frxRel);
          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message,'[TOrdSer.pImprimeOrdSerIndiv]');
          end;
        End;
      Finally
        pFreeAndNil(frmQckOrdemServico);
      End;

      cdsOrdSer.Next();
    End;

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := '';

    cdsOrdSer.First();

    While (Not cdsOrdSer.Eof) Do Begin
      cdsOrdSer.Edit();
      cdsOrdSer.FieldByName('MARDES').AsString := 'D';
      cdsOrdSer.Post();

      cdsOrdSer.Next();
    End;

    cdsOrdSer.EnableControls();
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;
{$ENDIF}

procedure TOrdSer.pInicializarQryImpEti;
  Var
    strSQL: String;
begin
  qryImpEti.Close();
  qryImpEti.SQL.Clear();

  strSQL := '';
  strSQL := strSQL + 'SELECT ORD_NUMORD AS NUMORD, ';
  strSQL := strSQL + '       ORD_CODITE AS CODITE, ';
  strSQL := strSQL + '       ORD_CODCLI AS CODCLI, ';
  strSQL := strSQL + '       ORD_TOT_M2 AS TOT_M2, ';
  strSQL := strSQL + '       ORD_QTDETI AS QTDETI, ';
  strSQL := strSQL + '       ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '       CLI_NOMCLI AS NOMCLI  ';
  strSQL := strSQL + '  FROM ORDSER                ';
  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = ORD_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = ORD_CODCLI ';
  strSQL := strSQL + ' WHERE ORDSER.AUTOINCREM = :AUTINC ';

  qryImpEti.SQL.Text := strSQL;

end;

procedure TOrdSer.pLimparDados;
begin
  FAutInc := '';
  FNumOrd := '';
  FCodEmp := '';
  FNumDoc := '';
  FEspDoc := '';
  FCodIte := '';
  FCodCli := '';
  FTarja_ := '';
  FRecLoc := '';
  FObserv := '';
  FDtaCad := 0;
  FQtdSer := 0;
  FLargur := 0;
  FAltura := 0;
  FTot_M2 := 0;
  FTrava  := False;
  FCodGru := '';
  FTotGerM2 := '';
  FSeqIndProd := 0;
  FTipoFiltro := odTodos;

  FQtdEti := 0;
end;

Function TOrdSer.fGetRegistrosParaImpressao: Boolean;
Begin
  Try
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'MARDES = ' + QuotedStr('M') + ' AND ORD_QTDETI > 0';
    cdsOrdSer.Filtered := True;

    Result := Not cdsOrdSer.IsEmpty;

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := '';
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

function TOrdSer.fGetSeqInd: Integer;
begin
  FSeqIndProd := FSeqIndProd + 1;
  Result := FSeqIndProd;
end;

function TOrdSer.fGetSeqIndProduto(strCodIte: String): Integer;
begin
  Result := 0;

  cdsOrdSer.DisableControls();
  cdsOrdSer.First();

  While (Not cdsOrdSer.Eof) Do Begin
    If ((cdsOrdSer.FieldByName('RET_SEQIND').AsString = 'N') or
       (fEmptyStr(cdsOrdSer.FieldByName('RET_SEQIND').AsString))) And (cdsOrdSer.FieldByName('ORD_CODITE').AsString = strCodIte) Then Begin
      cdsOrdSer.Edit();
      cdsOrdSer.FieldByName('RET_SEQIND').AsString := 'S';
      cdsOrdSer.Post();

      Result := cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger;

      Break
    End;

    cdsOrdSer.Next();
  End;

  cdsOrdSer.EnableControls();
end;

function TOrdSer.fGetSQL: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ORDSER.*, ';
  strSQL := strSQL + '  CONCAT(ORD_NUMDOC,"-",ORD_ESPDOC) AS ORD_DOCUME, ';
  strSQL := strSQL + '  CONCAT(ORD_CODITE,"-",ITE_DESITE) AS ORD_DESITE, ';
  strSQL := strSQL + '  CONCAT(ORD_CODCLI,"-",CLI_NOMCLI) AS ORD_NOMCLI, ';
  strSQL := strSQL + '  "D" AS MARDES, ';
  strSQL := strSQL + '  "N" AS ORD_ITEDEL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ORDSER ';
  strSQL := strSQL + '  LEFT JOIN CADITE ON ITE_CODITE = ORD_CODITE ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = ORD_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  If opeTipOpe <> opeEtiquetasSer Then Begin
    If (FTipoFiltro = odBaixados) Then
      strSQL := strSQL + ' AND ORD_BAIXAD = "S" '
    Else If (FTipoFiltro = odNaoBaixados) Then
      strSQL := strSQL + ' AND ORD_BAIXAD = "N" ';
  End;

  Result := strSQL;
end;

function TOrdSer.fGetSQLInsert: String;
begin
  Result := 'INSERT INTO ORDSER ( '
    + ' AUTOINCREM, '
    + ' ORD_NUMORD, '
    + ' ORD_CODEMP, '
    + ' ORD_NUMDOC, '
    + ' ORD_ESPDOC, '
    + ' ORD_DTACAD, '
    + ' ORD_CODITE, '
    + ' ORD_CODCLI, '
    + ' ORD_QTDSER, '
    + ' ORD_LARGUR, '
    + ' ORD_ALTURA, '
    + ' ORD_TOT_M2, '
    + ' ORD_TARJA_, '
    + ' ORD_RECLOC, '
    + ' ORD_OBSERV, '
    + ' ORD_BAIXAD, '
    + ' ORD_OPEBAI, '
    + ' ORD_DTABAI, '
    + ' ORD_SEQIND) VALUES (  '
    + ' :AUTINC, '
    + ' :NUMORD, '
    + ' :CODEMP, '
    + ' :NUMDOC, '
    + ' :ESPDOC, '
    + ' :DTACAD, '
    + ' :CODITE, '
    + ' :CODCLI, '
    + ' :QTDSER, '
    + ' :LARGUR, '
    + ' :ALTURA, '
    + ' :TOT_M2, '
    + ' :TARJA_, '
    + ' :RECLOC, '
    + ' :OBSERV, '
    + ' :BAIXAD, '
    + ' :OPEBAI, '
    + ' :DTABAI, '
    + ' :SEQIND) ';
end;

function TOrdSer.fGetSQL_FATGOS: String;
  Var
    strSQL: String;
begin
  strSQL := strSQL + '  SELECT        ';
  strSQL := strSQL + '    *           ';
  strSQL := strSQL + '  FROM          ';
  strSQL := strSQL + '    FATGOS      ';
  strSQL := strSQL + '  WHERE         ';
  strSQL := strSQL + '    FGO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '    FGO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '    FGO_CODEMP = :CODEMP     ';

  Result := strSQL;
end;

function TOrdSer.fGravaOrdSerOrc(strAutInc, strNumDoc, strEspDoc: String): Boolean;
  Var
    qryGen: TUniQuery;
    qryOrd: TUniQuery;
Begin

  Result := True;

  Try
    qryGen := fCriaQuery;
    qryOrd := fCriaQuery;

    Try
      With qryGen Do Begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE   ');
        SQL.Add('FROM     ');
        SQL.Add('  FATGOS ');
        SQL.Add('WHERE    ');
        SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
        SQL.Add('  FGO_ESPDOC = :ESPDOC     ');

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ExecSQL;
        Close;

        cdsOrdSer.DisableControls();
        cdsOrdSer.First();

        While (Not cdsOrdSer.Eof) Do Begin
          qryOrd.Close;
          qryOrd.SQL.Clear;
          qryOrd.SQL.Add('INSERT INTO FATGOS ( ');
          qryOrd.SQL.Add('  AUTOINCREM, ');
          qryOrd.SQL.Add('  FGO_CODEMP, ');
          qryOrd.SQL.Add('  FGO_NUMDOC, ');
          qryOrd.SQL.Add('  FGO_ESPDOC, ');
          qryOrd.SQL.Add('  FGO_DTACAD, ');
          qryOrd.SQL.Add('  FGO_CODITE, ');
          qryOrd.SQL.Add('  FGO_QTDSER, ');
          qryOrd.SQL.Add('  FGO_LARGUR, ');
          qryOrd.SQL.Add('  FGO_ALTURA, ');
          qryOrd.SQL.Add('  FGO_TOT_M2, ');
          qryOrd.SQL.Add('  FGO_TARJA_, ');
          qryOrd.SQL.Add('  FGO_RECLOC, ');
          qryOrd.SQL.Add('  FGO_OBSERV, ');
          qryOrd.SQL.Add('  FGO_SEQIND  ');
          qryOrd.SQL.Add('  ) VALUES (  ');
          qryOrd.SQL.Add('  :AUTINC, ');
          qryOrd.SQL.Add('  :CODEMP, ');
          qryOrd.SQL.Add('  :NUMDOC, ');
          qryOrd.SQL.Add('  :ESPDOC, ');
          qryOrd.SQL.Add('  :DTACAD, ');
          qryOrd.SQL.Add('  :CODITE, ');
          qryOrd.SQL.Add('  :QTDSER, ');
          qryOrd.SQL.Add('  :LARGUR, ');
          qryOrd.SQL.Add('  :ALTURA, ');
          qryOrd.SQL.Add('  :TOT_M2, ');
          qryOrd.SQL.Add('  :TARJA_, ');
          qryOrd.SQL.Add('  :RECLOC, ');
          qryOrd.SQL.Add('  :OBSERV, ');
          qryOrd.SQL.Add('  :SEQIND) ');

          qryOrd.ParamByName('AUTINC').AsString  := fRetAutoIncrem('FATGOS', VS_strCodEmp);
          qryOrd.ParamByName('CODEMP').AsString  := IIF(Not fEmptyStr(strCodEmp), strCodEmp, VS_strCodEmp);
          qryOrd.ParamByName('NUMDOC').AsString  := strNumDoc;
          qryOrd.ParamByName('ESPDOC').AsString  := strEspDoc;
          qryOrd.ParamByName('DTACAD').AsDate    := VS_Date;
          qryOrd.ParamByName('CODITE').AsString  := cdsOrdSer.FieldByName('ORD_CODITE').AsString;
          qryOrd.ParamByName('QTDSER').AsInteger := cdsOrdSer.FieldByName('ORD_QTDSER').AsInteger;
          qryOrd.ParamByName('LARGUR').AsFloat   := cdsOrdSer.FieldbyName('ORD_LARGUR').AsFloat;
          qryOrd.ParamByName('ALTURA').AsFloat   := cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat;
          qryOrd.ParamByName('TOT_M2').AsFloat   := cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat;
          qryOrd.ParamByName('TARJA_').AsString  := cdsOrdSer.FieldByName('ORD_TARJA_').AsString;
          qryOrd.ParamByName('RECLOC').AsString  := cdsOrdSer.FieldByName('ORD_RECLOC').AsString;
          qryOrd.ParambyName('SEQIND').AsInteger := cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger;

          If fEmptyStr(cdsOrdSer.FieldByName('ORD_OBSERV').AsString) Then
            qryOrd.ParamByName('OBSERV').Clear()
          Else
            qryOrd.ParamByName('OBSERV').AsString := cdsOrdSer.FieldByName('ORD_OBSERV').AsString;

          qryOrd.ExecSQL;

          cdsOrdSer.Next;
        End;

        cdsOrdSer.EnableControls();
      End;
    Except
      On E: Exception Do Begin
        Result := False;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryOrd);
  End;
end;

{**************************************}
{* BAIXA ORDEM DE SERVIȏ             *}
{***********************************AF*}
procedure TOrdSer.pBaixaManOrdSer;
  Var
    blnTemEti: Boolean;
    qryTemp: TUniQuery;
    strSQL: String;
Begin
  qryTemp   := fCriaQuery();

  Try
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'MARDES = ' + QuotedStr('M') + ' AND ORD_BAIXAD = ' + QuotedStr('N');
    cdsOrdSer.Filtered := True;

    cdsOrdSer.First();

    If Not cdsOrdSer.IsEmpty Then Begin
      If fMensagem('','Tem certeza que deseja baixar estes registros?',['&Sim','&Não']) = 1 Then
      Begin
        fStartTransaction;

        cdsOrdSer.DisableControls();

        While (Not cdsOrdSer.Eof) Do Begin
          strSQL := '';
          strSQL := strSQL + 'UPDATE                  ';
          strSQL := strSQL + '  ORDSER                ';
          strSQL := strSQL + 'SET                     ';
          strSQL := strSQL + '  ORD_BAIXAD = "S",     ';
          strSQL := strSQL + '  ORD_DTABAI = :DTABAI, ';
          strSQL := strSQL + '  ORD_OPEBAI = :OPEBAI  ';
          strSQL := strSQL + 'WHERE                   ';
          strSQL := strSQL + '  AUTOINCREM = :AUTINC  ';

          qryTemp.Close;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add(strSQL);
          qryTemp.ParamByName('DTABAI').AsDate   := VS_Date;
          qryTemp.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
          qryTemp.ParamByName('AUTINC').AsString := cdsOrdSer.FieldByName('AUTOINCREM').AsString;
          qryTemp.ExecSQL;
          qryTemp.Close;

          cdsOrdSer.Next();
        End;

        fCommit;

        fMensagem('','Registros baixados com sucesso!',['&OK']);

        {$IFNDEF LINUX}
        If fMensagem('Confirmação', 'Deseja imprimir a etiqueta?', ['&Sim','&Não']) = 1 Then
        Begin
          Self.fImprimeEtiquetas();
        End;
        {$ENDIF}

        cdsOrdSer.EmptyDataSet();

        pAtualizaDados('', '', VS_strCodEmp, '', 0);

        cdsOrdSer.EnableControls();
      End;
    End Else
      fMensagem('','Não há registros selecionados!', ['&OK']);

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := '' ;

    blnTemEti := fGetRegistrosParaImpressao;
  Except

    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(qryTemp);

{$IFNDEF LINUX}
  If blnTemEti Then
    fImprimeRegistroEtiquetas;
{$ENDIF}
End;

{**************************************}
{* VERIFICA SE EXISTE ALGUMA ORDEM DE *}
{* SERVIȏ BAIXADA                    *}
{***********************************AF*}
function TOrdSer.fExisteOrdemServicoBaixada(strNumDoc, strEspDoc: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try
    Result := False;
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT   ');
      SQL.Add('  *      ');
      SQL.Add('FROM     ');
      SQL.Add('  ORDSER ');
      SQL.Add('WHERE    ');
      SQL.Add('  ORD_NUMDOC = :NUMDOC AND ');
      SQL.Add('  ORD_ESPDOC = :ESPDOC AND ');
      SQL.Add('  ORD_BAIXAD = "S"         ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      Open;

      If Not IsEmpty Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

{**************************************}
{* CANCELA ORDSER PELO DOCUMENTO      *}
{***********************************AF*}
{$IFNDEF LINUX}
function TOrdSer.fAdicionarItemOrdemServico(AEditar: Boolean = False): Boolean;
begin
  Result := False;

  Try
    pCriarFormularios(TfrmFatQtdOrdSer,frmFatQtdOrdSer);

    Try
      frmFatQtdOrdSer.strNumOrc := FNumDoc;
      frmFatQtdOrdSer.strEspOrc := FEspDoc;
      frmFatQtdOrdSer.strEmpOrc := FCodEmp;
      frmFatQtdOrdSer.strCodIte := FCodIte;
      frmFatQtdOrdSer.strCodGru := FCodGru;
      frmFatQtdOrdSer.intSeqInd := FSeqInd;
      frmFatQtdOrdSer.blnTrava  := ((Not fEmptyStr(FNumDoc)) And (FEspDoc = 'PD'));
      frmFatQtdOrdSer.objOrdSer := Self;

      frmFatQtdOrdSer.FEditar := AEditar;

      Result := (frmFatQtdOrdSer.ShowModal = mrOK);

      If (Result) Then FTotGerM2 := frmFatQtdOrdSer.edtTotGerM2.Text;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TOrdSer.fAdicionarItemOrdemServico]');
    End;
  Finally
    pFreeAndNil(frmFatQtdOrdSer);
  End;
end;
{$ENDIF}

function TOrdSer.fCancelaOrdSer(strNumDoc, strEspDoc: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin

  Try
    Result := True;
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM ');
      SQL.Add('  ORDSER    ');
      SQL.Add('WHERE       ');
      SQL.Add('  ORD_NUMDOC = :NUMDOC AND ');
      SQL.Add('  ORD_ESPDOC = :ESPDOC     ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ExecSQL;
      Close;
    End;

    FreeAndNil(qryGen);
  Except
    Result := False;
    FreeAndNil(qryGen);
  End;

End;

{**************************************}
{* CRIA TEMPORARIA PARA GRAVAȃO      *}
{***********************************AF*}
procedure TOrdSer.pCriarCampos;
begin
  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_NUMORD'; DataType := ftString; Size := 06; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_NUMDOC'; DataType := ftString; Size := 12; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_ESPDOC'; DataType := ftString; Size := 02; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_DTACAD'; DataType := ftDateTime; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_CODITE'; DataType := ftString; Size := fTamCodIte; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_CODCLI'; DataType := ftString; Size := 08; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_QTDSER'; DataType := ftFloat; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_LARGUR'; DataType := ftFloat; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_ALTURA'; DataType := ftFloat; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_TOT_M2'; DataType := ftFloat; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_TARJA_'; DataType := ftString; Size := 01; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_RECLOC'; DataType := ftString; Size := 01; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_OBSERV'; DataType := ftString; Size := 40; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_BAIXAD'; DataType := ftString; Size := 01; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_OPEBAI'; DataType := ftString; Size := 03; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_DTABAI'; DataType := ftDateTime; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_SEQIND'; DataType := ftInteger; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'MARDES'; DataType := ftString; Size := 01; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_ITEDEL'; DataType := ftString; Size := 01; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_QTDETI'; DataType := ftInteger; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_DOCUME'; DataType := ftString; Size := 20; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_NOMCLI'; DataType := ftString; Size := 256; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_DESITE'; DataType := ftString; Size := 256; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'ORD_AJUSTE'; DataType := ftString; Size := 001; Required := False;
  End;

  With cdsOrdSer.FieldDefs.AddFieldDef Do Begin
    Name := 'RET_SEQIND'; DataType := ftString; Size := 001; Required := False;
  End;
end;

procedure TOrdSer.pCriarClientDataSet;
begin
  pCriarCampos();

  cdsOrdSer.CreateDataSet();
  cdsOrdSer.Open();

  (cdsOrdSer.FieldByName('ORD_LARGUR') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsOrdSer.FieldByName('ORD_ALTURA') As TFloatField).DisplayFormat := '#,##0.00';
  (cdsOrdSer.FieldByName('ORD_TOT_M2') As TFloatField).DisplayFormat := '#,##0.00';
end;

{**************************************}
{* RECARREGA OS DADOS DA TEMPORARIA   *}
{***********************************AF*}
procedure TOrdSer.pAjustarItensOrcamentoOrdSer(cdsVenda: TUniClientDataSet);
  Var
    strCodIte, strSeqInd: String;
begin
  Try
    cdsVenda.DisableControls();
    cdsVenda.First();

    If ((cdsVenda <> nil)) And (Not cdsVenda.IsEmpty) Then
    Begin
      While (Not cdsVenda.Eof) Do
      Begin
        strCodIte := cdsVenda.FieldByName('ITE_CODITE').AsString;
        strSeqInd := cdsVenda.FieldByName('ITE_SEQIND').AsString;

        If (cdsOrdSer.Locate('ORD_CODITE;ORD_SEQIND', VarArrayOf([strCodIte, strSeqInd]), [])) Then
        Begin
          cdsOrdSer.Edit();
          cdsOrdSer.FieldByName('ORD_AJUSTE').AsString := 'S';
          cdsOrdSer.Post();
        End;

        cdsVenda.Next();
      End;
    End;

    cdsOrdSer.DisableControls();
    cdsOrdSer.First();

    If (Assigned(cdsOrdSer)) And (Not cdsOrdSer.IsEmpty) Then
    Begin
      While (Not cdsOrdSer.Eof) Do
      Begin
        If (cdsOrdSer.FieldByName('ORD_AJUSTE').AsString = 'N') Then
        Begin
          cdsOrdSer.Delete();
          cdsOrdSer.First();
          Continue;
        End;

        cdsOrdSer.Next();
      End;
    End;
  Finally
    cdsVenda.EnableControls();
    cdsOrdSer.EnableControls();
  End;
end;

procedure TOrdSer.pAtualizaDados(strNumDoc, strEspDoc, strCodEmp, strCodIte: String; intSeqInd: Integer; blnConsulta: Boolean = True);
Begin

  If (blnConsulta) Then Begin
    With qryOrdSer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQL());

      If (Not fEmptyStr(strNumDoc)) Then
        SQL.Add('  AND ORD_NUMDOC = :NUMDOC ');

      If (Not fEmptyStr(strEspDoc)) Then
        SQL.Add('  AND ORD_ESPDOC = :ESPDOC ');

      If (Not fEmptyStr(strCodEmp)) Then
        SQL.Add('  AND ORD_CODEMP = :CODEMP ');

      If Not fEmptyStr(strCodIte) Then
      Begin
        SQL.Add('  AND ORD_CODITE = :CODITE ');
        SQL.Add('  AND ORD_SEQIND = :SEQIND ');

        ParamByName('SEQIND').AsInteger := intSeqInd;
        ParamByName('CODITE').AsString  := strCodIte;
      End;

      If (Not fEmptyStr(strNumDoc)) Then
        ParamByName('NUMDOC').AsString := strNumDoc;

      If (Not fEmptyStr(strEspDoc)) Then
        ParamByName('ESPDOC').AsString := strEspDoc;

      If (Not fEmptyStr(strCodEmp)) Then
        ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      (FieldByName('ORD_LARGUR') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ORD_ALTURA') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ORD_TOT_M2') As TFloatField).DisplayFormat := '#,##0.00';

      qryOrdSer.First();

      While (Not qryOrdSer.Eof) Do Begin
        If (Not cdsOrdSer.Locate('AUTOINCREM', qryOrdSer.FieldByName('AUTOINCREM').AsString, [])) Then Begin
          cdsOrdSer.Append();

          cdsOrdSer.FieldByName('MARDES').AsString     := 'D';
          cdsOrdSer.FieldByName('ORD_ITEDEL').AsString := 'N';
          cdsOrdSer.FieldByName('ORD_AJUSTE').AsString := 'N';
        End Else
          cdsOrdSer.Edit();

        cdsOrdSer.FieldByName('AUTOINCREM').AsString := qryOrdSer.FieldByName('AUTOINCREM').AsString;
        cdsOrdSer.FieldByName('ORD_NUMORD').AsString := qryOrdSer.FieldByName('ORD_NUMORD').AsString;
        cdsOrdSer.FieldByName('ORD_CODEMP').AsString := qryOrdSer.FieldByName('ORD_CODEMP').AsString;
        cdsOrdSer.FieldByName('ORD_NUMDOC').AsString := qryOrdSer.FieldByName('ORD_NUMDOC').AsString;
        cdsOrdSer.FieldByName('ORD_ESPDOC').AsString := qryOrdSer.FieldByName('ORD_ESPDOC').AsString;
        cdsOrdSer.FieldByName('ORD_TARJA_').AsString := qryOrdSer.FieldByName('ORD_TARJA_').AsString;
        cdsOrdSer.FieldByName('ORD_RECLOC').AsString := qryOrdSer.FieldByName('ORD_RECLOC').AsString;
        cdsOrdSer.FieldByName('ORD_OBSERV').AsString := qryOrdSer.FieldByName('ORD_OBSERV').AsString;
        cdsOrdSer.FieldByName('ORD_BAIXAD').AsString := qryOrdSer.FieldByName('ORD_BAIXAD').AsString;
        cdsOrdSer.FieldByName('ORD_OPEBAI').AsString := qryOrdSer.FieldByName('ORD_OPEBAI').AsString;
        cdsOrdSer.FieldByName('ORD_CODITE').AsString := qryOrdSer.FieldByName('ORD_CODITE').AsString;
        cdsOrdSer.FieldByName('ORD_CODCLI').AsString := qryOrdSer.FieldByName('ORD_CODCLI').AsString;

        cdsOrdSer.FieldByName('ORD_QTDSER').AsFloat  := qryOrdSer.FieldByName('ORD_QTDSER').AsFloat;
        cdsOrdSer.FieldByName('ORD_LARGUR').AsFloat  := qryOrdSer.FieldByName('ORD_LARGUR').AsFloat;
        cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat  := qryOrdSer.FieldByName('ORD_ALTURA').AsFloat;
        cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat  := qryOrdSer.FieldByName('ORD_TOT_M2').AsFloat;

        cdsOrdSer.FieldByName('ORD_DOCUME').AsString   := qryOrdSer.FieldByName('ORD_DOCUME').AsString;
        cdsOrdSer.FieldByName('ORD_NOMCLI').AsString   := qryOrdSer.FieldByName('ORD_NOMCLI').AsString;
        cdsOrdSer.FieldByName('ORD_DESITE').AsString   := qryOrdSer.FieldByName('ORD_DESITE').AsString;

        cdsOrdSer.FieldByName('ORD_DTACAD').AsDateTime := qryOrdSer.FieldByName('ORD_DTACAD').AsDateTime;
        cdsOrdSer.FieldByName('ORD_DTABAI').AsDateTime := qryOrdSer.FieldByName('ORD_DTABAI').AsDateTime;

        cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger := qryOrdSer.FieldByName('ORD_SEQIND').AsInteger;
        cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger := qryOrdSer.FieldByName('ORD_QTDETI').AsInteger;

        cdsOrdSer.Post();

        qryOrdSer.Next();
      End;
    End;

    If (Not fEmptyStr(strEspDoc)) And (strEspDoc = 'OR') Then Begin
      With qryOrdSer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSQL_FATGOS());

        If (Not fEmptyStr(strNumDoc)) Then
          ParamByName('NUMDOC').AsString := strNumDoc;

        If (Not fEmptyStr(strEspDoc)) Then
          ParamByName('ESPDOC').AsString := strEspDoc;

        If (Not fEmptyStr(strCodEmp)) Then
          ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        (FieldByName('FGO_LARGUR') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('FGO_ALTURA') As TFloatField).DisplayFormat := '#,##0.00';
        (FieldByName('FGO_TOT_M2') As TFloatField).DisplayFormat := '#,##0.00';

        qryOrdSer.First();

        While (Not qryOrdSer.Eof) Do Begin
          If (Not cdsOrdSer.Locate('AUTOINCREM', qryOrdSer.FieldByName('AUTOINCREM').AsString, [])) Then Begin
            cdsOrdSer.Append();

            cdsOrdSer.FieldByName('MARDES').AsString     := 'D';
            cdsOrdSer.FieldByName('ORD_ITEDEL').AsString := 'N';
            cdsOrdSer.FieldByName('ORD_AJUSTE').AsString := 'N';
          End Else
            cdsOrdSer.Edit();

          cdsOrdSer.FieldByName('AUTOINCREM').AsString := qryOrdSer.FieldByName('AUTOINCREM').AsString;
          cdsOrdSer.FieldByName('ORD_NUMORD').AsString := '';
          cdsOrdSer.FieldByName('ORD_CODEMP').AsString := qryOrdSer.FieldByName('FGO_CODEMP').AsString;
          cdsOrdSer.FieldByName('ORD_NUMDOC').AsString := qryOrdSer.FieldByName('FGO_NUMDOC').AsString;
          cdsOrdSer.FieldByName('ORD_ESPDOC').AsString := qryOrdSer.FieldByName('FGO_ESPDOC').AsString;
          cdsOrdSer.FieldByName('ORD_TARJA_').AsString := qryOrdSer.FieldByName('FGO_TARJA_').AsString;
          cdsOrdSer.FieldByName('ORD_RECLOC').AsString := qryOrdSer.FieldByName('FGO_RECLOC').AsString;
          cdsOrdSer.FieldByName('ORD_OBSERV').AsString := qryOrdSer.FieldByName('FGO_OBSERV').AsString;
          cdsOrdSer.FieldByName('ORD_BAIXAD').AsString := 'N';
          cdsOrdSer.FieldByName('ORD_OPEBAI').AsString := '';
          cdsOrdSer.FieldByName('ORD_CODITE').AsString := qryOrdSer.FieldByName('FGO_CODITE').AsString;
          cdsOrdSer.FieldByName('ORD_CODCLI').AsString := '';

          cdsOrdSer.FieldByName('ORD_QTDSER').AsFloat  := qryOrdSer.FieldByName('FGO_QTDSER').AsFloat;
          cdsOrdSer.FieldByName('ORD_LARGUR').AsFloat  := qryOrdSer.FieldByName('FGO_LARGUR').AsFloat;
          cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat  := qryOrdSer.FieldByName('FGO_ALTURA').AsFloat;
          cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat  := qryOrdSer.FieldByName('FGO_TOT_M2').AsFloat;

          cdsOrdSer.FieldByName('ORD_DOCUME').AsString := '';
          cdsOrdSer.FieldByName('ORD_NOMCLI').AsString := '';
          cdsOrdSer.FieldByName('ORD_DESITE').AsString := '';

          cdsOrdSer.FieldByName('ORD_DTACAD').AsDateTime := qryOrdSer.FieldByName('FGO_DTACAD').AsDateTime;
          cdsOrdSer.FieldByName('ORD_DTABAI').AsDateTime := 0;

          cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger := qryOrdSer.FieldByName('FGO_SEQIND').AsInteger;

          cdsOrdSer.Post();

          qryOrdSer.Next();
        End;
      End;
    End;
  End;

  cdsOrdSer.Filtered := False;
  cdsOrdSer.Filter   := ' 1=1 ';

  If (Not fEmptyStr(strNumDoc)) Then
    cdsOrdSer.Filter := cdsOrdSer.Filter + ' AND ORD_NUMDOC = ' + QuotedStr(strNumDoc);

  If (Not fEmptyStr(strEspDoc)) Then
    cdsOrdSer.Filter := cdsOrdSer.Filter + ' AND ORD_ESPDOC = ' + QuotedStr(strEspDoc);

  If (Not fEmptyStr(strCodEmp)) Then
    cdsOrdSer.Filter := cdsOrdSer.Filter + ' AND ORD_CODEMP = ' + QuotedStr(strCodEmp);

  If Not fEmptyStr(strCodIte) Then Begin
    cdsOrdSer.Filter := cdsOrdSer.Filter + ' AND ORD_CODITE = ' + QuotedStr(strCodIte);
    cdsOrdSer.Filter := cdsOrdSer.Filter + ' AND ORD_SEQIND = ' + QuotedStr(IntToStr(intSeqInd));
  End;

  cdsOrdSer.Filtered := True;
End;

{$IFNDEF LINUX}
procedure TOrdSer.pAtualizarQtdEti(blnLimpar: Boolean);
Begin
  FLimpar := blnLimpar;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAtualizarQtdEtiInterna;
    frmGravando.lblGravando.Caption := 'Atualizando quantidade de etiquetas...';
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

End;
{$ENDIF}

function TOrdSer.fAtualizarQtdEtiInterna(cxProgressBar : TcxProgressBar) : Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Result := True;
  Try
    qryTemp := fCriaQuery();

    Try
      fStartTransaction();

      cdsOrdSer.DisableControls();

      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := 'MARDES = ' + QuotedStr('M') + ' AND ORD_QTDETI > 0';
      cdsOrdSer.Filtered := True;

      cxProgressBar.Properties.Max := cdsOrdSer.RecordCount;

      cdsOrdSer.First();

      While (Not cdsOrdSer.Eof) Do Begin
        If (cdsOrdSer.FieldByName('MARDES').AsString = 'M') And (cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger > 0) Then Begin
          qryTemp.Close();
          qryTemp.SQL.Clear();
          qryTemp.SQL.Text := 'UPDATE ORDSER SET ORD_QTDETI = :QTDETI WHERE AUTOINCREM = :AUTINC';
          qryTemp.ParamByName('AUTINC').AsString  := cdsOrdSer.FieldByName('AUTOINCREM').AsString;

          If (FLimpar) Then Begin
            qryTemp.ParamByName('QTDETI').AsInteger := 0;

            cdsOrdSer.Edit();
            cdsOrdSer.FieldByName('MARDES').AsString := 'D';
            cdsOrdSer.Post();
          End Else
            qryTemp.ParamByName('QTDETI').AsInteger := cdsOrdSer.FieldByName('ORD_QTDETI').AsInteger;

          qryTemp.ExecSQL();
        End;

        cxProgressBar.Position := cxProgressBar.Position + 1;
        Application.ProcessMessages;
        cdsOrdSer.Next();
      End;

      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := '';

      cdsOrdSer.EnableControls();

      fCommit();
    Except
      On E: Exception Do Begin
        fRollback();
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End
end;

procedure TOrdSer.pAtualizaSeqIndItens(cdsVenda: TUniClientDataSet);
begin
  If ((cdsVenda <> nil)) Then Begin
    cdsOrdSer.DisableControls();
    cdsOrdSer.First();

    While (Not cdsOrdSer.Eof) Do Begin
      cdsOrdSer.Edit();
      cdsOrdSer.FieldByName('RET_SEQIND').AsString := 'N';
      cdsOrdSer.Post();

      cdsOrdSer.Next();
    End;

    cdsOrdSer.EnableControls();

    cdsVenda.DisableControls();
    cdsVenda.First();

    While (Not cdsVenda.Eof) Do Begin
      If (cdsVenda.FieldByName('ITE_SEQORS').AsInteger = 0) Then Begin
        cdsVenda.Edit();
        cdsVenda.FieldByName('ITE_SEQORS').AsInteger := fGetSeqIndProduto(cdsVenda.FieldByName('ITE_CODITE').AsString);
        cdsVenda.Post();
      End;

      cdsVenda.Next();
    End;

    cdsVenda.EnableControls();
  End;
end;

{$IFNDEF LINUX}
Function TOrdSer.fImprimeRegistroEtiquetas: Boolean;
  Var
    i: Integer;
    prmDllEtq: TParamDllEtiquetas;
    strTipImp: String;
    cdsEtiOrd: TUniClientDataSet;

  procedure pCriarCamposEti;
  begin
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'NUMORD'; DataType := ftString; Size := 006; Required := False; End;
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'CODCLI'; DataType := ftString; Size := 008; Required := False; End;
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'TOT_M2'; DataType := ftFloat;               Required := False; End;
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 120; Required := False; End;
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'NOMCLI'; DataType := ftString; Size := 120; Required := False; End;
    With cdsEtiOrd.FieldDefs.AddFieldDef Do Begin Name := 'SEQDET'; DataType := ftString; Size := 050; Required := False; End;
  end;

  procedure pCriarClientDataSetEti;
  begin
    cdsEtiOrd := TUniClientDataSet.Create(Nil);

    pCriarCamposEti();

    cdsEtiOrd.CreateDataSet();
    cdsEtiOrd.Open();

    (cdsEtiOrd.FieldByName('TOT_M2') As TFloatField).DisplayFormat := '#,##0.00';
  end;

Begin
  Try
    Result    := True;
    strTipImp := fCfgSis('ETIOSV', varString);
    prmDllEtq := TParamDllEtiquetas.Create;

    Try
      pAtualizarQtdEti(False);
      pInicializarQryImpEti();

      pCriarClientDataSetEti();

      cdsOrdSer.DisableControls;
      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := 'MARDES = ' + QuotedStr('M') + ' AND ORD_QTDETI > 0';
      cdsOrdSer.Filtered := True;

      cdsOrdSer.First();

      While (Not cdsOrdSer.Eof) Do Begin

        qryImpEti.Close;
        qryImpEti.ParamByName('AUTINC').AsString := cdsOrdSer.FieldByName('AUTOINCREM').AsString;
        qryImpEti.Open;

        For i := 1 To qryImpEti.FieldByName('QTDETI').AsInteger Do Begin

          cdsEtiOrd.Append();

          cdsEtiOrd.FieldByName('NUMORD').AsString  := qryImpEti.FieldByName('NUMORD').AsString;
          cdsEtiOrd.FieldByName('CODITE').AsString  := qryImpEti.FieldByName('CODITE').AsString;
          cdsEtiOrd.FieldByName('CODCLI').AsString  := qryImpEti.FieldByName('CODCLI').AsString;
          cdsEtiOrd.FieldByName('DESITE').AsString  := qryImpEti.FieldByName('DESITE').AsString;
          cdsEtiOrd.FieldByName('NOMCLI').AsString  := qryImpEti.FieldByName('NOMCLI').AsString;
          cdsEtiOrd.FieldByName('TOT_M2').AsFloat   := qryImpEti.FieldByName('TOT_M2').AsFloat;
          cdsEtiOrd.FieldByName('SEQDET').AsString  := IntToStr(i) + '/' + IntToStr(qryImpEti.FieldByName('QTDETI').AsInteger);

          cdsEtiOrd.Post();
        End;

        cdsOrdSer.Next();
      End;

      If strTipImp = 'L' Then
        prmDllEtq.tpeTipEtq := tpeOrdemServicoVendaLaser
      Else If strTipImp = 'A' Then
        prmDllEtq.tpeTipEtq := tpeOrdemServicoVendaArgox
      Else If strTipImp = 'Z' Then
        prmDllEtq.tpeTipEtq := tpeOrdemServicoVendaZebra;

      prmDllEtq.dtsImpres := cdsEtiOrd;
      fImprimeEtiqueta(prmDllEtq); //'fimprimeetiquetas'

      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := '';
      cdsOrdSer.EnableControls;

      pAtualizarQtdEti(True);

      cdsOrdSer.EmptyDataSet;
      pCarregaManOrdSer(odTodos);
      //pAtualizaDados('', '', VS_strCodEmp, '', 0);

      qryImpEti.Close();
    Except
      On E: Exception Do Begin
        Result := False;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(cdsEtiOrd);
    FreeAndNil(prmDllEtq);
  End;
End;
{$ENDIF}

function TOrdSer.fPossuiItensAjuste: Boolean;
begin
  Result := False;

  Try
    cdsOrdSer.DisableControls();

    Try
      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := ' ORD_AJUSTE = ' + QuotedStr('S') + ' ';
      cdsOrdSer.Filtered := True;

      Result := (cdsOrdSer.RecordCount > 0);

      cdsOrdSer.Filtered := False;
      cdsOrdSer.Filter   := '';
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    cdsOrdSer.EnableControls();
  End;
end;

function TOrdSer.fSalvarDados(strNumDoc, strEspDoc, strNumOrc, strEspOrc, strCodCli: String): Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQueryFatGos(blnPossuiAjuste: Boolean);
  begin
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('DELETE   ');
    qryTemp.SQL.Add('FROM     ');
    qryTemp.SQL.Add('  FATGOS ');
    qryTemp.SQL.Add('WHERE    ');
    qryTemp.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
    qryTemp.SQL.Add('  FGO_ESPDOC = :ESPDOC     ');

    If (blnPossuiAjuste) Then
    Begin
      qryTemp.SQL.Add('  AND FGO_CODITE = :CODITE ');
      qryTemp.SQL.Add('  AND FGO_SEQIND = :SEQIND ');

      qryTemp.ParamByName('CODITE').AsString := cdsOrdSer.FieldByName('ORD_CODITE').AsString;
      qryTemp.ParamByName('SEQIND').AsString := cdsOrdSer.FieldByName('ORD_SEQIND').AsString;
    End;

    qryTemp.ParamByName('NUMDOC').AsString := strNumOrc;
    qryTemp.ParamByName('ESPDOC').AsString := strEspOrc;
    qryTemp.ExecSQL;
    qryTemp.Close;
  end;
begin
  Result := True;

  Try
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := '';

    qryTemp := fCriaQuery(Nil);

    Try
      If (Not cdsOrdSer.IsEmpty) Then Begin
        qryTemp.Close;
        qryTemp.SQL.Clear;
        qryTemp.SQL.Add('DELETE   ');
        qryTemp.SQL.Add('FROM     ');
        qryTemp.SQL.Add('  ORDSER ');
        qryTemp.SQL.Add('WHERE    ');
        qryTemp.SQL.Add('  ORD_NUMDOC = :NUMDOC AND ');
        qryTemp.SQL.Add('  ORD_ESPDOC = :ESPDOC     ');
        qryTemp.ParamByName('NUMDOC').AsString := strNumDoc;
        qryTemp.ParamByName('ESPDOC').AsString := strEspDoc;
        qryTemp.ExecSQL;
        qryTemp.Close;

        If (Not fEmptyStr(strNumOrc)) And (strEspOrc = 'OR') Then
        Begin
          If (fPossuiItensAjuste()) Then
          Begin
            cdsOrdSer.DisableControls();
            cdsOrdSer.First();

            While (Not cdsOrdSer.Eof) Do
            Begin
              pInicializarQueryFatGos(True);
              cdsOrdSer.Next();
            End;

            cdsOrdSer.EnableControls();
          End
          Else
            pInicializarQueryFatGos(True);
        End;

        cdsOrdSer.DisableControls();
        cdsOrdSer.First();

        While (Not cdsOrdSer.Eof) Do Begin
          qryTemp.Close();
          qryTemp.SQL.Clear();
          qryTemp.SQL.Text := fGetSQLInsert();

          qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('ORDSER', VS_strCodEmp);
          qryTemp.ParamByName('NUMORD').AsString := fAtualizaProCod('ORDSER', 'ORD_NUMORD');
          qryTemp.ParamByName('BAIXAD').AsString := 'N';
          qryTemp.ParamByName('DTABAI').Clear();
          qryTemp.ParamByName('OPEBAI').Clear();

          qryTemp.ParamByName('CODEMP').AsString   := cdsOrdSer.FieldByName('ORD_CODEMP').AsString;
          qryTemp.ParamByName('NUMDOC').AsString   := strNumDoc;
          qryTemp.ParamByName('ESPDOC').AsString   := strEspDoc;
          qryTemp.ParamByName('TARJA_').AsString   := cdsOrdSer.FieldByName('ORD_TARJA_').AsString;
          qryTemp.ParamByName('RECLOC').AsString   := cdsOrdSer.FieldByName('ORD_RECLOC').AsString;
          qryTemp.ParamByName('OBSERV').AsString   := cdsOrdSer.FieldByName('ORD_OBSERV').AsString;
          qryTemp.ParamByName('CODITE').AsString   := cdsOrdSer.FieldByName('ORD_CODITE').AsString;
          qryTemp.ParamByName('CODCLI').AsString   := strCodCli;
          qryTemp.ParamByName('QTDSER').AsFloat    := cdsOrdSer.FieldByName('ORD_QTDSER').AsFloat;
          qryTemp.ParamByName('LARGUR').AsFloat    := cdsOrdSer.FieldByName('ORD_LARGUR').AsFloat;
          qryTemp.ParamByName('ALTURA').AsFloat    := cdsOrdSer.FieldByName('ORD_ALTURA').AsFloat;
          qryTemp.ParamByName('TOT_M2').AsFloat    := cdsOrdSer.FieldByName('ORD_TOT_M2').AsFloat;
          qryTemp.ParamByName('DTACAD').AsDateTime := Trunc(fNow());
          qryTemp.ParamByName('SEQIND').AsInteger  := cdsOrdSer.FieldByName('ORD_SEQIND').AsInteger;

          cdsOrdSer.Edit();
          cdsOrdSer.FieldByName('ORD_NUMORD').AsString := qryTemp.ParamByName('NUMORD').AsString;
          cdsOrdSer.FieldByName('ORD_CODCLI').AsString := strCodCli;
          cdsOrdSer.FieldByName('ORD_NOMCLI').AsString := fRetNomCliente(strCodCli);
          cdsOrdSer.Post();

          qryTemp.ExecSQL();

          cdsOrdSer.Next();
        End;

        cdsOrdSer.EnableControls();
      End;
    Except
      On E: Exception Do Begin
        Result := False;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

{$IFNDEF LINUX}
Function TOrdSer.fImprimeEtiquetas: Boolean;
Begin
  If not fGetRegistrosParaImpressao Then
  Begin
    fMensagem('','Não existe registro marcado para impressão!', ['&OK']);
    Exit(False);
  End;

  Result := fImprimeRegistroEtiquetas;

End;
{$ENDIF}

end.
