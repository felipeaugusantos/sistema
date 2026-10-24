unit untIconesPedidos;

interface

Uses
  untClassPanelCx,
  Uni;

Procedure pCarregaIcones(cdsCampos: TUniQuery; objDefConsulta: TDefConsulta);

implementation

Uses
  SysUtils,
  untFuncoesSimples,
  untTSituacaoPedidoVenda;

Procedure pCarregaIcones(cdsCampos: TUniQuery; objDefConsulta: TDefConsulta);
  Var
    strKey: String;
    arrOpc: TarrCampos;
Begin

  Case cdsCampos.FieldByName('CAM_CONFIG').AsInteger Of
    1: Begin
         objDefConsulta.pIncluiCampoProcessado(cdsCampos.FieldByName('CAM_ALIAS_').AsString);

         SetLength(arrOpc, 0);
         For strKey In TSituacaoPedidoVenda.fRetornaLegenda.Keys Do
         Begin
           objDefConsulta.pIncluiIcone(cdsCampos.FieldByName('CAM_ALIAS_').AsString, strKey, TSituacaoPedidoVenda.fRetornaLegenda.Items[strKey], False, frmModuloLegenda.imglLegenda);

           SetLength(arrOpc, Succ(Length(arrOpc)));
           arrOpc[Pred(Length(arrOpc))] := AnsiUpperCase(strKey);
         End;

         SetLength(arrOpc, Succ(Length(arrOpc)));
         arrOpc[Pred(Length(arrOpc))] := 'TODOS';
         objDefConsulta.pIncluiCampoSimNao(cdsCampos.FieldByName('CAM_ALIAS_').AsString, arrOpc);

         SetLength(arrOpc, 0);
       End;

    2: Begin
         objDefConsulta.pIncluiCampoProcessado(cdsCampos.FieldByName('CAM_ALIAS_').AsString);

         SetLength(arrOpc, 0);
         For strKey In TSituacaoPedidoVenda.fRetornaLegendaFin.Keys Do
         Begin
           objDefConsulta.pIncluiIcone(cdsCampos.FieldByName('CAM_ALIAS_').AsString, strKey, TSituacaoPedidoVenda.fRetornaLegendaFin.Items[strKey], False, frmModuloLegenda.imglSitFin);

           SetLength(arrOpc, Succ(Length(arrOpc)));
           arrOpc[Pred(Length(arrOpc))] := UpperCase(strKey);
         End;

         SetLength(arrOpc, Succ(Length(arrOpc)));
         arrOpc[Pred(Length(arrOpc))] := 'TODOS';

         objDefConsulta.pIncluiCampoSimNao(cdsCampos.FieldByName('CAM_ALIAS_').AsString, arrOpc);

         SetLength(arrOpc, 0);
       End;

    3: Begin
         objDefConsulta.pIncluiCampoProcessado(cdsCampos.FieldByName('CAM_ALIAS_').AsString);

         SetLength(arrOpc, 0);
         For strKey In TSituacaoPedidoVenda.fRetornaLegendaAdt.Keys Do
         Begin
           objDefConsulta.pIncluiIcone(cdsCampos.FieldByName('CAM_ALIAS_').AsString, strKey, TSituacaoPedidoVenda.fRetornaLegendaAdt.Items[strKey], True, frmModuloLegenda.imglSitAdt);

           SetLength(arrOpc, Succ(Length(arrOpc)));
           arrOpc[Pred(Length(arrOpc))] := UpperCase(strKey);
         End;

         objDefConsulta.pIncluiCampoSimNao(cdsCampos.FieldByName('CAM_ALIAS_').AsString, arrOpc);

         SetLength(arrOpc, 0);
       End;
  End;
End;

initialization

  prcCarregaIcones := pCarregaIcones;

end.
