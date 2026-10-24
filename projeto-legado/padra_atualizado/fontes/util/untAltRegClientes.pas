unit untAltRegClientes;

interface

uses
  Windows, Classes, Controls, Forms, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, EditFocus, QColorLabel, DBGridCitel, DBGrids, DB, Uni, untFuncoesSimples,
  BitBtnLockedIncrem, Grids, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus;

type
  TTipoAlteracao = (tpaRegiao, tpaSubRegiao);

  TfrmAltRegClientes = class(TfrmPai)
    pnlFundo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    ColorLabel1: TColorLabel;
    lbl5: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    edtStatus: TEditFocus;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    lbl6: TLabel;
    edtBairro: TEditFocus;
    lbl7: TLabel;
    edtCodSp1: TEditFocus;
    edtDesSp1: TEditFocus;
    lbl8: TLabel;
    edtCodSp2: TEditFocus;
    edtDesSp2: TEditFocus;
    lbl9: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    dbgGrid: TDBGridCitel;
    lbl12: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    pgbStatus: TProgressBar;
    btnConfirma: TBitBtnLocked;
    shpMultSel: TShape;
    lblCEP: TLabel;
    edtNumCep: TMaskEditFocus;
    lblRegiao: TLabel;
    edtCodRgo: TEditFocus;
    edtNomRgo: TEditFocus;
    edtNomSrg: TEditFocus;
    lblSubRegiao: TLabel;
    edtCodSrg: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSp1KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSp2KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodSp1Exit(Sender: TObject);
    procedure edtCodSp2Exit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodRgoExit(Sender: TObject);
    procedure edtCodSrgExit(Sender: TObject);
    procedure edtCodRgoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSrgKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrRede: TConsultasArray;
    qryGrid: TUniQuery;
    dtsGrid: TDataSource;

    tpaTipoAlteracao: TTipoAlteracao;

    arrClientes: TConsultasArray;
    arrCidade: TConsultasArray;
    arrVend: TConsultasArray;
    arrRepr : TConsultasArray;
    arrSp1 : TConsultasArray;
    arrSp2 : TConsultasArray;
    arrAtiv: TConsultasArray;
    arrRegioes   : TConsultasArray;
    arrSubRegiao : TConsultasArray;

    strClientes,
    strCidade,
    strRegiao,
    strSubRegiao,
    strVend,
    strRepr,
    strSp1,
    strSp2,
    strAtiv : string;

    procedure pCarregaGrid;
    procedure pLimpaTela;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesConsulta, untConsultas;

{$R *.dfm}

procedure TfrmAltRegClientes.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if (not qryGrid.Active) or (qryGrid.IsEmpty) then
  begin
    fMensagem('', 'Não ha dados a serem alterados!', ['&Ok']);
    Exit;
  end;

  if not fValidaCampos(edtCodReg, True) then
    Exit;

  If (fMensagem('','Confirma alteração?',['&Sim', '&Não'], 2) = 1) Then
  Begin
    btnConfirma.Enabled := False;

    Try
      With qryGrid Do
      Begin
        DisableControls;
        First;

        If Not IsEmpty Then
        Begin
          pgbStatus.Visible := True;
          pgbStatus.Max     := RecordCount;

          While Not Eof Do
          Begin
            Case tpaTipoAlteracao Of
              tpaRegiao:
                Begin
                  fExecutaSQL(' UPDATE CADCLI SET CLI_CODREG = "' + edtCodReg.Text + '" WHERE CLI_CODCLI = "' + FieldByName('CLI_CODCLI').AsString + '" ');

                  fExecutaSQL(' UPDATE ENTCLI SET ETC_CODREG = "' + edtCodReg.Text + '" WHERE ETC_CODCLI = "' + FieldByName('CLI_CODCLI').AsString + '" '+
                                                                                     '    AND ETC_ENDFAT = "S" ');
                End;

              tpaSubRegiao:
                Begin
                  fExecutaSQL(' UPDATE CADCLI SET CLI_CODSUB = "' + edtCodReg.Text + '" WHERE CLI_CODCLI = "' + FieldByName('CLI_CODCLI').AsString + '" ');
                End;
            End;

            Next;
            pnlInfo.Caption    := 'Registro: ' + IntToStr(RecNo) + '/' + IntToStr(RecordCount);
            pgbStatus.Position := RecNo;
            Application.ProcessMessages;
          End;

          fMensagem('','Alteração efetuada com sucesso em ' + IntToStr(RecordCount) + ' clientes!',['&OK']);

        End
        Else
          fMensagem('','Nenhum cliente foi encontrado com este dados!',['&OK']);

        Close;
        EnableControls;
      End;

      pgbStatus.Visible := False;

    Except

      On E: Exception Do
      Begin
				pMensagensErro(E.Message, '');
        pgbStatus.Visible := False;
        qryGrid.EnableControls;
        pLimpaTela;
      End;

    End;

    btnConfirma.Enabled := True;
  End;
  pnlInfo.Caption := '';
  pLimpaTela;
  SelectFirst;

