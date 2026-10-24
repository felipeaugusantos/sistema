unit untCadCotacao;

interface

uses
  Windows, Classes, untPaiOrdena, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons,
  untConstantes, cxProgressBar, BitBtnLockedIncrem, MemDS, DBAccess, StdCtrls,
  Provider, Controls, frxClass, frxExportCSVTestabilidade, untIZClient,
  untFuncoesPedidoSimples, untFuncoes, untModulo, Variants,
     Datasnap.DBClient;

type
  TfrmCadCotacao = class(TfrmPaiOrdena)
    rdgStatus: TRadioGroup;
    btnIncluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnIncHer: TBitBtnLocked;
    btnExibirDetMultLoja: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncHerClick(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExibirDetMultLojaClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    FAutGer,
    FSeqGer: String;

    blnMulLoj: Boolean;

    strCodCmp: String;

    strLisPed: String;

    opeOperac: TTipoOperacao;

    blnGerarPedidos: Boolean;

    blnConverterEmbalagens: Boolean;

    function fGravaPedidoCompra(strNumCot,
                                strEmpCot,
                                strCodFor,
                                strNomEmpLoj,
                                strEndEmpLoj,
                                strCidEmpLoj,
                                strMulLoj,
                                strEmpDes: String;
                                blnDesmem: Boolean): Boolean;

    function fGravaPedidoCompraDesmembrado(strNumCot, strEmpCot, strCodFor: String): Boolean;

    function fCriaFormsCotacao: Boolean;

    function fGeraPedidosCompra(strNumCot, strEmpCot: String): Boolean;
    function fIncluiComHeranca(Var strAutInc: String): Boolean;
    function fAbreCotacao(opeOperacao: TTipoOperacao): Boolean;

    function fGravaItens(strAutInc: String): Boolean;
    function fExcluiItens(strAutInc: String): Boolean;
    function fIncluiItens(pgbProgresso: TcxProgressBar): Boolean;
    Function fIncluiItensProgresso(strAutInc: String): Boolean;
    function fSqlIncluiItens: String;

    function fGravaFornecedores(strAutInc: String): Boolean;
    function fExcluiFornecedores(strAutInc: String): Boolean;
    function fIncluiFornecedores(strAutInc: String): Boolean;
    function fSqlIncluiFornecedores: String;

    function fSalvaCotacao(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fGravaItensFornecedor(strAutInc: String): Boolean;
    function fExcluiItensFornecedor(strAutInc: String): Boolean;
    function fIncluiItensFornecedor(strAutInc: String): Boolean;
    function fSqlIncluiItensFornecedor: String;
    function fIncluiItensHeranca(strAutInc, strSeqGer: String): Boolean;
    function fIncluiFornecedoresHeranca(strAutInc, strSeqGer: String): Boolean;
    function fIncluiItensFornecHeranca(strAutInc, strSeqGer: String): Boolean;

    function fApagaCotacao(strAutInc: String): Boolean;
    function fAtualizaCotacao(strAutInc,
                              strDescri,
                              strCompra: String;
                              strMesAtu: String;
                              intMesGir,
                              intMesMos: Integer;
                              blnBaixar: Boolean): Boolean;

    function fIncluiCotacao(strAutInc,
                            strNumCot,
                            strDescri,
                            strCompra,
                            strMulLoj,
                            strMesAtu: String;
                            intMesGir,
                            intMesMos: Integer;
                            blnBaixar: Boolean): Boolean;

    function fIniciaPedidoCompra(    strCodFor,
                                     strCompra,
                                     strNumCot,
                                     strEmpCot,
                                     strNomEmpLoj,
                                     strEndEmpLoj,
                                     strCidEmpLoj,
                                     strMulLoj,
                                     strEmpDes: String;
                                 Var strNumPed,
                                     strConPag: String;
                                 Var dtaDtaPed,
                                     horHorPed,
                                     dtaDtaEnt: TDateTime;
                                     blnDesmem: Boolean): Boolean;

    function fGravaItem(strCodFor,
                        strNumPed,
                        strConPag: String;
                        dtaDtaPed,
                        horHorPed,
                        dtaDtaEnt: TDateTime;
                        strCodIte,
                        strCodUni,
                        strDesIte,
                        strRefere,
                        strSigUni: String;
                        fltQtdIte,
                        fltValUni,
                        fltIpiEnt,
                        fltSubsti: Double;
                        blnMulLoj: Boolean): Boolean;

    procedure pHabilitaBotoes(blnHabilita: Boolean);
    Procedure pDestroiFormsCotacao;

    procedure pAtuRequisicao(strCot_SeqCot, strCot_SeqReq: String);
    procedure pLimpaRequisicao(strAutInc: String);
    procedure pIncluiPcmIrq(strAutIncPcd, strCodIte: String);

    function fCarregaDadosCompraEmbalagem(const strCodIte: String;
      var strCodUni, strSigUni: String; var fltEmbala: Double): Boolean;

    procedure pGravarPcdDetCot(strCodIte,
                               strEmpDes: String;
                               fltQtdIte: Double;
                               strSeqCot: String);

    procedure pGravarPcdDetCotItem(cdsItensMultLoj: TUniClientDataSet; strCodIte, strSeqCot: String);

    Procedure pLoadFuncoesPedido;

  public
    { Public declarations }
    hwdDllPedido: Cardinal;
    pInicializaDll: TInicializaDllPedidoDeCompra;
    dxInitializePedCom: procedure;
    dxFinalizePedCom  : procedure;

    fRetornaProdutosGiroCotacao: function(Var recDadosGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;stdcall;

    fCarregaCotacaoMultiLojas: function (Var recDadosGiro: TRecOpcoesGiro; Var oleItensGiro: OleVariant): OleVariant;stdcall;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetFilter: String;  Override;
    Procedure pSetFilterDefault;  Override;
  end;

var
  frmCadCotacao: TfrmCadCotacao;

implementation

uses SysUtils, Math, Forms, untFuncoesSimples, untCadCotacaoGeral, untCadCotItens,
  untCadCotFornecedor, untCadCotItensFornec, untCadCotComparativo, untGravando,
  untGravacaoPedido, untCadCotAtuPrecos, untInicializaDllPedido, untGridListaCotacoesMultiLoja;

{$R *.dfm}

function TfrmCadCotacao.fGetSql(blnLike: Boolean): String;
Begin

  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   G.*, ';
  Result := Result + '     (SELECT SUM(I.COT_QTDITE * F.COT_VALUNI) + ';
  Result := Result + '             SUM(I.COT_QTDITE * F.COT_VALUNI)/100 * IFNULL(F.COT_SUBSTI, 0) + ';
  Result := Result + '             SUM(I.COT_QTDITE * F.COT_VALUNI)/100 * IFNULL(F.COT_IPIENT, 0) ';
  Result := Result + '        FROM COTITE I,  ';
  Result := Result + '             COTFOR F  ';
  Result := Result + '       WHERE I.COT_SEQGER = G.AUTOINCREM ';
  Result := Result + '         AND F.COT_SEQGER = G.AUTOINCREM ';
  Result := Result + '         AND F.COT_CODITE = I.COT_CODITE ';
  Result := Result + '         AND F.COT_STATUS = "1") AS COT_VLRTOT ';
  Result := Result + '   FROM ';
  Result := Result + '   COTGER G ';

  Case rdgStatus.ItemIndex Of
    0: Result := Result + ' WHERE COT_DTAFIN IS NULL ';
    1: Result := Result + ' WHERE COT_DTAFIN IS NOT NULL ';
  End;

End;

procedure TfrmCadCotacao.FormShow(Sender: TObject);
begin
  inherited;

  blnTemSelecao       := False;
  blnSempreRelerBanco := False;

  blnGerarPedidos := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pHabilitaBotoes(fAbreConsulta(TRUE));
  pSetFocus(btnIncluir);
end;

function TfrmCadCotacao.fExcluiItens(strAutInc: String): Boolean;
  Var
    qryItens: TUniQuery;
Begin
  Try

    Result := TRUE;
    If Not fEmptyStr(strAutInc) Then
    Begin
      pLimpaRequisicao(strAutInc);

      qryItens := fCriaQuery;
      With qryItens, SQL Do
      Begin
        Clear;
        Add('DELETE FROM COTITE');
        Add('WHERE COT_SEQGER = :SEQGER');
        ParamByName('SEQGER').AsString := strAutInc;
        ExecSQL;

        Clear;
        Add('DELETE FROM PCDCOT');
        Add('WHERE PCD_SEQGER = :SEQGER');
        ParamByName('SEQGER').AsString := strAutInc;
        ExecSQL;

        Result := TRUE;
      End;
      FreeAndNil(qryItens);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExcluiItens]');
    End;
  End;
End;

function TfrmCadCotacao.fSqlIncluiItens: String;
Begin
  Result := '';
  Result := Result + ' INSERT INTO COTITE (';
  Result := Result + '   AUTOINCREM, ';
  Result := Result + '   COT_SEQGER, ';
  Result := Result + '   COT_CODITE, ';
  Result := Result + '   COT_QTDITE, ';
  Result := Result + '   COT_DESITE, ';
  Result := Result + '   COT_PJAATU ';
  Result := Result + ' ) VALUES ( ';
  Result := Result + '   :AUTINC, ';
  Result := Result + '   :SEQGER, ';
  Result := Result + '   :CODITE, ';
  Result := Result + '   :QTDITE, ';
  Result := Result + '   :DESITE, ';
  Result := Result + '   :PJAATU) ';
End;

Function TfrmCadCotacao.fIncluiItensProgresso(strAutInc: String): Boolean;
  Var
    frmGravando2: TfrmGravando;
Begin
  FSeqGer := strAutInc;

  Try
    pCriarFormularios(TfrmGravando, frmGravando2);
    frmGravando2.lblGravando.Caption := 'Gravando Itens...';
    frmGravando2.fExecutarAcao := fIncluiItens;
    frmGravando2.ShowModal;

    Result := frmGravando2.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadCotacao.fIncluiItensProgresso]');
    End;
  End;

  pFreeAndNil(frmGravando2);
End;

function TfrmCadCotacao.fIncluiItens(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryItens: TUniQuery;
    strSeqReq,
    strAutIncCotIte: String;
Begin
  Try
    pgbProgresso.Properties.Max := frmCadCotItens.cdsConsulta.RecordCount;
    Application.ProcessMessages;

    Result := TRUE;
    If Not fEmptyStr(FSeqGer) Then
    Begin
      qryItens := fCriaQuery;
      qryItens.SQL.Text := fSqlIncluiItens;

      frmCadCotItens.cdsConsulta.DisableControls;
      frmCadCotItens.cdsConsulta.First;
      While Not frmCadCotItens.cdsConsulta.Eof Do
      Begin
        strAutIncCotIte := fRetAutoIncrem('COTITE', VS_strCodEmp);
        qryItens.ParamByName('AUTINC').AsString := strAutIncCotIte;
        qryItens.ParamByName('SEQGER').AsString := FSeqGer;
        qryItens.ParamByName('CODITE').AsString := frmCadCotItens.cdsConsulta.FieldByName('CODITE').AsString;
        qryItens.ParamByName('DESITE').AsString := frmCadCotItens.cdsConsulta.FieldByName('DESITE').AsString;
        qryItens.ParamByName('PJAATU').AsString := frmCadCotItens.cdsConsulta.FieldByName('PJAATU').AsString;
        qryItens.ParamByName('QTDITE').AsFloat  := frmCadCotItens.cdsConsulta.FieldByName('QTDITE').AsFloat;
        qryItens.ExecSQL;

        If Assigned(frmCadCotItens.cdsItensMultiLojas) Then
          pGravarPcdDetCotItem(frmCadCotItens.cdsItensMultiLojas,
                               frmCadCotItens.cdsConsulta.FieldByName('CODITE').AsString,
                               FSeqGer);

        For strSeqReq In frmCadCotItens.fGetRequisicoes(frmCadCotItens.cdsConsulta.FieldByName('CODITE').AsString) Do
          pAtuRequisicao(strAutIncCotIte, strSeqReq);

        frmCadCotItens.cdsConsulta.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      If Assigned(frmCadCotItens.cdsItensMultiLojas) Then
        frmCadCotItens.cdsItensMultiLojas.Filtered := False;

      Result := TRUE;
      frmCadCotItens.cdsConsulta.EnableControls;
      FreeAndNil(qryItens);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      frmCadCotItens.cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[fIncluiItens]');
    End;
  End;

End;

function TfrmCadCotacao.fGravaItens(strAutInc: String): Boolean;
Begin
  Result := fExcluiItens(strAutInc) And fIncluiItensProgresso(strAutInc);
End;

function TfrmCadCotacao.fExcluiFornecedores(strAutInc: String): Boolean;
  Var
    qryCfo: TUniQuery;
Begin
  Try

    Result := TRUE;
    If Not fEmptyStr(strAutInc) Then
    Begin
      qryCfo := fCriaQuery;
      With qryCfo, SQL Do
      Begin
        Clear;
        Add('DELETE FROM COTCFO');
        Add('WHERE COT_SEQGER = :SEQGER');
        ParamByName('SEQGER').AsString := strAutInc; 
        ExecSQL;
        Result := TRUE;
      End;
      FreeAndNil(qryCfo);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExcluiFornecedores]');
    End;
  End;
End;

function TfrmCadCotacao.fSqlIncluiFornecedores: String;
Begin
  Result := '';
  Result := Result + ' INSERT INTO COTCFO (';
  Result := Result + '   COT_SEQGER, ';
  Result := Result + '   COT_CODFOR, ';
  Result := Result + '   COT_UTILIZ, ';
  Result := Result + '   COT_CONPAG, ';
  Result := Result + '   COT_DTAENT  ';
  Result := Result + ' ) VALUES ( ';
  Result := Result + '   :SEQGER, ';
  Result := Result + '   :CODFOR, ';
  Result := Result + '   :UTILIZ, ';  
  Result := Result + '   :CONPAG, ';
  Result := Result + '   :DTAENT) ';
End;

function TfrmCadCotacao.fIncluiFornecedores(strAutInc: String): Boolean;
  Var
    qryCfo: TUniQuery;
Begin
  Try

    Result := TRUE;
    If Not fEmptyStr(strAutInc) Then
    Begin
      qryCfo := fCriaQuery;
      qryCfo.SQL.Text := fSqlIncluiFornecedores;

      frmCadCotFornecedor.cdsConsulta.DisableControls;
      frmCadCotFornecedor.cdsConsulta.First;
      While Not frmCadCotFornecedor.cdsConsulta.Eof Do
      Begin
        qryCfo.ParamByName('SEQGER').AsString := strAutInc; 
        qryCfo.ParamByName('CODFOR').AsString := frmCadCotFornecedor.cdsConsulta.FieldByName('CODFOR').AsString;
        qryCfo.ParamByName('UTILIZ').AsString := frmCadCotFornecedor.cdsConsulta.FieldByName('UTILIZ').AsString;        
        qryCfo.ParamByName('CONPAG').AsString := frmCadCotFornecedor.cdsConsulta.FieldByName('CONPAG').AsString;
        qryCfo.ParamByName('DTAENT').AsDate   := frmCadCotFornecedor.cdsConsulta.FieldByName('DTAENT').AsDateTime;
        qryCfo.ExecSQL;
        frmCadCotFornecedor.cdsConsulta.Next;
      End;
      Result := TRUE;
      frmCadCotFornecedor.cdsConsulta.EnableControls;
      FreeAndNil(qryCFO);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      frmCadCotItens.cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[fIncluiFornecedores]');
    End;
  End;

End;

function TfrmCadCotacao.fGravaFornecedores(strAutInc: String): Boolean;
Begin
  Result := fExcluiFornecedores(strAutInc) And fIncluiFornecedores(strAutInc);
End;

function TfrmCadCotacao.fExcluiItensFornecedor(strAutInc: String): Boolean;
  Var
    qryItens: TUniQuery;
Begin
  Try

    Result := TRUE;
    If Not fEmptyStr(strAutInc) Then
    Begin
      qryItens := fCriaQuery;
      With qryItens, SQL Do
      Begin
        Clear;
        Add('DELETE FROM COTFOR');
        Add('WHERE COT_SEQGER = :SEQGER');
        ParamByName('SEQGER').AsString := strAutInc; 
        ExecSQL;
        Result := TRUE;
      End;
      FreeAndNil(qryItens);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExcluiItensFornecedor]');
    End;
  End;

