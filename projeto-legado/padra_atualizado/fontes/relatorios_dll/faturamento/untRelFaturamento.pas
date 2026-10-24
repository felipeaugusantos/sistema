unit untRelFaturamento;

interface

Uses Forms, dxCore, SysUtils, StrUtils;

procedure prelfaturamento(prmDllRel: Pointer);

implementation

uses
  TypesRel, untDllRelatorios, untIFuncoes, System.Classes,
  untFuncoesFactory, untConstantes,
  untrelFatVendasMarkup,
  untrelFatEmiDiaria,
  untrelFatComVendedor,
  untRelComissaoProfissionalCTR,
  untrelFatVendasCliente,
  untrelFatVendasClienteF9,
  untrelFatItensVenMod,
  untrelFatRelOrc,
  untrelFatExtratoFatFuturo,
  untrelFatDocConfOutroCliente,
  untrelFatVendasDiarias,
  untrelFatVendasDiariasLoja,
  untrelFatVenTipFat,
  untrelFatDocsCancelados,
  untrelFatServicosCliente,
  untrelFatVenTransp,
  untrelFatLogLib,
  untrelFatMargemDocumento,
  untrelFatMetasVendedor,
  untrelFatTipoDoc,
  untrelFatEvolVendas,
  untrelFatDemonstracaoCamp,
  untrelFatComparatVenda,
  untrelFatDocsConfirmados,
  untrelFatTransferencias,
  untrelFatBocaCaixaVendedor,
  untRelFatMetasVendedorCtr,
  untRelFatConfDiariaCaixa,
  untRelFatDespAcessoria,
  untRelFatComVendInd,
  untRelFatComVendPes,
  untRelFatVendasCondPagto,
  untRelFatComEntregadores,
  untRelFatComVenPropLucro,
  untRelFatEmprestimos,
  untrelFatEvolVendasMes,
  untrelFatEvolVendasPeriodo,
  untRelFatDemonstraDespesas,
  untRelFatMetasVendedorLitGal,
  untRelFatVendasPerdidas,
  untRelBrindesProfissionais,
  untRelFatReciboAvulso,
  untRelFatSepMercadoria,
  untRelFatComVendRec,
  untRelFatEvolVendasGrafico,
  untRelFatComissaoEspecie,
  untRelFatComVendedorMod1,
  untRelFatDistrSherWill,
  untRelFatMetasClientes,
  untRelFatAltVendedorDoc,
  untRelFatRoterizacaoPedVen,
  untRelFatDevolucoesVenda,
  untRelFatBonificacao,
  untRelFatAcompanhaPromocao,
  untRelFatVendasConcreto,
  untRelFatComFatVend,
  untRelFatAgroSemReceit,
  untRelFatItensVendidosEnderecoEntrega,
  untRelFatCtlTempoEspera,
  untRelFatVendaConjunto,
  untRelFatPorProduto,
  untRelFatExtratoProfissional,
  untRelFatMetasVendedorLitragem,
  untRelFatComVendDepart,
  untRelFatComDepart,
  untRelFatComGerente,
  untRelComissaoVendedorCTRPrevia,
  untRelFatMetasFornecValFat,
  untRelFatComVendCndDes,
  untRelFatDocumentoTipoEnt,
  untRelFatMetasVendDeparProd,
  untRelFatComMecanicos,
  untRelFatMetasVendAtivCliente,
  untRelFatVendasClienteTablet,
  untRelFatComFaixaDescTabPreco,
  untRelFatAltDescricaoFat,
  untRelFatComVendFat,
  untRelFatLogAltEntregaFutura,
  untRelFatServAtendCliente,
  untRelFatMapDemonsEstoq,
  untRelFatMetFaturamentoEmp;

procedure pRelFatComVendedor(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel Do
  Begin

    Try
      pCriarFormularios(TfrmRelFatComVendedor, frmRelFatComVendedor);
      frmRelFatComVendedor.blnSenha := True;
      frmRelFatComVendedor.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pRelFatComVendedor]');
      End;
    End;

    pFreeAndNil(frmRelFatComVendedor);

  End;