end;

procedure TfrmAltRegClientes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrAtiv, fRetAtividade, nil, 'de atividade');
end;

procedure TfrmAltRegClientes.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv, False) Then
  Begin
    If fValidaCampos(edtCodAti, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, nil, 'da cidade');
end;

procedure TfrmAltRegClientes.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade, False) Then
  Begin
    If fValidaCampos(edtCodCid, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltRegClientes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRed.Enabled := False;
    edtCodRed.Clear;
    pEdtCodSelectExit(edtCodRed,edtDesRed,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetfocus(edtCodCid);
  End Else
  Begin
    edtCodRed.Enabled := True;
    pSetFocus(edtCodRed);
  End;
end;

procedure TfrmAltRegClientes.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.edtCodRegKeyPress(Sender: TObject; var Key: Char);
Var
  arrConsulta : TConsultasArray;
begin
  inherited;

  Case tpaTipoAlteracao Of
    tpaRegiao:
      Begin
        If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrConsulta) Then
        Begin
          if fValidaCampos(edtCodReg, True) then
            SelectNext(ActiveControl, True, True);
        End;
      End;

    tpaSubRegiao:
      Begin
        If fPesqSubRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrConsulta) Then
        Begin
          if fValidaCampos(edtCodReg, True) then
            SelectNext(ActiveControl, True, True);
        End;
      End;
  End;

end;

procedure TfrmAltRegClientes.edtCodRepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRep, edtDesRep, arrRepr, fRetNomVendRep, nil, 'da representante');
end;

procedure TfrmAltRegClientes.edtCodRepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodRep, edtDesRep, qryTabela, Key, arrRepr, False) then
  Begin
    If fValidaCampos(edtCodRep, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.edtCodRgoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRgo, edtNomRgo, arrRegioes, nil, fRetNomRegiao, 'da região');
end;

procedure TfrmAltRegClientes.edtCodRgoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodRgo, edtNomRgo, Nil, Key, arrRegioes, False) Then
  Begin
    If fValidaCampos(edtCodRgo, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltRegClientes.edtCodSp1Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSp1, edtDesSp1, arrSp1, fRetNomVendRep, nil, 'do Sup. Geral');
end;

procedure TfrmAltRegClientes.edtCodSp1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodSp1, edtDesSp1, nil, Key, arrSp1, False) then
  Begin
    If fValidaCampos(edtCodSp1, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.edtCodSp2Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSp2, edtDesSp2, arrSp2, fRetNomVendRep, nil, 'do Sup. Regional');
end;

procedure TfrmAltRegClientes.edtCodSp2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodSp2, edtDesSp2, nil, Key, arrSp2, False) Then
  Begin
    If fValidaCampos(edtCodSp2, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.edtCodSrgExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSrg, edtNomSrg, arrSubRegiao, nil, fRetNomSubRegiao, 'da Sub-região');
end;

procedure TfrmAltRegClientes.edtCodSrgKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSrg, edtNomSrg, Nil, Key, arrSubRegiao, False) Then
  Begin
    If fValidaCampos(edtCodSrg, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltRegClientes.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVend, fRetNomVendRep, nil, 'do vendedor');
end;

procedure TfrmAltRegClientes.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodVen, edtDesVen, qryTabela, Key, arrVend, False) then
  Begin
    If fValidaCampos(edtCodVen, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltRegClientes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmAltRegClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryGrid);
  FreeAndNil(dtsGrid);
end;

procedure TfrmAltRegClientes.FormCreate(Sender: TObject);
  Var
    intOpcao : Integer;