End;

function TfrmCadCotacao.fSqlIncluiItensFornecedor: String;
Begin
  Result := '';
  Result := Result + ' INSERT INTO COTFOR (';
  Result := Result + '   COT_SEQGER, ';
  Result := Result + '   COT_CODITE, ';
  Result := Result + '   COT_CODFOR, ';
  Result := Result + '   COT_VALUNI, ';
  Result := Result + '   COT_IPIENT, ';
  Result := Result + '   COT_SUBSTI, ';
  Result := Result + '   COT_STATUS  ';
  Result := Result + ' ) VALUES ( ';
  Result := Result + '   :SEQGER, ';
  Result := Result + '   :CODITE, ';
  Result := Result + '   :CODFOR, ';
  Result := Result + '   :VALUNI, ';
  Result := Result + '   :IPIENT, ';
  Result := Result + '   :SUBSTI, ';
  Result := Result + '   :STATUS) ';
End;

function TfrmCadCotacao.fIncluiItensFornecedor(strAutInc: String): Boolean;
  Var
    qryItens: TUniQuery;
Begin
  Try

    Result := TRUE;
    If Not fEmptyStr(strAutInc) Then
    Begin
      qryItens := fCriaQuery;
      qryItens.SQL.Text := fSqlIncluiItensFornecedor;

      frmCadCotItensFornec.cdsConsulta.Filtered := FALSE;
      frmCadCotItensFornec.cdsConsulta.DisableControls;
      frmCadCotItensFornec.cdsConsulta.First;

      While Not frmCadCotItensFornec.cdsConsulta.Eof Do
      Begin

        qryItens.ParamByName('SEQGER').AsString  := strAutInc; 
        qryItens.ParamByName('CODITE').AsString  := frmCadCotItensFornec.cdsConsulta.FieldByName('CODITE').AsString;
        qryItens.ParamByName('CODFOR').AsString  := frmCadCotItensFornec.cdsConsulta.FieldByName('CODFOR').AsString;
        qryItens.ParamByName('VALUNI').AsFloat   := frmCadCotItensFornec.cdsConsulta.FieldByName('VALUNI').AsFloat;
        qryItens.ParamByName('IPIENT').AsFloat   := frmCadCotItensFornec.cdsConsulta.FieldByName('IPIENT').AsFloat;
        qryItens.ParamByName('SUBSTI').AsFloat   := frmCadCotItensFornec.cdsConsulta.FieldByName('SUBSTI').AsFloat;
        qryItens.ParamByName('STATUS').AsInteger := frmCadCotItensFornec.cdsConsulta.FieldByName('STATUS').AsInteger;

        qryItens.ExecSQL;
        frmCadCotItensFornec.cdsConsulta.Next;
      End;
      Result := TRUE;

      frmCadCotItensFornec.cdsConsulta.Filtered := TRUE;
      frmCadCotItensFornec.cdsConsulta.EnableControls;

      FreeAndNil(qryItens);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      frmCadCotItensFornec.cdsConsulta.Filtered := TRUE;
      frmCadCotItensFornec.cdsConsulta.EnableControls;
      pMensagensErro(E.Message, '[fIncluiItensFornecedor]');
    End;
  End;