End;

procedure pRelFatVendasCliente_1(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If Not blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasCliente, frmRelFatVendasCliente);
        frmRelFatVendasCliente.blnSenha      := True;
        frmRelFatVendasCliente.blnFiltroCFOP := True;
        frmRelFatVendasCliente.blnVeioTelaVendas := True;
        frmRelFatVendasCliente.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_1]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasCliente);
      
    End;
  End;
End;

procedure pRelFatVendasCliente_2(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasCliente, frmRelFatVendasCliente);
        frmRelFatVendasCliente.blnFaturamento := True;

        pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);

        With frmRelFatVendasClienteF9 Do
        Begin
          frmRelFatVendasClienteF9.pMostrarProdutos(String(strCtr_DupPar),String(strCtr_EspDoc),String(strCtr_CodEmp),False,String(strCodCli));

          ShowModal;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_2]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasClienteF9);
      pFreeAndNil(frmRelFatVendasCliente);

    End;
  End;
End;

procedure pRelFatVendasCliente_3(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);
        With frmRelFatVendasClienteF9 Do
        Begin

          pMostrarProdutos(String(strCtr_DupPar),
                           String(strCtr_EspDoc),
                           String(strCtr_CodEmp),
                           False,
                           String(strCodCli));

          ShowModal;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_3]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasClienteF9);

    End;
  End;
End;

procedure pRelFatVendasCliente_4(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
        frmRelFatVendasCliente.blnFaturamento := True;
        frmRelFatVendasCliente.blnSenha       := False;

        If Not fClienteConsumidor(String(strNomCli), False, True) Then
        Begin
          frmRelFatVendasCliente.blnCliCons         := False;
          frmRelFatVendasCliente.edtCodCliente.Text := String(strCodCli);
          frmRelFatVendasCliente.edtDesCliente.Text := String(strNomCli);
        End
        Else
        Begin
          frmRelFatVendasCliente.blnCliCons := True;
        End;

        frmRelFatVendasCliente.ShowModal;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_4]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasCliente);

    End;
  End;
End;

procedure pRelFatVendasCliente_5(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      If Not blnVeioDoTablet Then
      Begin
        Try
          pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
          frmRelFatVendasCliente.blnFaturamento         := True;
          frmRelFatVendasCliente.blnSenha               := False;
          frmRelFatVendasCliente.blnVeioDoTelemarketing := blnVeioDoTelemarketing;
          frmRelFatVendasCliente.blnVeioDoTablet        := blnVeioDoTablet;
          frmRelFatVendasCliente.edtCodCliente.Text     := String(strCodCli);
          frmRelFatVendasCliente.edtDesCliente.Text     := String(strNomCli);
          frmRelFatVendasCliente.blnSomenteVendas       := TRUE;
          frmRelFatVendasCliente.blnVeioTelaVendas      := blnVeioTelaVendas;
          
          If Not fClienteConsumidor(String(strNomCli), False, True) Then
          Begin
            frmRelFatVendasCliente.blnCliCons           := False;
          End
          Else
          Begin
            frmRelFatVendasCliente.blnCliCons := True;
          End;

          frmRelFatVendasCliente.ShowModal;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[pRelFatVendasCliente_5]');
          End;
        End;

        pFreeAndNil(frmRelFatVendasCliente);
      End
      Else
      Begin
        Try
          Try
            pCriarFormularios(TfrmRelFatVendasClienteTablet, frmRelFatVendasClienteTablet);

            With frmRelFatVendasClienteTablet Do
            Begin
              blnSelDocumentos := TRUE;
              pMostrarProdutos('','','',False,String(strCodCli));

              ShowModal;
            End;
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[pRelFatVendasCliente_5]');
            End;
          End;
        Finally
          pFreeAndNil(frmRelFatVendasClienteTablet);
        End;
      End;
    End;
  End;
End;

procedure pRelFatVendasCliente_6(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);

        With frmRelFatVendasClienteF9 Do
        Begin
          frmRelFatVendasClienteF9.pMostrarProdutos(String(strCtr_DupPar),String(strCtr_EspDoc),String(strCtr_CodEmp),False,String(strCodCli));

          ShowModal;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_6]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasClienteF9);
      
    End;
  End;