begin
  inherited;
  intOpcao := fMensagem('', 'Opção:', ['&Região','&Sub-Região']) - 1;
  tpaTipoAlteracao := TTipoAlteracao(intOpcao);

  Case tpaTipoAlteracao Of
    tpaRegiao    : lbl12.Caption := 'Nova Região:';
    tpaSubRegiao : lbl12.Caption := 'Nova Sub-Região:';
  End;

  qryGrid := fCriaQuery;
  dtsGrid := TDataSource.Create(Self);
  dtsGrid.DataSet    := qryGrid;
  dbgGrid.DataSource := dtsGrid;
end;

procedure TfrmAltRegClientes.FormShow(Sender: TObject);
begin
  inherited;
  shpMultSel.Visible := True;
end;

function TfrmAltRegClientes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  {************************}
  {* VALIDA CLIENTE       *}
  {*********************RV*}
  If (Sender = edtCodCli) Then
  Begin
      pDesmarcaLista(edtCodCli, arrClientes);
  End
  {************************}
  {* VALIDA CIDADE        *}
  {*********************RV*}
  Else If (Sender = edtCodCid) Then
  Begin
    pDesmarcaLista(edtCodCid, arrCidade);
  End
  {************************}
  {* VALIDA STATUS        *}
  {*********************RV*}
  Else If (Sender = edtStatus) Then
  Begin

    If Pos(edtStatus.Text, 'A_I_T_') <= 0 Then
    Begin
      fMensagem('AVISO','O Status do Cliente deve ser (A)tivo, (I)nativo ou (T)odos!',['&Ok']);
      Result := False;
    End;

  End
  {************************}
  {* VALIDA VENDEDOR      *}
  {*********************RV*}
  Else If (Sender = edtCodVen) Then
  Begin
    pDesmarcaLista(edtCodVen, arrVend);
  End
  {************************}
  {* VALIDA REPRESENTANTE *}
  {*********************RV*}
  Else If (Sender = edtCodRep) Then
  Begin
      pDesmarcaLista(edtCodRep, arrRepr);
  End
  {************************}
  {* VALIDA SUP. GERAL    *}
  {*********************RV*}
  Else If (Sender = edtCodSp1) Then
  Begin
    pDesmarcaLista(edtCodSp1, arrSp1);
  End
  {************************}
  {* VALIDA SUP. REGIONAL *}
  {*********************RV*}
  Else If (Sender = edtCodSp2) Then
  Begin
    pDesmarcaLista(edtCodSp2, arrSp2);
  End
  {************************}
  {* VALIDA ATIVIDADE     *}
  {*********************RV*}
  Else If (Sender = edtCodAti) Then
  Begin
    pDesmarcaLista(edtCodAti, arrAtiv);
  End
  {************************}
  {* VALIDA REDE DE LOJAS *}
  {*********************RV*}
  Else If (Sender = edtCodRed) Then
  Begin
    pEdtCodSelectExit(edtCodRed, edtDesRed, arrRede, nil, fRetNomeRedeLoja, 'da rede');
  End
  {************************}
  {* VALIDA REGIÃO        *}
  {*********************RV*}
  Else If (Sender = edtCodReg) Then
  Begin

    If Not fEmptyStr(edtCodReg.Text) Then
    Begin
      Case tpaTipoAlteracao Of
        tpaRegiao:    edtDesReg.Text := fRetNomRegiao(edtCodReg.Text);
        tpaSubRegiao: edtDesReg.Text := fRetNomSubRegiao(edtCodReg.Text);
      End;

      If fEmptyStr(edtDesReg.Text) Then
      Begin
        fMensagem('AVISO',IIF(tpaTipoAlteracao = tpaSubRegiao, 'Sub-', '')+'Região não cadastrada!',['&Ok']);
        Result := False;
      End
      Else
        pCarregaGrid;
    End
    Else
    Begin
      fMensagem('AVISO','A Nova Região deve ser preenchida!',['&OK']);
      Result := False;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltRegClientes.pCarregaGrid;
  Var
    strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  CLI_CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI, ';
    strSQL := strSQL + '  CLI_BAIRRO, ';
    strSQL := strSQL + '  CID_NOMCID, ';
    strSQL := strSQL + '  CID_ESTADO  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  CADCLI      ';
    strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = CLI_CODCID ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  TRUE        ';

