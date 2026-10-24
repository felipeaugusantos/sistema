unit untDllRelatorios;

interface

uses TypesRel, untFuncoesFactory, Uni, System.Classes, UniSQLMonitor,
  Dialogs, DASQLMonitor, DBAccess, StrUtils, SysUtils, CRAccess, untLogForm,
  Data.DB, Vcl.Forms, Vcl.stdCtrls, EditFocus;

  Procedure pSetaModulos(recModModulos: TRecModulos);
  Procedure pCriaModulos(varRecVariaveis: TRecVariaveis);
  Procedure pSetaVariaveis(varRecVariaveis: TRecVariaveis);
  Procedure pSetaConnection(Modulo: TDataModule);
  Procedure pLiberaModulos;

implementation

uses untModulo, untIFuncoes, untTypesSistema, untCfgRel;

{ untDllRelatorios }

Procedure pSetaModulos(recModModulos: TRecModulos);
Begin
  With recModModulos Do
  Begin
    frmModulo := TfrmModulo.Create(Nil);
    frmModulo.Database.AssignConnect(Banco);
  End;
End;

Procedure pCriaModulos(varRecVariaveis: TRecVariaveis);
Begin
  pSetaVariaveis(varRecVariaveis);

  VS_strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  VS_strClaDev := fTransform(fCfgSis('CLADEV'), 4);
  VS_strClaCom := fTransform(fCfgSis('CLACOM'), 4);
  VS_strCla_UC := fCfgSis('CLA_UC');
  VS_strTabPrc := fCfgSis('TABPRC');
  If Length(VS_strTabPrc) < 7 Then
    VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));
  VS_strCliFil := fRetClientesFilial;

  If fArqIni(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S') <> 'N' Then
    Try
      TCfgRel.VS_SpoolImpressaoCitel := fCfgSis('SPOIMP', varBoolean);
    Except
      //do nothing
    End;
End;

procedure pInicializarCfgRel();
begin
  TCfgRel.fCriaQuery := untFuncoesFactory.fCriaQuery;
  TCfgRel.fCriarQuery := untFuncoesFactory.fCriarQuery;
  TCfgRel.fRetAutoIncrem := untFuncoesFactory.fRetAutoIncrem;
  TCfgRel.fInTransaction := untFuncoesFactory.fInTransaction;
  TCfgRel.fCampoTabela := untFuncoesFactory.fCampoTabela;
  TCfgRel.pCriarFormularios := untFuncoesFactory.pCriarFormularios;
  TCfgRel.pFreeAndNil := untFuncoesFactory.pFreeAndNil;
  TCfgRel.pMensagensErro := untFuncoesFactory.pMensagensErro;
  TCfgRel.fCfgSis := untFuncoesFactory.fCfgSis;
  TCfgRel.fEmptyStr := untFuncoesFactory.fEmptyStr;
  TCfgRel.pSetFocus := untFuncoesFactory.pSetFocus;
  TCfgRel.fMensagem := untFuncoesFactory.fMensagem;
  TCfgRel.pMensagemOk := untFuncoesFactory.pMensagemOk;
  TCfgRel.fEntraCons := untFuncoesFactory.fEntraCons;
  TCfgRel.fRetNomeOperador := untFuncoesFactory.fRetNomeOperador;
  TcfgRel.fGetTituloVersao := untFuncoesFactory.fGetTituloVersao;
  TCfgRel.fGetUsuarioLogado := untFuncoesFactory.fGetUsuarioLogado;
  TCfgRel.fGetEmpresaLogada := untFuncoesFactory.fGetEmpresaLogada;
  TCfgRel.fRetNomeRede := untFuncoesFactory.fRetNomeRede;
  TCfgRel.fGetIPAddress := untFuncoesFactory.GetIPAddress;
  TCfgRel.fGetIPAddressAsString := untFuncoesFactory.GetIPAddressAsString;
  TCfgRel.fGetMacAddress := untFuncoesFactory.GetMacAddress;
  TCfgRel.fGetUserFromWindows := untFuncoesFactory.GetUserFromWindows;
  TCfgRel.fGetComputerNetName := untFuncoesFactory.GetComputerNetName;
  TCfgRel.fPesqOperador := untFuncoesFactory.fPesqOperador;
  TCfgRel.fPesqConfiguracaoRel := untFuncoesFactory.fPesqConfiguracaoRel;
end;

Procedure pSetaVariaveis(varRecVariaveis: TRecVariaveis);
Begin
  untFuncoesFactory.VS_Date                   := varRecVariaveis.VS_Date;
  untFuncoesFactory.utcRegistros              := varRecVariaveis.utcRegistros;
  untFuncoesFactory.strLoginUsuarioLogado     := varRecVariaveis.strLoginUsuarioLogado;
  untFuncoesFactory.strDescriUsuarioLogado    := varRecVariaveis.strDescriUsuarioLogado;
  untFuncoesFactory.strEmpAcessoUsuarioLogado := varRecVariaveis.strEmpAcessoUsuarioLogado;
  untFuncoesFactory.VS_strCodEmp              := varRecVariaveis.VS_strCodEmp;
  untFuncoesFactory.VS_strUsaTmq              := varRecVariaveis.VS_strUsaTmq;
  untFuncoesFactory.VS_strTitLot              := varRecVariaveis.VS_strTitLot;
  untFuncoesFactory.VS_strTitLts              := varRecVariaveis.VS_strTitLts;
  untFuncoesFactory.objFuncoes                := varRecVariaveis.objFuncoes;
  untFuncoesFactory.strPortadoresOperador     := varRecVariaveis.strPortadoresOperador;
  untFuncoesFactory.arrProCod                 := varRecVariaveis.arrProCod;
  untFuncoesFactory.objTrace                  := varRecVariaveis.objTrace;
  untFuncoesFactory.VS_objTraceViewer         := varRecVariaveis.objTraceViewer;

  TLogForm.strCodEmp := untFuncoesFactory.VS_strCodEmp;
  TLogForm.strCodOpe := untFuncoesFactory.strLoginUsuarioLogado;
  TLogForm.dtaDtaLog := untFuncoesFactory.VS_Date;
  TLogForm.fncCriaQuery := untFuncoesFactory.fCriaQuery;
  TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM');

  pInicializarCfgRel();
End;

Procedure pSetaConnection(Modulo: TDataModule);
  Var
    intIndex: Integer;
Begin
  With Modulo Do
  For intIndex := 0 To ComponentCount - 1 Do
    If Components[intIndex] Is TUniQuery Then
      (Components[intIndex] As TUniQuery).Connection := frmModulo.Database;
End;

Procedure pLiberaModulos;
Begin
  pDestroiModulo(frmModulo);
End;

end.