End;

procedure pRelFatVendasCliente_7(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);

        With frmRelFatVendasClienteF9 Do
        Begin
          frmRelFatVendasClienteF9.pMostrarProdutos(String(strCtr_DupPar),String(strCtr_EspDoc),String(strCtr_CodEmp),False,String(strCodCli));

          ShowModal;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_7]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasClienteF9);

    End;
  End;
End;

procedure pRelFatVendasCliente_8(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);

        frmRelFatVendasCliente.blnSenha        := False;
        frmRelFatVendasCliente.blnFaturamento  := False;
        frmRelFatVendasCliente.blnCliCons      := False;
        frmRelFatVendasCliente.blnConsultaItem := True;

        frmRelFatVendasCliente.mskLinhaGrupo.Enabled := False;
        frmRelFatVendasCliente.edtProdutos.Enabled   := False;
        frmRelFatVendasCliente.edtProdutos.Text      := String(strCodIte);
        frmRelFatVendasCliente.edtProdutosExit(frmRelFatVendasCliente.edtProdutos);

        frmRelFatVendasCliente.ShowModal;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_8]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasCliente);

    End;
  End;
End;

procedure pRelFatVendasCliente_9(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
        frmRelFatVendasCliente.blnFaturamento         := TRUE;
        frmRelFatVendasCliente.blnSenha               := TRUE;
        frmRelFatVendasCliente.blnVeioDoTelemarketing := blnVeioDoTelemarketing;
        frmRelFatVendasCliente.blnPorVendedor         := TRUE;
        frmRelFatVendasCliente.edtCodVendedor.Text    := String(strCodVen);
        frmRelFatVendasCliente.blnSomenteVendas       := TRUE;
        frmRelFatVendasCliente.blnVeioTelaVendas      := blnVeioTelaVendas;
        frmRelFatVendasCliente.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasCliente_9]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasCliente);

    End;
  End;
End;

procedure pRelFatVendasPorLinha(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel, varRecEst Do
  Begin
    If blnTemParametros Then
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasCliente, frmRelFatVendasCliente);
        frmRelFatVendasCliente.blnFaturamento         := True;
        frmRelFatVendasCliente.blnSenha               := True;
        frmRelFatVendasCliente.blnVeioDoTelemarketing := True;
        frmRelFatVendasCliente.blnPorVendedor         := True;
        frmRelFatVendasCliente.blnPorLinha            := True;
        frmRelFatVendasCliente.edtCodVendedor.Text    := String(strCodVen);
        frmRelFatVendasCliente.blnSomenteVendas       := True;
        frmRelFatVendasCliente.oleVendas              := oleDados;

        frmRelFatVendasCliente.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelFatVendasPorLinha]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasCliente);

    End;
  End;
End;

procedure pRelFatMetasVendedor(objDllRel: TParamDllRelFaturamento);
Begin
  pCriarFormularios(TfrmRelFatMetasVendedor, frmRelFatMetasVendedor);
  Try
    frmRelFatMetasVendedor.blnPreencherAutomatico := objDllRel.varRecEst.blnTemParametros;
    frmRelFatMetasVendedor.blnAbrirDireto         := objDllRel.varRecEst.blnAbreDireto;    
    frmRelFatMetasVendedor.ShowMOdal;
  Finally
    pFreeAndNil(frmRelFatMetasVendedor);
  End;
End;

procedure pRelFatEmprestimos(objDllRel: TParamDllRelFaturamento);
begin
  With objDllRel, varRecEst Do
  Begin
    Try
      pCriarFormularios(TfrmRelFatEmprestimos, frmRelFatEmprestimos);
      frmRelFatEmprestimos.edtProdutos.Text := String(strCodIte);
      frmRelFatEmprestimos.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[]');
      End;
    End;

    pFreeAndNil(frmRelFatEmprestimos);
  End;