//    If Not fEmptyStr(edtCodCli.Text) Then
//      strSQL := strSQL + '  AND CLI_CODCLI = :CODCLI ';

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'CLI_CODCLI','CODCLI');

    If Not fEmptyStr(edtCodCid.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCid, arrCidade, 'CLI_CODCID','CODCID');

    If fEmptyStr(edtCodCid.Text) And Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    If Not fEmptyStr(edtCodRgo.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRgo, arrRegioes, 'CLI_CODREG','CODREG');

    If Not fEmptyStr(edtCodSrg.Text) Then
      strSQL := strSQL + fStrLocate(edtCodSrg, arrSubRegiao, 'CLI_CODSUB','CODSUB');

    If Not fEmptyStr(edtBairro.Text) Then
      strSQL := strSQL + '  AND CLI_BAIRRO LIKE :BAIRRO ';

    If (edtStatus.Text <> 'T') Then
      strSQL := strSQL + '  AND CLI_STATUS = :STATUS ';

    If Not fEmptyStr(edtCodVen.Text) Then
      strSQL := strSQL + fStrLocate(edtCodVen, arrVend, 'CLI_CODVEN','CODVEN');

    If Not fEmptyStr(edtCodRep.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRep, arrRepr, 'CLI_CODREP','CODREP');

    If Not fEmptyStr(edtCodSp1.Text) Then
      strSQL := strSQL + fStrLocate(edtCodSp1, arrSp1, 'CLI_SUPGER','SUPGER');

    If Not fEmptyStr(edtCodSp2.Text) Then
      strSQL := strSQL + fStrLocate(edtCodSp2, arrSp2, 'CLI_SUPREG','SUPREG');

    If Not fEmptyStr(edtCodAti.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAti, arrAtiv, 'CLI_CODATI','CODATI');

    If Not fEmptyStr(fTiraCaracEspeciais(edtNumCep.Text)) Then
      strSQL := strSQL + ' AND CLI_C_E_P_ = :CEP ';

    strSQL := strSQL + fStrSQLOr(edtCodRed, arrRede, 'CLI_CODRED', 'CODRED');

    With qryGrid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryGrid);

      If Not fEmptyStr(edtCodCid.Text) Then
        pSetaParam(edtCodCid.Text, arrCidade, strCidade, 'CODCID', qryGrid);

      If fEmptyStr(edtCodCid.Text) And Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;

      If Not fEmptyStr(edtCodRgo.Text) Then
        pSetaParam(edtCodRgo.Text, arrRegioes, strRegiao, 'CODREG', qryGrid);

      If Not fEmptyStr(edtCodSrg.Text) Then
        pSetaParam(edtCodSrg.Text, arrSubRegiao, strSubRegiao, 'CODSUB', qryGrid);

      If Not fEmptyStr(edtBairro.Text) Then
        ParamByName('BAIRRO').AsString := edtBairro.Text + '%';

      If (edtStatus.Text <> 'T') Then
        ParamByName('STATUS').AsString := edtStatus.Text;

      If Not fEmptyStr(edtCodVen.Text) Then
        pSetaParam(edtCodVen.Text, arrVend, strVend, 'CODVEN', qryGrid);

      If Not fEmptyStr(edtCodRep.Text) Then
        pSetaParam(edtCodRep.Text, arrRepr, strRepr, 'CODREP', qryGrid);

      If Not fEmptyStr(edtCodSp1.Text) Then
        pSetaParam(edtCodSp1.Text, arrSp1, strSp1, 'SUPGER', qryGrid);

      If Not fEmptyStr(edtCodSp2.Text) Then
        pSetaParam(edtCodSp2.Text, arrSp2, strSp2, 'SUPREG', qryGrid);

      If Not fEmptyStr(edtCodAti.Text) Then
        pSetaParam(edtCodAti.Text, arrAtiv, strAtiv, 'CODATI', qryGrid);

      If Not fEmptyStr(fTiraCaracEspeciais(edtNumCep.Text)) Then
        ParamByName('CEP').AsString := edtNumCep.Text;

      pSetaParamOR(edtCodRed, arrRede, 'CODRED', qryGrid);

      Open;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      pgbStatus.Visible := False;
    End;
  End;
end;

procedure TfrmAltRegClientes.pLimpaTela;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtBairro.Clear;
  edtStatus.Text := 'T';
  edtCodVen.Clear;
  edtDesVen.Clear;
  edtCodRep.Clear;
  edtDesRep.Clear;
  edtCodSp1.Clear;
  edtDesSp1.Clear;
  edtCodSp2.Clear;
  edtDesSp2.Clear;
  edtCodAti.Clear;
  edtDesAti.Clear;
  edtCodRed.Clear;
  edtDesRed.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;
  edtNumCep.Clear;
end;

end.
