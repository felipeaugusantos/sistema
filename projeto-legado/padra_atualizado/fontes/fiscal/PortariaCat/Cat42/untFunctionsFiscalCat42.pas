unit untFunctionsFiscalCat42;

interface

uses untConstCompartilhadaCat42, Dialogs, Uni, untFuncoes, untFuncoesSimples, untGravando,
     System.SysUtils, System.Classes, Vcl.Forms, Vcl.Themes, Vcl.Styles, Vcl.SysStyles;

function fChamaProcessoCat42(ATipoChamadaCat42: TTipoChamadaCat42; Var varParametros: TCat42Variaveis): Boolean;stdcall;
procedure pCriarTabelaDescricaoEnquadramento;

implementation

uses
  untExpCat42, untRelCat42v2, untCadEnquadramentoCat42, untCfgCat42, untModulo, untModuloReplicacao;


function fChamaProcessoCat42(ATipoChamadaCat42: TTipoChamadaCat42; Var varParametros: TCat42Variaveis): Boolean;
var
  qryAux: TUniQuery;

Begin
  {Carrega os mudulo conectar banco....}
  Result := true;
  {carrega as variaveis}
  With varParametros Do
  Begin
    VS_Date                   := dtaVSDate;
    strLoginUsuarioLogado     := String(strLogUsu);
    strDescriUsuarioLogado    := String(strDesUsu);
    strEmpAcessoUsuarioLogado := String(strEmpUsu);
    strEmpEstUsuarioLogado    := String(strEmpEst);
    VS_strCodEmp              := String(strEmpCod);
    VS_strClaVen              := String(strClaVen);
    VS_strClaDev              := String(strClaDev);
  End;

  untFuncoes.blnUsuarioLogadoUtilizaModoClassico :=  varParametros.blnUsuarioLogadoUtilizaModoClassico;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Try
      TStyleManager.TrySetStyle('Sapphire Kamri');
      TfrmGravando.CorPadraoTema := $005A3E00;

      TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
    Except
      blnUsuarioLogadoUtilizaModoClassico := True;
    End;
  End;

  Try
    {carrega os modulos}
    Try
      //pSetaModulos
      frmModulo := TfrmModulo.CreateInstance(Nil, False);

      //pCriaModulos
      pCriarFormularios(TfrmModulo, frmModulo);
      pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fChamaProcessoCat42]');
        Application.Terminate;
      End;
    End;

    Case ATipoChamadaCat42 of
      tcc42Tela1:
                  Begin
                    pCriarFormularios(TfrmExpCat42, frmExpCat42);
                    Try
                      frmExpCat42.ShowModal;
                    Finally
                      pFreeAndNil(frmExpCat42);
                    end;
                  End;
      tcc42Tela2:
                  Begin
                    If (StrToInt(fCfgSpd('PRECO_INV_CAT42')) < 0) Or
                       (StrToInt(fCfgSpd('PRECO_INV_CAT42_COM_ST')) < 0) Then
                    Begin
                      fMensagem('', 'Configurar o Preço Inventário da empresa logada para Geração da CAT42 !', ['&Ok']);
                      Exit;
                    End
                    Else
                    Begin
                      pCriarFormularios(TfrmRelCat42v2, frmRelCat42v2);
                      Try
                        frmRelCat42v2.ShowModal;
                      Finally
                        FreeAndNil(frmRelCat42v2);
                      End;
                    End;
                  End;
      tcc42Tela3:
                  Begin
                    qryAux := fCriaQuery(nil);
                    try
                      with qryAux do
                      begin
                        Close;
                        SQL.Clear;
                        SQL.Add('  CREATE TABLE IF NOT EXISTS CADENQ (');
                        SQL.Add('    AUTOINCREM varchar(20) NOT NULL,');
                        SQL.Add('    ENQ_CODENQ varchar(20) NOT NULL,');
                        SQL.Add('    ENQ_CLAFIS varchar(255) DEFAULT NULL,');
                        SQL.Add('    ENQ_CODFIS varchar(255) DEFAULT NULL,');
                        SQL.Add('  PRIMARY KEY (AUTOINCREM),');
                        SQL.Add('  UNIQUE KEY IDX_COD_ENQUAD (ENQ_CODENQ)');
                        SQL.Add(') ENGINE=InnoDB DEFAULT CHARSET=latin1');
                        ExecSQL;
                      end;
                    finally
                      qryAux.Free;
                    end;

                    if not fTabelaExiste('DESENQ') then
                      pCriarTabelaDescricaoEnquadramento;

                    pVerificaProCod;
                    pValidaProCod('CADENQ');
                    pValidaProCod('DESENQ');

                    pCriarFormularios(TfrmCadEnquadramentoCat42, frmCadEnquadramentoCat42);
                    try
                      frmCadEnquadramentoCat42.ShowModal;
                    finally
                      pFreeAndNil(frmCadEnquadramentoCat42);
                    end;
                  End;
      tcc42Tela4:
                  Begin
                    If fTabelaExiste('CFGSPD') then
                    Begin
                      pCriarFormularios(TfrmCfgCat42, frmCfgCat42);
                      Try
                        frmCfgCat42.ShowModal;
                      Finally
                        pFreeAndNil(frmCfgCat42);
                      end;
                    End
                    Else
                      fMensagem('AVISO', 'É necessário criar a tabela "CFGSPD" para continuação do processo, favor entrar em contato com a citel!', ['OK']);
                  End;
    End;

  Finally
    FreeAndNil(frmModuloReplicacao);
    FreeAndNil(frmModulo);
  end;
End;

procedure pCriarTabelaDescricaoEnquadramento;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := '  CREATE TABLE IF NOT EXISTS DESENQ ( ' +
                  '  AUTOINCREM VARCHAR (20) NOT NULL DEFAULT "", ' +
                  '  ENQ_DESENQ VARCHAR (100) DEFAULT NULL, ' +
                  '  PRIMARY KEY (AUTOINCREM) ' +
                  ') ENGINE = INNODB DEFAULT CHARSET = latin1 ';
      ExecSQL;

      pVerificaProCod;
      pValidaProCod('DESENQ');

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);
      ParamByName('DESCRICAO').AsString := '0 - Saída para comercialização subsequente (demais saídas) ';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);
      ParamByName('DESCRICAO').AsString := '1 - Saída a consumidor ou usuário final';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
      ParamByName('DESCRICAO').AsString := '2 - Fato gerador não realizado';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
      ParamByName('DESCRICAO').AsString := '3 - Saída ou saída subsequente com isenção ou não incidência';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
      ParamByName('DESCRICAO').AsString := '4 - Saída para outro estado';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
      ParamByName('DESCRICAO').AsString := '5 - Devoluções';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO DESENQ (AUTOINCREM, ENQ_DESENQ) VALUES (:AUTOINCREM, :DESCRICAO); ';
      ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESENQ', VS_strCodEmp);;
      ParamByName('DESCRICAO').AsString := '6 - Entradas';
      ExecSQL;
    end;
  finally
    qryAux.Free;
  end;
end;


end.