end;

procedure pRelFatComGerente(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel Do
  Begin

    Try
      pCriarFormularios(TfrmRelFatComGerente, frmRelFatComGerente);
      frmRelFatComGerente.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pRelFatComGerente]');
      End;
    End;

    pFreeAndNil(frmRelFatComGerente);

  End;
End;

procedure prelfaturamento(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelFaturamento;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelFaturamento');
    
    Case relTipRel of
      relFatVendasMarkup          : pCriarForm(TfrmRelFatVendasMarkup, frmRelFatVendasMarkup);
      relFatEmiDiaria             : pCriarForm(TfrmRelFatEmiDiaria, frmRelFatEmiDiaria);
      relFatComVendedor           : pRelFatComVendedor(objDllRel);
      relComissaoProfissionalCTR  : pCriarForm(TfrmRelComissaoProfissionalCTR,frmRelComissaoProfissionalCTR);
      relFatVendasCliente_1       : pRelFatVendasCliente_1(objDllRel);
      relFatVendasCliente_2       : pRelFatVendasCliente_2(objDllRel);
      relFatVendasCliente_3       : pRelFatVendasCliente_3(objDllRel);
      relFatVendasCliente_4       : pRelFatVendasCliente_4(objDllRel);
      relFatVendasCliente_5       : pRelFatVendasCliente_5(objDllRel);
      relFatVendasCliente_6       : pRelFatVendasCliente_6(objDllRel);
      relFatVendasCliente_7       : pRelFatVendasCliente_7(objDllRel);
      relFatVendasCliente_8       : pRelFatVendasCliente_8(objDllRel);
      relFatVendasCliente_9       : pRelFatVendasCliente_9(objDllRel);
      relFatVendasPorLinha        : pRelFatVendasPorLinha(objDllRel);
      relFatItensVenMod           : pCriarForm(TfrmRelFatItensVenMod, frmRelFatItensVenMod);
      relFatRelOrc                : pCriarForm(TfrmRelFatRelOrc, frmRelFatRelOrc);
      relFatExtratoFatFuturo      : pCriarForm(TfrmRelFatExtratoFatFuturo, frmRelFatExtratoFatFuturo);
      relFatDocConfOutroCliente   : pCriarForm(TfrmRelFatDocConfOutroCliente, frmRelFatDocConfOutroCliente);
      relFatVendasDiarias         : pCriarForm(TfrmRelFatVendasDiarias,frmRelFatVendasDiarias);
      relFatVendasDiariasLoja     : pCriarForm(TfrmRelFatVendasDiariasLoja, frmRelFatVendasDiariasLoja);
      relFatVenTipFat             : pCriarForm(TfrmRelFatVenTipFat, frmRelFatVenTipFat);
      relFatDocsCancelados        : pCriarForm(TfrmRelFatDocsCancelados, frmRelFatDocsCancelados);
      relFatServicosCliente       : pCriarForm(TfrmRelFatServicosCliente, frmRelFatServicosCliente);
      relFatVenTransp             : pCriarForm(TfrmRelFatVenTransp, frmRelFatVenTransp);
      relFatLogLib                : pCriarForm(tfrmRelFatLogLib,frmRelFatLogLib);
      relFatMargemDocumento       : pCriarForm(TfrmRelFatMargemDocumento,frmRelFatMargemDocumento);
      relFatMetasVendedor         : pRelFatMetasVendedor(objDllRel);
      relFatTipoDoc               : pCriarForm(TfrmRelFatTipoDoc,frmRelFatTipoDoc);
      relFatEvolVendas            : pCriarForm(TfrmRelFatEvolVendas, frmRelFatEvolVendas);
      relFatDemonstracaoCamp      : pCriarForm(TfrmRelFatDemostracaoCamp, frmRelFatDemostracaoCamp);
      relFatComparatVenda         : pCriarForm(TfrmRelFatComparatVenda, frmRelFatComparatVenda);
      relFatDocsConfirmados       : pCriarForm(TfrmRelFatDocsConfirmados, frmRelFatDocsConfirmados);
      relFatTransferencias        : pCriarForm(TfrmRelFatTransferencias, frmRelFatTransferencias);
      relFatBocaCaixaVendedor     : pCriarForm(TfrmRelFatBocaCaixaVendedor, frmRelFatBocaCaixaVendedor);
      relFatMetasVendedorCtr      : pCriarForm(TfrmRelFatMetasVendedorCtr, frmRelFatMetasVendedorCtr);
      relFatConfDiariaCaixa       : pCriarForm(TfrmRelFatConfDiariaCaixa, frmRelFatConfDiariaCaixa);
      relFatDespAcessoria         : pCriarForm(TfrmRelFatDespAcessoria, frmRelFatDespAcessoria);
      relFatComVendInd            : pCriarForm(TfrmRelFatComVendInd, frmRelFatComVendInd);
      relFatComVendPes            : pCriarForm(TfrmRelFatComVendPes, frmRelFatComVendPes);
      relFatAltDescricaoFat       : pCriarForm(TfrmRelFatAltDescricaoFat, frmRelFatAltDescricaoFat);
      relFatVendasCondPagto       : pCriarForm(TfrmRelFatVendasCondPagto, frmRelFatVendasCondPagto);
      relFatComEntregadores       : pCriarForm(TfrmRelFatComEntregadores, frmRelFatComEntregadores);
      relFatComVendFat            : pCriarForm(TfrmRelFatComVendFat, frmRelFatComVendFat);
      relFatComVenPropLucro       : pCriarForm(TfrmRelFatComVenPropLucro, frmRelFatComVenPropLucro);
      relFatEmprestimos           : pRelFatEmprestimos(objDllRel);
      relFatEvolVendasPeriodo     : pCriarForm(TfrmRelFatEvolVendasPeriodo, frmRelFatEvolVendasPeriodo);
      relFatDemonstraDespesas     : pCriarForm(TfrmRelFatDemonstraDespesas, frmRelFatDemonstraDespesas);
      relFatMetasVendedorLitGal   : pCriarForm(TfrmRelFatMetasVendedorLitGal, frmRelFatMetasVendedorLitGal);
      relFatVendasPerdidas        : pCriarForm(TfrmRelFatVendasPerdidas, frmRelFatVendasPerdidas);
      relBrindesProfissionais     : pCriarForm(TfrmRelBrindesProfissionais, frmRelBrindesProfissionais);
      relFatReciboAvulso          : pCriarForm(TfrmRelFatReciboAvulso, frmRelFatReciboAvulso);
      relFatSepMercadoria         : pCriarForm(TfrmRelFatSepMercadoria, frmRelFatSepMercadoria);
      relFatComVendRec            : pCriarForm(TfrmRelFatComVendRec, frmRelFatComVendRec);
      relFatEvolVendasGrafico     : pCriarForm(TfrmRelFatEvolVendasGrafico, frmRelFatEvolVendasGrafico);
      relFatEvolVendasMes         : pCriarForm(TfrmRelFatEvolVendasMes, frmRelFatEvolVendasMes);
      relFatComissaoEspecie       : pCriarForm(TfrmRelFatComissaoEspecie, frmRelFatComissaoEspecie);
      relFatComVendedorMod1       : pCriarForm(TfrmRelFatComVendedorMod1, frmRelFatComVendedorMod1);
      relFatDistrSherWill         : pCriarForm(TfrmRelFatDistrSherWill, frmRelFatDistrSherWill);
      relFatMetasClientes         : pCriarForm(TfrmRelFatMetasClientes, frmRelFatMetasClientes);
      relFatAltVendedorDoc        : pCriarForm(TfrmRelFatAltVendedorDoc, frmRelFatAltVendedorDoc);
      relFatRoterizacaoPedVen     : pCriarForm(TfrmRelFatRoterizacaoPedVen, frmRelFatRoterizacaoPedVen);
      relFatDevolucoesVenda       : pCriarForm(TfrmRelFatDevolucoesVenda, frmRelFatDevolucoesVenda);
      relFatBonificacao           : pCriarForm(TfrmRelFatBonificacao, frmRelFatBonificacao);
      relFatAcompanhaPromocao     : pCriarForm(TfrmRelFatAcompanhaPromocao, frmRelFatAcompanhaPromocao);
      relFatLogAltEntregaFutura   : pCriarForm(TfrmRelFatLogAltEntregaFutura, frmRelFatLogAltEntregaFutura);
      relFatServAtendCliente      : pCriarForm(TfrmRelFatServAtendCliente, frmRelFatServAtendCliente);
      relFatVendasConcreto        : pCriarForm(TfrmRelFatVendasConcreto, frmRelFatVendasConcreto);
      relFatComFatVend            : pCriarForm(TfrmRelFatComFatVend, frmRelFatComFatVend);
      relFatAgroSemReceit         : pCriarForm(TfrmRelFatAgroSemReceit, frmRelFatAgroSemReceit);
      relFatItensVendEndEntrega   : pCriarForm(TfrmRelFatItensVendidosEnderecoEntrega, frmRelFatItensVendidosEnderecoEntrega);
      relFatCtlTempoEspera        : pCriarForm(TfrmRelFatCtlTempoEspera, frmRelFatCtlTempoEspera);
      relFatVendaConjunto         : pCriarForm(TfrmRelFatVendaConjunto, frmRelFatVendaConjunto);
      relFatPorProduto            : pCriarForm(TfrmRelFatPorProduto, frmRelFatPorProduto);
      relFatExtratoProfissional   : pCriarForm(TfrmRelFatExtratoProfissional, frmRelFatExtratoProfissional);
      relFatMetasVendedorLitragem : pCriarForm(TfrmRelFatMetasVendedorLitragem, frmRelFatMetasVendedorLitragem);
      relFatComVendDepart         : pCriarForm(TfrmRelFatComVendDepart, frmRelFatComVendDepart);
      relFatComDepart             : pCriarForm(TfrmRelFatComDepart, frmRelFatComDepart);
      relFatComGerente            : pRelFatComGerente(objDllRel);
      relComissaoVendedorCTRPrevia: pCriarForm(TfrmRelComissaoVendedorCTRPrevia,frmRelComissaoVendedorCTRPrevia);
      relFatMapDemonsEstoq        : pCriarForm(TfrmRelFatMapDemonsEstoq, frmRelFatMapDemonsEstoq);
      relFatMetasFornecValFat     : pCriarForm(TfrmRelFatMetasFornecValFat, frmRelFatMetasFornecValFat);
      relFatComVendCndDes         : pCriarForm(TfrmRelFatComVendCndDes, frmRelFatComVendCndDes);
      relFatDocumentoTipoEnt      : pCriarForm(TfrmRelFatDocumentoTipoEnt, frmRelFatDocumentoTipoEnt);
      relFatMetFaturamentoEmp     : pCriarForm(TfrmRelFatMetFaturamentoEmp, frmRelFatMetFaturamentoEmp);      
      relFatMetasVendDeparProd    : pCriarForm(TfrmRelFatMetasVendDeparProd, frmRelFatMetasVendDeparProd);
      relFatComMecanicos          : pCriarForm(TfrmRelFatComMecanicos, frmRelFatComMecanicos);
      relFatMetasVendAtivCliente  : pCriarForm(TfrmRelFatMetasVendAtivCliente, frmRelFatMetasVendAtivCliente);
      relFatComissaoFaixaDescTabPre : pCriarForm(TfrmRelFatComFaixaDescTabPreco, frmRelFatComFaixaDescTabPreco);
    End;

  End;

  pLiberaModulos;
End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