End;

function TfrmCadCotacao.fGravaItensFornecedor(strAutInc: String): Boolean;
Begin
  Result := fExcluiItensFornecedor(strAutInc) And fIncluiItensFornecedor(strAutInc);
End;

function TfrmCadCotacao.fApagaCotacao(strAutInc: String): Boolean;
  Var
    qryCotacao: TUniQuery;
Begin
  Try
    pLimpaRequisicao(strAutInc);
    qryCotacao := fCriaQuery;
    With qryCotacao, SQL Do
    Begin
      Clear;
      Add('DELETE FROM COTGER');
      Add('WHERE AUTOINCREM = :AUTINC');
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;
    End;
    FreeAndNil(qryCotacao);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fApagaCotacao]');
    End;
  End;

End;

function TfrmCadCotacao.fAtualizaCotacao(strAutInc,
                                         strDescri,
                                         strCompra: String;
                                         strMesAtu: String;
                                         intMesGir,
                                         intMesMos: Integer;
                                         blnBaixar: Boolean): Boolean;
  Var
    qryCotacao: TUniQuery;
Begin
  Try
    qryCotacao := fCriaQuery;
    With qryCotacao, SQL Do
    Begin
      Clear;
      Add('UPDATE COTGER');
      Add('SET');
      Add('  COT_DESCRI = :DESCRI,');
      Add('  COT_CODCMP = :COMPRA,');
      Add('  COT_DTAFIN = :DTAFIN,');
      Add('  COT_MESGIR = :MESGIR,');
      Add('  COT_MESMOS = :MESMOS,');
      Add('  COT_MESATU = :MESATU ');
      Add('WHERE AUTOINCREM = :AUTINC');

      ParamByName('DESCRI').AsString  := strDescri;
      ParamByName('COMPRA').AsString  := strCompra;
      ParamByName('AUTINC').AsString  := strAutInc;
      ParamByName('MESGIR').AsInteger := intMesGir;
      ParamByName('MESMOS').AsInteger := intMesMos;
      ParamByName('MESATU').AsString  := strMesAtu;

      If blnBaixar Then
        ParamByName('DTAFIN').AsDate   := VS_Date
      Else
        ParamByName('DTAFIN').Clear;

      ExecSQL;
    End;
    FreeAndNil(qryCotacao);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaCotacao]');
    End;
  End;

End;

function TfrmCadCotacao.fIncluiCotacao(strAutInc,
                                       strNumCot,
                                       strDescri,
                                       strCompra,
                                       strMulLoj,
                                       strMesAtu: String;
                                       intMesGir,
                                       intMesMos: Integer;
                                       blnBaixar: Boolean): Boolean;
  Var
    qryCotacao: TUniQuery;
Begin
  Try
    qryCotacao := fCriaQuery;
    With qryCotacao, SQL Do
    Begin
      Clear;
      Add('INSERT INTO COTGER (');
      Add('  AUTOINCREM,');
      Add('  COT_CODEMP,');
      Add('  COT_NUMCOT,');
      Add('  COT_DESCRI,');
      Add('  COT_CODCMP,');
      Add('  COT_DTAFIN,');
      Add('  COT_DTACAD,');
      Add('  COT_MULLOJ,');
      Add('  COT_MESGIR,');
      Add('  COT_MESMOS,');
      Add('  COT_MESATU');
      Add(') VALUES (');
      Add('  :AUTINC,');
      Add('  :CODEMP,');
      Add('  :NUMCOT,');
      Add('  :DESCRI,');
      Add('  :COMPRA,');
      Add('  :DTAFIN,');
      Add('  :DTACAD,');
      Add('  :MULLOJ,');
      Add('  :MESGIR,');
      Add('  :MESMOS,');
      Add('  :MESATU)');

      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('NUMCOT').AsString := strNumCot;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('COMPRA').AsString := strCompra;
      ParamByName('MULLOJ').AsString := strMulLoj;
      ParamByName('DTACAD').AsDate   := VS_Date;

      ParamByName('MESGIR').AsInteger := intMesGir;
      ParamByName('MESMOS').AsInteger := intMesMos;
      ParamByName('MESATU').AsString  := strMesAtu;

      If blnBaixar Then
        ParamByName('DTAFIN').AsDate   := VS_Date
      Else
        ParamByName('DTAFIN').Clear;

      ExecSQL;
    End;
    FreeAndNil(qryCotacao);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiCotacao]');
    End;
  End;

End;

procedure TfrmCadCotacao.pGravarPcdDetCotItem(cdsItensMultLoj:TUniClientDataSet; strCodIte, strSeqCot: String);
Begin
  If Assigned(cdsItensMultLoj) Then
  With cdsItensMultLoj Do
  Begin
    Filter    := 'ITE_CODITE = ' + QuotedStr(strCodIte);
    Filtered  := True;
    First;

    While Not Eof Do
    Begin
      pGravarPcdDetCot(FieldByName('ITE_CODITE').AsString,
                       FieldByName('ITE_CODEMP').AsString,
                       FieldByName('ITE_QTDITE').AsFloat,
                       strSeqCot);
      Next;
    End;

  End;
End;

procedure TfrmCadCotacao.pGravarPcdDetCot(strCodIte,
                                          strEmpDes: String;
                                          fltQtdIte: Double;
                                          strSeqCot: String);
  Var
    qryPcdDet: TUniQuery;
begin
  qryPcdDet := fCriaQuery(Nil);

  qryPcdDet.SQL.Clear;
  qryPcdDet.SQL.Add('INSERT INTO PCDCOT  ');
  qryPcdDet.SQL.Add('(                   ');
  qryPcdDet.SQL.Add('PCD_SEQGER,         ');
  qryPcdDet.SQL.Add('PCD_CODITE,         ');
  qryPcdDet.SQL.Add('PCD_EMPDES,         ');
  qryPcdDet.SQL.Add('PCD_QTDITE          ');
  qryPcdDet.SQL.Add(') VALUES(           ');
  qryPcdDet.SQL.Add(':SEQCOT,            ');
  qryPcdDet.SQL.Add(':CODITE,            ');
  qryPcdDet.SQL.Add(':EMPDES,            ');
  qryPcdDet.SQL.Add(':QTDITE)            ');

  qryPcdDet.ParamByName('SEQCOT').AsString := strSeqCot;
  qryPcdDet.ParamByName('CODITE').AsString := strCodIte;
  qryPcdDet.ParamByName('EMPDES').AsString := strEmpDes;
  qryPcdDet.ParamByName('QTDITE').AsFloat  := fltQtdIte;
  qryPcdDet.ExecSQL;
  qryPcdDet.Close;

  FreeAndNil(qryPcdDet);
end;

function TfrmCadCotacao.fSalvaCotacao(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnConfirma: Boolean;
    strAutInc: String;
    strNumCot, strEmpCot: String;

  procedure pMensagemGravacao(strMensagem: String);
  begin
    If Assigned(pgbStatus) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strMensagem;
    Application.ProcessMessages;      
  end;

  procedure pProgresso(intInc: Integer);
  begin
    If Assigned(pgbStatus) Then
      pgbStatus.Position := pgbStatus.Position + intInc;
    Application.ProcessMessages;
  end;

Begin
  strLisPed := '';

  strNumCot := cdsConsulta.FieldByName('COT_NUMCOT').AsString;
  strEmpCot := cdsConsulta.FieldByName('COT_CODEMP').AsString;

  blnConverterEmbalagens := blnGerarPedidos And (fCfgSis('CNVEMB') <> 'N');

  blnConverterEmbalagens := blnConverterEmbalagens And
    (fMensagem('', 'Converter unidades para caixa no Pedido de Compra?', ['','']) = 1);

  With cdsConsulta Do
  Try

    blnConfirma := TRUE;

    If Assigned(pgbStatus) Then
      pgbStatus.Properties.Max := 5;

    pMensagemGravacao('Aguarde, iniciando gravação...');

    fStartTransaction;

    blnMulLoj := FieldByName('COT_MULLOJ').AsString = 'S';

    Case opeOperac Of
      opIncluir: Begin
                   strAutInc := fRetAutoIncrem('COTGER',VS_strCodEmp);
                   FieldByName('AUTOINCREM').AsString   := strAutInc;
                   FieldByName('COT_NUMCOT').AsString   := fAtualizaProCod('COTGER');
                   strNumCot := FieldByName('COT_NUMCOT').AsString;
                 End;
    End;

    Case opeOperac Of
      opIncluir: Begin
                   pMensagemGravacao('Aguarde, inserindo Cotação...');
                   blnConfirma := fIncluiCotacao(FieldByName('AUTOINCREM').AsString,
                                                 FieldByName('COT_NUMCOT').AsString,
                                                 FieldByName('COT_DESCRI').AsString,
                                                 strCodCmp,
                                                 FieldByName('COT_MULLOJ').AsString,
                                                 FieldByName('COT_MESATU').AsString,
                                                 FieldByName('COT_MESGIR').AsInteger,
                                                 FieldByName('COT_MESMOS').AsInteger,
                                                 blnGerarPedidos);

                   strEmpCot := VS_strCodEmp;

                   If blnConfirma Then
                   Begin
                     If blnGerarPedidos Then
                       cdsConsulta.FieldByName('COT_DTAFIN').AsDateTime := VS_Date;
                     cdsConsulta.post;
                   End;
                 End;
      opAlterar: Begin
                   pMensagemGravacao('Aguarde, alterando Cotação...');
                   strAutInc   := FieldByName('AUTOINCREM').AsString;
                   blnConfirma := fAtualizaCotacao(strAutInc,
                                                   FieldByName('COT_DESCRI').AsString,
                                                   strCodCmp,
                                                   FieldByName('COT_MESATU').AsString,
                                                   FieldByName('COT_MESGIR').AsInteger,
                                                   FieldByName('COT_MESMOS').AsInteger,
                                                   blnGerarPedidos);
                   If blnConfirma Then
                   Begin
                     If blnGerarPedidos Then
                       cdsConsulta.FieldByName('COT_DTAFIN').AsDateTime := VS_Date;
                     cdsConsulta.post;
                   End;
                 End;
      opExcluir: Begin
                   pMensagemGravacao('Aguarde, excluindo Cotação...');
                   blnConfirma := fApagaCotacao(FieldByName('AUTOINCREM').AsString);
                   If blnConfirma Then
                     cdsConsulta.Delete;
                 End;
    End;

    pProgresso(1);

    Case opeOperac Of
      opIncluir,
      opAlterar:  Begin
                    pMensagemGravacao('Aguarde, Gravando Itens...');

                    blnConfirma := blnConfirma And fGravaItens(strAutInc);

                    pProgresso(1);

                    pMensagemGravacao('Aguarde, Gravando Fornecedores...');

                    blnConfirma := blnConfirma And fGravaFornecedores(strAutInc);

                    pProgresso(1);

                    pMensagemGravacao('Aguarde, Gravando Itens Fornec...');

                    blnConfirma := blnConfirma And fGravaItensFornecedor(strAutInc);

                    pProgresso(1);

                    If blnGerarPedidos Then
                    Begin
                      pMensagemGravacao('Aguarde, Gravando Pedidos...');

                      blnConfirma := blnConfirma And fGeraPedidosCompra(strNumCot, strEmpCot);
                    End;

                    pProgresso(1);
                  End;
    End;

    If Not (opeOperac In [opIncluir, opAlterar]) Then
      pProgresso(4);

    If blnConfirma Then
    Begin
      fCommit;
      Result := TRUE;
    End Else
    Begin
      Cancel;
      fRollBack;
      Result := FALSE;
    End;

  Except 
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fSalvaCotacao]');
    End;
  End;

End;

function TfrmCadCotacao.fCriaFormsCotacao: Boolean;
Begin
  Try

    pCriarFormularios(TfrmCadCotacaoGeral,frmCadCotacaoGeral);
    pCriarFormularios(TfrmCadCotItens,frmCadCotItens);

    frmCadCotItens.frmCadCotacao := Self;

    pCriarFormularios(TfrmCadCotFornecedor,frmCadCotFornecedor);
    pCriarFormularios(TfrmCadCotItensFornec,frmCadCotItensFornec);
    pCriarFormularios(TfrmCadCotComparativo,frmCadCotComparativo);
    pCriarFormularios(TfrmCadCotAtuPrecos, frmCadCotAtuPrecos);
    if frmCadCotAtuPrecos.blnNaoAbrir then
    Begin
      Result := False;
      Exit;
    End;

    Result := TRUE;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fCriaFormsCotacao]');
      Result := FALSE;
    End;
  End;
End;

procedure TfrmCadCotacao.pAtuRequisicao(strCot_SeqCot, strCot_SeqReq: String);
  Var
    qryReq: TUniQuery;
begin
  qryReq := fCriaQuery;
  Try
    qryReq.SQL.Add('UPDATE MOVRCD');
    qryReq.SQL.Add('   SET RCD_SEQCOT = :SEQCOT');
    qryReq.SQL.Add(' WHERE AUTOINCREM = :SEQREQ');
    qryReq.ParamByName('SEQCOT').AsString := strCot_SeqCot;
    qryReq.ParamByName('SEQREQ').AsString := strCot_SeqReq;
    qryReq.ExecSQL;
  Finally
    FreeAndNil(qryReq);
  End;
end;

Procedure TfrmCadCotacao.pDestroiFormsCotacao;
Begin

  Try

    FreeAndNil(frmCadCotItens);
    FreeAndNil(frmCadCotFornecedor);
    FreeAndNil(frmCadCotItensFornec);
    FreeAndNil(frmCadCotComparativo);
    FreeAndNil(frmCadCotAtuPrecos);
    FreeAndNil(frmCadCotacaoGeral);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pDestroiFormsCotacao]');
    End;
  End;
End;

function TfrmCadCotacao.fAbreCotacao(opeOperacao: TTipoOperacao): Boolean;
  Var
    intRecNo: Integer;
Begin
  Result := FALSE;

  Try
    opeOperac := opeOperacao;

    frmCadCotacaoGeral := Nil;

    If Not cdsConsulta.Active Then
      Exit;

    Case opeOperacao Of
      opAlterar,
      opExcluir: Begin
                   If cdsConsulta.IsEmpty Then
                     Exit;

                   If (cdsConsulta.FieldByName('COT_DTAFIN').AsDateTime > 0) And
                      (Not fVerificaAcessoSistema('DELCEN')) Then
                   Begin
                      fMensagem('', 'Usuario sem permissão de Excluir Cotações já Encerradas!', ['&O k']);
                      Exit;
                   End;
                 End;
    End;

    Case opeOperacao Of
      opExcluir: Begin
                   If (fMensagem('', 'Confirma a exclusão da Cotação ' +
                         cdsConsulta.FieldbyName('COT_NUMCOT').AsString + ' ?', ['&Sim', '&Não']) <>  1) Then
                     Exit;
                 End
      Else       Begin

                   If Not fCriaFormsCotacao Then
                   Begin
                     Result := FALSE;
                     Exit;
                   End;

                   frmCadCotacaoGeral.opeOperacao := opeOperacao;
                   frmCadCotacaoGeral.dtsCotacao  := dtsConsulta;
                   frmCadCotacaoGeral.cdsCotacao  := cdsConsulta;

                 End;
    End;

    cdsConsulta.Tag := 1;

    With cdsConsulta Do
    Begin

      Case opeOperacao Of
        opIncluir: Begin
                     Insert;
                     FieldByName('COT_DTACAD').AsDateTime := VS_Date;
                     FieldByName('COT_CODEMP').AsString   := VS_strCodEmp;
                     FieldByName('COT_MULLOJ').AsString   := 'N';
                     FieldByName('COT_MESGIR').AsInteger  := 3;
                     FieldByName('COT_MESMOS').AsInteger  := INT_QTD_MES_MOSTRA_GIRO;
                     FieldByName('COT_MESATU').AsString   := 'N';
                   End;
        opAlterar: Edit;
      End;

      Try
        If (opeOperacao = opExcluir ) Then
        Begin
          blnGerarPedidos := False;

          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fSalvaCotacao;

          frmGravando.ShowModal;
          Result := frmGravando.blnConfirma;
        End

        Else
        Begin
          Result := (frmCadCotacaoGeral.ShowModal = mrOk);

          If Result Then
          Begin
            strCodCmp       := fRetCodVendedor(frmCadCotacaoGeral.edtCodCmp.Text);

            blnGerarPedidos := frmCadCotacaoGeral.blnGerarPedidos;

            pCriarFormularios(TfrmGravando, frmGravando);
            frmGravando.fExecutarAcao := fSalvaCotacao;

            frmGravando.ShowModal;
            Result := frmGravando.blnConfirma;
          End;

          If Not Result Then
            Cancel;

          If Result And (Not fEmptyStr(strLisPed)) Then
            fMensagem('','PEDIDO(S) DE COMPRA GERADO(S): ' + strLisPed, ['&OK']);

        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      pFreeAndNil(frmGravando);

    End;

    If (opeOperacao <> opExcluir) Then
      pDestroiFormsCotacao;

    cdsConsulta.Tag := 0;

    intRecNo := cdsConsulta.RecNo;
    pHabilitaBotoes(fAbreConsulta(TRUE));

    If (intRecNo > 0) And (intRecNo <= cdsConsulta.RecordCount) Then
      cdsConsulta.RecNo := intRecNo;

  Except
    On E: Exception Do
    Begin

      pDestroiFormsCotacao;

      If cdsConsulta.State in [dsEdit, dsInsert] Then
        cdsConsulta.Cancel;

      cdsConsulta.Tag := 0;
      Result := False;
      pMensagensErro(E.Message, '[fAbreCotacao]');
    End;
  End;

End;

procedure TfrmCadCotacao.btnIncluirClick(Sender: TObject);
begin
  inherited;
  fAbreCotacao(opIncluir);
end;

procedure TfrmCadCotacao.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnExibirDetMultLoja.Enabled := cdsConsulta.FieldByName('COT_MULLOJ').AsString = 'S';

end;

procedure TfrmCadCotacao.dbgConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;
  End;
end;

procedure TfrmCadCotacao.btnExibirDetMultLojaClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmGridListaCotacoesMultiLoja, frmGridListaCotacoesMultiLoja);
  Try
    frmGridListaCotacoesMultiLoja.ShowModal(cdsConsulta.FieldByName('AUTOINCREM').AsString);
  Finally
    FreeAndNil(frmGridListaCotacoesMultiLoja);
  End
end;


procedure TfrmCadCotacao.btnAlterarClick(Sender: TObject);
begin
  inherited;

  fAbreCotacao(opAlterar);
end;

procedure TfrmCadCotacao.btnExcluirClick(Sender: TObject);
begin
  inherited;

  fAbreCotacao(opExcluir);
end;

procedure TfrmCadCotacao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadCotacao.FormCreate(Sender: TObject);
begin
  inherited;

  If fEmptyStr(strCodCmp) then
    strCodCmp := strLoginUsuarioLogado;


  pLoadFuncoesPedido;
end;

Procedure TfrmCadCotacao.pLoadFuncoesPedido;
  Var
    pSetDigSenVarPed : Procedure (objSenVar : IDigSenVar); stdcall;
Begin
  pSetDigSenVar( TDigSenVar.Create );

  hwdDllPedido := fLoadLibraryPedidoCompra;

  If hwdDllPedido = 0 Then
    fMensagem('', 'Não foi possível carregar o módulo libPedidoDeCompra.dll. Verifique!', ['&Ok'])
  Else
  Begin
    fRetornaProdutosGiroCotacao := GetProcAddress(hwdDllPedido, PChar('fRetornaProdutosGiroCotacao'));
    fCarregaCotacaoMultiLojas   := GetProcAddress(hwdDllPedido, PChar('fCarregaCotacaoMultiLojas'));
    pSetDigSenVarPed               := GetProcAddress(hwdDllPedido, PChar('pSetDigSenVar'));
    pSetDigSenVarPed( TDigSenVar.Create );
  End;
End;

procedure TfrmCadCotacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Not pnlPesquisa.Visible Then
  Begin

    Case Key Of
      VK_F6    : If btnExibirDetMultLoja.Enabled Then
                    btnExibirDetMultLojaClick(Sender);
      VK_DELETE: btnExcluir.Click;
      VK_INSERT: btnIncluir.Click;
      VK_RETURN: If ActiveControl Is TRadioButton Then
                   pHabilitaBotoes(fAbreConsulta(TRUE))
                 Else
                   btnAlterar.Click;
    End;

  End;
    
  inherited;

end;

procedure TfrmCadCotacao.pHabilitaBotoes(blnHabilita: Boolean);
Begin
  btnIncluir.Visible   := blnHabilita And (rdgStatus.ItemIndex <> 1);
  btnAlterar.Visible   := blnHabilita;
  btnExcluir.Visible   := blnHabilita;
  btnPesquisar.Visible := blnHabilita;
  btnMudaOrdem.Visible := blnHabilita;
End;

procedure TfrmCadCotacao.pIncluiPcmIrq(strAutIncPcd, strCodIte: String);
  Var
    strAutIncReq: String;
    qryPcmIrq: TUniQuery;
  procedure pInsere(strSeqReq: String);
  Begin
    qryPcmIrq.ParamByName('SEQDET').AsString := strAutIncPcd;
    qryPcmIrq.ParamByName('SEQREQ').AsString := strSeqReq;
    qryPcmIrq.ExecSQL;
  End;
begin
  qryPcmIrq := fCriaQuery;
  Try
    qryPcmIrq.SQL.Add('INSERT INTO PCMIRQ(');
    qryPcmIrq.SQL.Add('  PCM_SEQDET,');
    qryPcmIrq.SQL.Add('  PCM_SEQREQ');
    qryPcmIrq.SQL.Add(') VALUES (');
    qryPcmIrq.SQL.Add('  :SEQDET,');
    qryPcmIrq.SQL.Add('  :SEQREQ )');
    
    For strAutIncReq In frmCadCotItens.fGetRequisicoes(strCodIte) Do
      pInsere(strAutIncReq);
  Finally
    FreeAndNil(qryPcmIrq);
  End;

end;

procedure TfrmCadCotacao.pLimpaRequisicao(strAutInc: String);
  Var
    qryReq: TUniQuery;
begin
  qryReq := fCriaQuery;
  Try
    qryReq.SQL.Add('UPDATE MOVRCD');
    qryReq.SQL.Add('   SET RCD_SEQCOT = NULL');
    qryReq.SQL.Add(' WHERE RCD_SEQCOT IN (SELECT ');
    qryReq.SQL.Add('                        AUTOINCREM');
    qryReq.SQL.Add('                      FROM');
    qryReq.SQL.Add('                        COTITE');
    qryReq.SQL.Add('                      WHERE');
    qryReq.SQL.Add('                        COT_SEQGER = :SEQGER)');
    qryReq.ParamByName('SEQGER').AsString := strAutInc;
    qryReq.ExecSQL;
  Finally
    FreeAndNil(qryReq);
  End;
end;

procedure TfrmCadCotacao.btnIncHerClick(Sender: TObject);
  Var
    strAutInc: String;
begin
  inherited;

  If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
    Exit;

  If (fMensagem('', 'Confirma a inclusão herdando da Cotação ' +
                     cdsConsulta.FieldbyName('COT_NUMCOT').AsString + ' ?', ['&Sim', '&Não']) = 1)  And
                     fIncluiComHeranca(strAutInc) Then
  Begin
    If rdgStatus.ItemIndex = 1 Then
      rdgStatus.ItemIndex := 0;
      
    pHabilitaBotoes(fAbreConsulta(TRUE));

    cdsConsulta.Locate('AUTOINCREM',strAutInc,[]);
  End;  

end;

function TfrmCadCotacao.fIncluiItensHeranca(strAutInc, strSeqGer: String): Boolean;
  Var
    qryItens,
    qryTmp: TUniQuery;
    strAutIncTmp: String;
Begin
  Try
    qryItens := fCriaQuery;
    qryTmp   := fCriaQuery;

    With qryItens, SQL Do
    Begin
      Clear;
      Add('SELECT ');
      Add('  COT_CODITE,');
      Add('  COT_QTDITE,');
      Add('  COT_DESITE ');
      Add('FROM ');
      Add('  COTITE');
      Add('WHERE COT_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;

      Open;

      If Not IsEmpty Then
      Begin
        First;

        While Not Eof Do
        Begin
          strAutIncTmp := fRetAutoIncrem('COTITE', VS_strCodEmp);

          qryTmp.Close;
          qryTmp.SQL.Clear;
          qryTmp.SQL.Add('INSERT INTO COTITE (AUTOINCREM, COT_SEQGER, COT_CODITE, COT_QTDITE, COT_DESITE, COT_PJAATU) VALUES ');
          qryTmp.SQL.Add(' (:AUTINC, :SEQGER, :CODITE, :QTDITE, :DESITE, "N") ');

          qryTmp.ParamByName('AUTINC').AsString := strAutIncTmp;
          qryTmp.ParamByName('SEQGER').AsString := strAutInc;
          qryTmp.ParamByName('CODITE').AsString := FieldByName('COT_CODITE').AsString;
          qryTmp.ParamByName('QTDITE').AsString := FieldByName('COT_QTDITE').AsString;
          qryTmp.ParamByName('DESITE').AsString := FieldByName('COT_DESITE').AsString;

          qryTmp.ExecSQL;

          Next;
        End;
      End;
    End;

    FreeAndNil(qryItens);
    FreeAndNil(qryTmp);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensHeranca]');
    End;
  End;
End;

function TfrmCadCotacao.fIncluiFornecedoresHeranca(strAutInc, strSeqGer: String): Boolean;
  Var
    qryCfo: TUniQuery;
Begin
  Try

    qryCfo := fCriaQuery;
    With qryCfo, SQL Do
    Begin
      Clear;
      Add('INSERT INTO COTCFO');
      Add('SELECT ');
      Add('  :AUTINC,');
      Add('  COT_CODFOR, ');
      Add('  COT_CONPAG, ');
      Add('  COT_DTAENT, ');
      Add('  COT_UTILIZ  ');
      Add('FROM ');
      Add('  COTCFO');
      Add('WHERE COT_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('AUTINC').AsString := strAutInc;

      ExecSQL;
    End;
    FreeAndNil(qryCfo);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiFornecedoresHeranca]');
    End;
  End;
End;

function TfrmCadCotacao.fIncluiItensFornecHeranca(strAutInc, strSeqGer: String): Boolean;
  Var
    qryItens: TUniQuery;
Begin
  Try

    qryItens := fCriaQuery;
    With qryItens, SQL Do
    Begin
      Clear;
      Add('INSERT INTO COTFOR');
      Add('SELECT ');
      Add('  :AUTINC,');
      Add('  COT_CODFOR,');
      Add('  COT_CODITE,');
      Add('  0.0,       ');
      Add('  0.0,       ');
      Add('  0.0,       ');
      Add('  0          ');
      Add('FROM ');
      Add('  COTFOR');
      Add('WHERE COT_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('AUTINC').AsString := strAutInc;

      ExecSQL;
    End;
    FreeAndNil(qryItens);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensFornecHeranca]');
    End;
  End;
End;

function TfrmCadCotacao.fIncluiComHeranca(Var strAutInc: String): Boolean;
  Var
    strNumCot: String;
    blnConfirma: Boolean;
Begin

  Try
    fStartTransaction;

    strAutInc := fRetAutoIncrem('COTGER',VS_strCodEmp);
    strNumCot := fAtualizaProCod('COTGER');

    blnConfirma := fIncluiCotacao(strAutInc,
                                  strNumCot,
                                  cdsConsulta.FieldByName('COT_DESCRI').AsString,
                                  strCodCmp,
                                  cdsConsulta.FieldByName('COT_MULLOJ').AsString,
                                  cdsConsulta.FieldByName('COT_MESATU').AsString,
                                  cdsConsulta.FieldByName('COT_MESGIR').AsInteger,
                                  cdsConsulta.FieldByName('COT_MESMOS').AsInteger,
                                  FALSE);

    blnConfirma := blnConfirma And fIncluiItensHeranca(strAutInc, cdsConsulta.FieldByName('AUTOINCREM').AsString);

    blnConfirma := blnConfirma And fIncluiFornecedoresHeranca(strAutInc, cdsConsulta.FieldByName('AUTOINCREM').AsString);

    blnConfirma := blnConfirma And fIncluiItensFornecHeranca(strAutInc, cdsConsulta.FieldByName('AUTOINCREM').AsString);

    If blnConfirma Then
    Begin
      fCommit;
      Result := TRUE;
    End Else
    Begin
      fRollBack;
      Result := FALSE;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fIncluiComHeranca]');
    End;
  End;

End;

function TfrmCadCotacao.fIniciaPedidoCompra(    strCodFor,
                                                strCompra,
                                                strNumCot,
                                                strEmpCot,
                                                strNomEmpLoj,
                                                strEndEmpLoj,
                                                strCidEmpLoj,
                                                strMulLoj,
                                                strEmpDes: String;
                                            Var strNumPed,
                                                strConPag: String;
                                            Var dtaDtaPed,
                                                horHorPed,
                                                dtaDtaEnt: TDateTime;
                                                blnDesmem: Boolean): Boolean;
  Var
    fltTotIPI,
    fltTotSub,
    fltTotIte,
    fltTotGer,
    fltValIte,
    fltValIPI,
    fltValSub,
    fltPerIPI,
    fltPerSub,

    fltBasCof,
    fltValCof,
    fltBasPis,
    fltValPis,
    fltBasIcm,
    fltValIcm,
    fltBasIpi,
    fltBasSub,

    fltQtdIte,
    fltAlqPis,
    fltAlqCof: Double;

    blnIncPis: Boolean;

Begin
  Try

    fltAlqPis := fCfgSis('ALPISP');
    fltAlqCof := fCfgSis('ALCOFP');

    fltTotIPI := 0;
    fltTotSub := 0;
    fltTotIte := 0;
    fltTotGer := 0;

    fltBasCof := 0;
    fltValCof := 0;
    fltBasPis := 0;
    fltValPis := 0;
    fltBasIcm := 0;
    fltValIcm := 0;
    fltBasIpi := 0;
    fltBasSub := 0;

    With frmCadCotItensFornec.cdsConsulta Do
    Begin
      First;

      While Not Eof Do
      Begin

        If blnDesmem Then
        Begin

          If Assigned(frmCadCotItens.cdsItensMultiLojas) And
             frmCadCotItens.cdsItensMultiLojas.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
            fltQtdIte := frmCadCotItens.cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat
          Else
            fltQtdIte := 0;

        End Else
        Begin

          fltQtdIte := FieldByName('QTDITE').AsFloat;

        End;

        If fltQtdIte > 0 Then
        Begin
          fltPerIPI := FieldByName('IPIENT').AsFloat;
          fltPerSub := FieldByName('SUBSTI').AsFloat;

          fltValIte := fltQtdIte * FieldByName('VALUNI').AsFloat;

          fltValIPI := fltValIte * (fltPerIPI/100);
          fltValSub := fltValIte * (fltPerSub/100);

          fltTotIte := fltTotIte + fltValIte;
          fltTotIPI := fltTotIPI + fltValIPI;
          fltTotSub := fltTotSub + fltValSub;
          fltTotGer := fltTotGer + fltValIte + fltValIPI + fltValSub;

          blnIncPis := fCampoTabela('ITE_INCPIS', 'CADITE', ['ITE_CODITE'], [FieldByName('CODITE').AsString]) = 'S';

          If blnIncPis Then
          Begin
            fltBasCof := fltBasCof + fltValIte;
            fltValCof := fltValCof + RoundTo(fltValIte * fltAlqCof/100, -2);
            fltBasPis := fltBasPis + fltValIte;
            fltValPis := fltValPis + RoundTo(fltValIte * fltAlqPis/100, -2);
          End;

          fltBasIcm := 0;
          fltValIcm := 0;
          fltBasIpi := 0;
          fltBasSub := 0;
        End;

        Next;
      End;

    End;

    strNumPed := fSeqPedidoCompra;
    dtaDtaPed := VS_Date;
    horHorPed := Time;

    With frmCadCotFornecedor.cdsConsulta Do
    Begin
      If Locate('CODFOR',strCodFor, []) Then
      Begin
        strConPag := fTiraCaracEspeciais(FieldByName('CONPAG').AsString);
        dtaDtaEnt := FieldByName('DTAENT').AsDateTime;
      End Else
      Begin
        fMensagem('', 'Fornecedor não encontrado!', ['&OK']);
        Result := FALSE;
        Exit;
      End;
    End;

    with frmCadCotComparativo.recObserv Do
    pGravaPcmGer(strNumPed,                        // Número do Pedido
                 VS_strCodEmp,                     // Empresa
                 'PD',                             // Espécie (PD / OR)
                 strCodFor,                        // Fornecedor
                 strCodTra,                        // Transportadora
                 strConPag,                        // Cond. Pagamento
                 dtaDtaPed,                        // Data do Pedido
                 horHorPed,                        // Hora do Pedido
                 dtaDtaEnt,                        // Data de Entrega
                 strCompra,                        // Comprador
                 fltTotIpi,                        // Total de IPI
                 fltTotSub,                        // Total de SUB
                 fltTotIte,                        // Total de Itens

                 fltTotGer + fltValFre + fltDesAce,// Total de Itens+IPI+SUB

                 strObs001,                        // Observação 1
                 strObs002,                        // Observação 2
                 strObs003,                        // Observação 3
                 '',                               // Observação 4
                 '',                               // Observação 5
                 strObsPd1,                        // Observ PD 1
                 strObsPd2,                        // Observ PD 2
                 strObsPd3,                        // Observ PD 3
                 strPedVen,                        // Pedido de venda
                 strAtenca,                        // Atenção de
                 strTipFre,                        // Tipo de Frete
                 '',                               // Origem do Documento (Faturamento)
                 0,                                // Número do Container
                 'N',                              // Pedido de Importação?
                 'N',                              // Pedido Intrepostado
                 strEmpDes,                        // Codigo da empresa destino
                 0,                                // Desconto Adicionsl
                 strMulLoj,                        // Pedido Multi Lojas?
                 fltValFre,                        // fltValFre
                 fltDesAce,                        // fltDesAce
                 dtaDtaPed,                        // Data do Faturamento
                 strCodEve,                        // Código do Evento
                 strCodCta,                        // Centro de Custo
                 strNomEmpLoj,
                 strEndEmpLoj,
                 strCidEmpLoj,
                 '',
                 False,
                 0,
                 0,
                 0,
                 0,
                 fltBasCof,
                 fltValCof,
                 fltBasPis,
                 fltValPis,
                 fltBasIcm,
                 fltValIcm,
                 fltBasIpi,
                 fltBasSub,
                 IIF(fStatusCndPag(strConPag) = A_VISTA, 'S', 'N'),
                 strNumCot,
                 strEmpCot,
                 'N',
                 frmCadCotItens.recDadGiro.intMesGir,
                 IIF(frmCadCotItens.recDadGiro.blnConsMesAtu, 'S', 'N'),
                 '',
                 0,
                 0,
                 FAutGer);

     Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIniciaPedidoCompra]');
    End;
  End;

End;

function TfrmCadCotacao.fGravaItem(strCodFor,
                                   strNumPed,
                                   strConPag: String;
                                   dtaDtaPed,
                                   horHorPed,
                                   dtaDtaEnt: TDateTime;
                                   strCodIte,
                                   strCodUni,
                                   strDesIte,
                                   strRefere,
                                   strSigUni: String;
                                   fltQtdIte,
                                   fltValUni,
                                   fltIpiEnt,
                                   fltSubsti: Double;
                                   blnMulLoj: Boolean): Boolean;
 Var
   strAutIncPcd: String;
   fltTotIte,
   fltTotIPI,
   fltTotSub,
   fltBasSub,
   fltBasIPI,
   fltBasIcm,
   fltAlqIcm,
   fltValIcm: Double;
   blnIncPis: Boolean;
Begin

  Try
    fltTotIte := fltQtdIte * fltValUni;
    fltTotIPI := fltTotIte * (fltIpiEnt/100);
    fltTotSub := fltTotIte * (fltSubsti/100);

    fltBasSub := fltTotIte;
    fltBasIPI := fltTotIte;
    fltBasIcm := 0;
    fltAlqIcm := 0;
    fltValIcm := 0;

    blnIncPis := fCampoTabela('ITE_INCPIS', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S';

    pGravaPcmDet(strNumPed,                                // Número do Pedido
                 VS_strCodEmp,                             // Empresa
                 'PD',                                     // Espécie (PD / OR)
                 strCodFor,                                // Fornecedor
                 strCodIte,                                // Código Item
                 strCodUni,                                // Código Unidade
                 dtaDtaEnt,                                // Data Entrega
                 horHorPed,                                // Hora do Pedido
                 dtaDtaPed,                                // Data do Pedido
                 strConPag,                                // Cond. Pagamento
                 strDesIte,                                // Descrição Item
                 fltQtdIte,                                // Quantidade
                 fltValUni,                                // Preço Unitario
                 0,                                        // % desconto 1 unitário
                 0,                                        // % desconto 2 unitário
                 fltTotIte,                                // Total Itens S
                 fltIPIEnt,                                // Percentual IPI
                 fltTotIPI,                                // Total IPI
                 fltSubsti,                                // Percentual SUB
                 fltTotSub,                                // Total SUB
                 0,                                        // Quantidade Baixa
                 0,                                        // Total Baixado
                 0,                                        // IPI Baixado
                 0,                                        // SUB Baixado
                 0,                                        // Baixado?
                 '',                                       // Origem do Documento (Faturamento)
                 0,                                        // Número do Container
                 'N',                                      // Pedido de Importação?
                 'N',                                      // Pedido Intrepostado
                 'N',                                      // Proveninete de Importação?
                 strAutIncPcd,                             // Auto Incremento
                 '',                                       // Código do produto acabado
                 '',                                       // Empresa do produto acabado
                 '',                                       // Produto acabado? (S/N)
                 0,                                        // Conferencia de entrada
                 fltBasSub,
                 fltBasIPI,
                 fltBasIcm,
                 fltAlqIcm,
                 fltValIcm,
                 blnIncPis,
                 '',
                 0,
                 0,
                 0,
                 0,
                 0,
                 0);

    // Insere relação PCMDET -> MOVRCD (Item do pedido com item da requisição de compra)
    pIncluiPcmIrq(strAutIncPcd, strCodIte);

    If blnMulLoj And Assigned(frmCadCotItens.cdsItensMultiLojas) Then
      pGravarPcdDet(strNumPed, 'PD', VS_strCodEmp, strCodIte,
                    strAutIncPcd, frmCadCotItens.cdsItensMultiLojas);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaItem]');
    End;
  End;

End;

function TfrmCadCotacao.fGravaPedidoCompra(strNumCot,
                                           strEmpCot,
                                           strCodFor,
                                           strNomEmpLoj,
                                           strEndEmpLoj,
                                           strCidEmpLoj,
                                           strMulLoj,
                                           strEmpDes: String;
                                           blnDesmem: Boolean): Boolean;
  Var
    strNumPed,
    strConPag: String;
    dtaDtaPed,
    horHorPed,
    dtaDtaEnt: TDateTime;

    strCodUni,
    strSigUni: String;

    fltEmbala,
    fltUnitar,
    fltQtdIte: Double;

    blnRefPed: Boolean;
Begin
  blnRefPed := fCfgSis('REFPED', varBoolean);

  With frmCadCotItensFornec.cdsConsulta Do
  Begin
    Result := fIniciaPedidoCompra(strCodFor,
                                  strCodCmp,
                                  strNumCot,
                                  strEmpCot,
                                  strNomEmpLoj,
                                  strEndEmpLoj,
                                  strCidEmpLoj,
                                  strMulLoj,
                                  strEmpDes,
                                  strNumPed,
                                  strConPag,
                                  dtaDtaPed,
                                  horHorPed,
                                  dtaDtaEnt,
                                  blnDesmem);

    strLisPed := strLisPed + strNumPed + ', ';

    First;
    While (Not Eof) And Result Do
    Begin
      strCodUni := FieldByName('CODUNI').AsString;
      strSigUni := FieldByName('CODUNI').AsString;
      fltUnitar := FieldByName('VALUNI').AsFloat;

      If blnDesmem Then
      Begin

        If Assigned(frmCadCotItens.cdsItensMultiLojas) And
           frmCadCotItens.cdsItensMultiLojas.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
          fltQtdIte := frmCadCotItens.cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat
        Else
          fltQtdIte := 0;

      End Else
      Begin

        fltQtdIte := FieldByName('QTDITE').AsFloat;

      End;

      If fltQtdIte > 0 Then
      Begin
        If blnConverterEmbalagens And
           fCarregaDadosCompraEmbalagem(FieldByName('CODITE').AsString, strCodUni, strSigUni, fltEmbala) Then
        Begin
          fltQtdIte := fltQtdIte / fltEmbala;
          fltUnitar := fltUnitar * fltEmbala;
        End;

        Result := fGravaItem(strCodFor,
                             strNumPed,
                             strConPag,
                             dtaDtaPed,
                             horHorPed,
                             dtaDtaEnt,
                             FieldByName('CODITE').AsString,
                             strCodUni,
                             Trim(FieldByName('DESITE').AsString + IIF(blnRefPed, ' ' + FieldByName('REFERE').AsString, '')),
                             FieldByName('REFERE').AsString,
                             strSigUni,
                             fltQtdIte,
                             fltUnitar,
                             FieldByName('IPIENT').AsFloat,
                             FieldByName('SUBSTI').AsFloat,
                             (Not blnDesmem) And (strMulLoj = 'S'));

        If Not Result Then
          Break;
      End;

      Next;
    End;
  End;
End;

function TfrmCadCotacao.fGravaPedidoCompraDesmembrado(strNumCot, strEmpCot, strCodFor: String): Boolean;
  Var
    qryCadEmp: TUniQuery;

   strNomEmpLoj,
   strEndEmpLoj,
   strCidEmpLoj: String;
Begin
  If Not Assigned(frmCadCotItens.cdsItensMultiLojas) Then
  Begin
    Result := False;
    pMensagemOk('Dados Multiloja não inicializados!');
    Exit;
  End;

  Result := True;

  qryCadEmp := fCriaQuery;
  pAbreEmpresas(qryCadEmp);

  With qryCadEmp Do
  While (Not Eof) Do
  Begin

    If frmCadCotComparativo.recObserv.blnEndLoj Then
    Begin
      strNomEmpLoj := FieldByName('NOMENT').AsString;  // Nome p/ Entrega
      strEndEmpLoj := FieldByName('ENDENT').AsString;  // Endereço p/ Entrega
      strCidEmpLoj := FieldByName('NOMCID').AsString;  // Cidade p/ Entrega
    End Else
    with frmCadCotComparativo.recObserv Do
    Begin
      strNomEmpLoj := strNomEmp;  // Nome p/ Entrega
      strEndEmpLoj := strEndere;  // Endereço p/ Entrega
      strCidEmpLoj := strCidade;  // Cidade p/ Entrega
    End;

    frmCadCotItens.cdsItensMultiLojas.Filter   := 'ITE_CODEMP = ' + QuotedStr(FieldByName('EMP_CODEMP').AsString) + ' AND ITE_QTDITE > 0';
    frmCadCotItens.cdsItensMultiLojas.Filtered := True;

    If Not frmCadCotItens.cdsItensMultiLojas.IsEmpty then
      Result := fGravaPedidoCompra(strNumCot,
                                   strEmpCot,
                                   strCodFor,
                                   strNomEmpLoj,
                                   strEndEmpLoj,
                                   strCidEmpLoj,
                                   'N',
                                   FieldByName('EMP_CODEMP').AsString,
                                   True);

    If Not Result Then
      Break;

    Next;
  End;

End;

function TfrmCadCotacao.fGeraPedidosCompra(strNumCot, strEmpCot: String): Boolean;
  Var
    strFilter,
    strCodFor: String;
    blnConfirma: Boolean;
Begin
  Try
    strLisPed := '';
    blnConfirma := TRUE;

    with frmCadCotItensFornec.cdsConsulta Do
    Begin
      DisableControls;
      strFilter := Filter;
      frmCadCotFornecedor.cdsConsulta.DisableControls;
      frmCadCotFornecedor.cdsConsulta.First;

      While (Not frmCadCotFornecedor.cdsConsulta.Eof) And blnConfirma Do
      Begin

        strCodFor := frmCadCotFornecedor.cdsConsulta.FieldbyName('CODFOR').AsString;
        Filter := '(PREESC = 1) AND (CODFOR = ''' + strCodFor + ''') AND (QTDITE > 0)';
        First;

        If Not IsEmpty Then
        Begin

          If blnMulLoj And frmCadCotComparativo.recObserv.blnDesmen Then
          Begin
            blnConfirma := fGravaPedidoCompraDesmembrado(strNumCot, strEmpCot, strCodFor);
          End Else
          Begin
            With frmCadCotComparativo.recObserv Do
            blnConfirma := fGravaPedidoCompra(strNumCot, strEmpCot, strCodFor,
                                              strNomEmp, strEndere, strCidade,
                                              IIF(blnMulLoj, 'S', 'N'), '', False);
          End;

        End;

        If Not blnConfirma Then
          Break;

        frmCadCotFornecedor.cdsConsulta.Next;

      End;

      If fEmptyStr(strLisPed) Then
        blnConfirma := FALSE
      Else
        strLisPed := Copy(strLisPed,1,Length(strLisPed) - 2);

      frmCadCotFornecedor.cdsConsulta.EnableControls;
      Filter := strFilter;
      EnableControls;
    End;

    Result := blnConfirma;

  Except
    On E: Exception Do
    Begin
      frmCadCotFornecedor.cdsConsulta.EnableControls;
      frmCadCotItensFornec.cdsConsulta.EnableControls;
      frmCadCotItensFornec.cdsConsulta.Filter := strFilter;

      Result := False;
      pMensagensErro(E.Message, '[fGeraPedidosCompra]');
    End;
  End;

End;

Procedure TfrmCadCotacao.pSetFilterDefault;
Begin

  Case rdgStatus.ItemIndex Of
    0: cdsConsulta.Filter := '(COT_DTAFIN =  NULL)';
    1: cdsConsulta.Filter := '(COT_DTAFIN <> NULL)';
    2: cdsConsulta.Filter := '';
  End;

  cdsConsulta.Filtered := Not fEmptyStr(cdsConsulta.Filter);

End;

function TfrmCadCotacao.fGetFilter: String;
Begin
  Result := Inherited fGetFilter;

  If (Not fEmptyStr(Result)) And (rdgStatus.ItemIndex <> 2) Then
    Result := Result + ' AND ';

  Case rdgStatus.ItemIndex Of
    0: Result := Result + '(COT_DTAFIN IS NULL)';
    1: Result := Result + '(COT_DTAFIN IS NOT NULL)';
  End;

End;

procedure TfrmCadCotacao.rdgStatusClick(Sender: TObject);
begin
  inherited;
    pHabilitaBotoes(fAbreConsulta(TRUE));
end;

function TfrmCadCotacao.fCarregaDadosCompraEmbalagem(Const strCodIte: String; Var strCodUni: String;
  Var strSigUni: String; Var fltEmbala: Double): Boolean;
  Var
    qryItem: TUniQuery;
begin
  qryItem := fCriaQuery(Self);

  With qryItem, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT SQL_NO_CACHE');
    Add('  ITE_UNICOM,      ');
    Add('  UNI_SIGUNI,      ');
    Add('  ITE_EMBALA       ');
    Add('FROM               ');
    Add('  CADITE           ');
    Add('  LEFT JOIN CADUNI ON ITE_UNICOM = UNI_CODUNI');
    Add('WHERE ');
    Add('  ITE_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := FieldByName('ITE_EMBALA').AsFloat > 0;

    If Result Then
    Begin
      fltEmbala := FieldByName('ITE_EMBALA').AsFloat;
      strCodUni := FieldByName('ITE_UNICOM').AsString;
      strSigUni := FieldByName('UNI_SIGUNI').AsString;
    End;

  End;

  FreeAndNil(qryItem);
end;

end.
