unit untDigGNRE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, untGNRE, Grids, DBGridCitel, DBGrids, Uni, EditFocus, Mask, DBCtrls,
  DBEditFocus, DB, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigGNRE = class(TfrmPai)
    dbgGnre: TDBGridCitel;
    pnlGeral: TPanel;
    Label1: TLabel;
    lblTip_fc: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtNomFor: TEditFocus;
    btnIncluir: TBitBtnLocked;
    dtsConsulta: TDataSource;
    btnConfirma: TBitBtnLocked;
    chkImprCp: TCheckBox;
    shpGnre: TShape;
    lblGnre: TLabel;
    edtNumDoc: TEditFocus;
    edtForCli: TEditFocus;
    edtEspDoc: TEditFocus;
    edtSerie: TEditFocus;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgGnreDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtForCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure dbgGnreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    blnComNfe: Boolean;
    blnNaoAbrir : Boolean;
    lstGNRE     : TListGNRE;
    qryConsulta : TUniQuery;
    blnEhDARE: Boolean;
    blnLancamentoAposEntrada: Boolean;
  protected
  public
    blnEdicao : Boolean;
    TipoChamada : TTipoChamada;
    class procedure CriarFormulario(ATipoChamada: TTipoChamada = tcGNREPadrao; blnManutencao : Boolean = False);

  Protected
    procedure pLimpaDados;
    procedure pLiberarConfirmar(Sender : TObject);
    procedure pInciaDados;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

uses
  untConsultas, untFuncoesSimples, System.UITypes, untTypesSistema;


{$R *.dfm}

procedure TfrmDigGNRE.btnAlterarClick(Sender: TObject);
begin
  inherited;

  if Not btnAlterar.Visible Then
    Exit;

  If dbgGnre.DataSource.DataSet.IsEmpty Then
    Exit;

  If TipoChamada In [tcTCIF, tcTS] Then
    lstGNRE.pEdita(blnEdicao Or (dbgGnre.DataSource.DataSet.FieldByName('GNR_INSERT').AsString = 'N'), '')
  Else
    lstGNRE.pEdita(blnEdicao Or (dbgGnre.DataSource.DataSet.FieldByName('GNR_INSERT').AsString = 'N'),
                                 dbgGnre.DataSource.DataSet.FieldByName('GNR_ORIGEM').AsString);

end;

procedure TfrmDigGNRE.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  with qryConsulta Do
    if lstGNRE.fGravaGnre( FieldByName('FIS_NUMDOC').AsString,
                           FieldByName('FIS_ESPDOC').AsString,
                           FieldByName('FIS_SERIE_').AsString,
                           FieldByName('FIS_FORCLI').AsString,
                           strLoginUsuarioLogado,
                           Self.Name,
                           chkImprCp.Checked,
                           FieldByName('FIS_DTADOC').AsDateTime,
                           FieldByName('AUTOINCREM').AsString) Then
  pLimpaDados;

  If Self.blnLancamentoAposEntrada Then
    pInciaDados;

end;

procedure TfrmDigGNRE.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If Not btnExcluir.Visible Then
    Exit;

  If dbgGnre.DataSource.DataSet.IsEmpty Then
    Exit;

  If dbgGnre.DataSource.DataSet.FieldByName('GNR_INSERT').AsString = 'N' then
  Begin
    pMensagemOk(fTrocaNomeGNRE(blnEhDARE, 'GNRE''s já gravadas não podem ser excluidas. A nota deve ser cancelada para a exclusão da GNRE.'));
    Exit;
  End;

  If fPergunta(fTrocaNomeGNRE(blnEhDARE, 'Deseja exluir a GNRE?')) Then
  Begin
    If TipoChamada in [tcTCIF, tcTS] Then
      If lstGNRE.fExclui('') Then
        dbgGnre.DataSource.DataSet.Delete
    Else
    If lstGNRE.fExclui(dbgGnre.DataSource.DataSet.FieldByName('GNR_ORIGEM').AsString) Then
      dbgGnre.DataSource.DataSet.Delete;
  End;

end;

procedure TfrmDigGNRE.btnIncluirClick(Sender: TObject);
Var lBlnResult: Boolean;
Begin
  If blnEdicao Then
  Begin
    If TipoChamada in [tcTCIF, tcTS] Then
      lstGNRE.pEdita(blnEdicao, '')
    Else
      lstGNRE.pEdita(blnEdicao, dbgGnre.DataSource.DataSet.FieldByName('GNR_ORIGEM').AsString);
  End
  Else
  Begin
    If TipoChamada in [tcGnrePadrao, tcGnreTributado] Then
    Begin

      If fCfgSis('GNRTEM', varBoolean) Then
      Begin
        If (fMensagem('', 'Qual tipo de GNRE deseja lançar:', ['&ST', '&Tributada']) = 2) Then
          TipoChamada := tcGnreTributado
        Else
          TipoChamada := tcGnrePadrao;
      End
      Else
         TipoChamada := tcGnrePadrao;

        lstGNRE.TipoChamada := TipoChamada;
        If Not (lstGNRE.fValidaDocumento(edtNumDoc.Text,
                                           edtEspDoc.Text,
                                           edtSerie.Text,
                                           VS_strCodEmp,
                                           edtForCli.Text,
                                           blnComNfe)) Then
        Exit;
    End;

    lstGNRE.pAdiciona(fCfgSis('FORGNE'), blnComNfe, True, lBlnResult);
    If (Not lBlnResult) And Self.blnLancamentoAposEntrada Then
    Begin
      pLimpaDados;
      pInciaDados;
    End;
  End;
end;

class procedure TfrmDigGNRE.CriarFormulario(ATipoChamada: TTipoChamada; blnManutencao : Boolean);

  var frmDigGNRE: TfrmDigGNRE;
      blnEhDARE: Boolean;

begin
  pCriarFormularios(TfrmDigGNRE, frmDigGNRE);
  Try
    blnEhDARE := fEhEmpresaDARE;
    frmDigGNRE.blnLancamentoAposEntrada := False;
    If blnManutencao Then
    begin
      frmDigGNRE.blnEdicao := True;
      case ATipoChamada of
        tcGNREPadrao,
        tcGnreTributado: frmDigGNRE.Caption := fTrocaNomeGNRE(blnEhDARE, 'Manutenção de GNRE/GARE');
        tcTCIF:          frmDigGNRE.Caption := 'Manutenção de TCIF';
        tcTS:            frmDigGNRE.Caption := 'Manutenção de TS';
      End;
    end
    Else
    begin
      frmDigGNRE.blnEdicao := False;
      case ATipoChamada of
        tcGNREPadrao,
        tcGnreTributado:Begin
                           frmDigGNRE.Caption := fTrocaNomeGNRE(blnEhDARE, 'Digitação de GNRE após Entrada de Mercadorias');
                           frmDigGNRE.blnLancamentoAposEntrada := True;
                        End;
        tcTCIF:          frmDigGNRE.Caption := 'Digitação da TCIF após Entrada de Mercadorias';
        tcTS:            frmDigGNRE.Caption := 'Digitação da TS após Entrada de Mercadorias';
      End;
    end;


    frmDigGNRE.TipoChamada := ATipoChamada;
    If Assigned(fFindColumnByName(frmDigGNRE.dbgGnre, 'GNR_ORIGEM')) Then
      fFindColumnByName(frmDigGNRE.dbgGnre, 'GNR_ORIGEM').Visible := fCfgSis('ATUADB') = 'D';
    frmDigGNRE.lstGNRE                := TListGNRE.Create(frmDigGNRE, ATipoChamada);
    frmDigGNRE.lstGNRE.OnChangeQtdIns := frmDigGNRE.pLiberarConfirmar;
    frmDigGNRE.blnNaoAbrir            := frmDigGNRE.lstGNRE.blnDeuErro;
    frmDigGNRE.dbgGnre.DataSource     := frmDigGNRE.lstGNRE.dtsDados;
    frmDigGNRE.qryConsulta            := fCriaQuery(frmDigGNRE);
    With frmDigGNRE.qryConsulta, SQL Do
    Begin
      Add( 'SELECT SQL_NO_CACHE               ');
      Add( '  F.FIS_NUMDOC,                   ');
      Add( '  F.FIS_NUMDO2,                   ');
      Add( '  F.FIS_CLFSC1,                   ');
      Add( '  F.FIS_ESPDOC,                   ');
      Add( '  F.FIS_CODEMP,                   ');
      Add( '  F.FIS_SERIE_,                   ');
      Add( '  (IFNULL(F.FIS_VLCON1, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON2, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON3, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON4, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON5, 0)) AS FIS_VALOR_, ');
      Add( '  F.FIS_ACESSO,                   ');
      Add( '  F.FIS_ENTSAI,                   ');
      Add( '  F.FIS_TIP_FC,                   ');
      Add( '  F.FIS_FORCLI,                   ');
      Add( '  FR.FOR_NOMFOR AS FIS_NOME__,    ');
      Add( '  F.FIS_DTAENT,                   ');
      Add( '  F.FIS_DTADOC,                   ');
      Add( '  F.FIS_HISTOR,                   ');
      Add( '  F.FIS_NUMCOO,                   ');
      Add( '  F.FIS_NUMSER,                   ');
      Add( '  F.AUTOINCREM                    ');
      Add( 'FROM                              ');
      Add( '  CADFIS F                        ');
      Add( '  LEFT JOIN CADFOR FR             ');
      Add( '  ON FR.FOR_CODFOR = F.FIS_FORCLI ');
      Add( '  AND F.FIS_TIP_FC = "F"          ');
      Add( 'WHERE FIS_NUMDOC = :NUMDOC        ');
      Add( '  AND FIS_ESPDOC = :ESPDOC        ');
      Add( '  AND IFNULL(FIS_SERIE_,"") = IFNULL(:SERIE_,"")        ');
      Add( '  AND FIS_CODEMP = :CODEMP        ');
      Add( '  AND FIS_FORCLI = :FORCLI        ');
      Add( '  AND LEFT(FIS_CLFSC1,1) < 5      ');

    End;

    frmDigGNRE.dtsConsulta.DataSet    := frmDigGNRE.qryConsulta;
    frmDigGNRE.ShowModal;

  Finally
    FreeAndNil(frmDigGNRE)
  End;

end;

procedure TfrmDigGNRE.dbgGnreDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If dbgGnre.DataSource.DataSet.FieldByName('GNR_INSERT').AsString = 'N' then
  Begin
    dbgGnre.Canvas.Brush.Color:= shpGnre.Brush.Color;
    dbgGnre.Canvas.FillRect(Rect);
    dbgGnre.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

end;

procedure TfrmDigGNRE.dbgGnreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE:  btnExcluir.Click;
    VK_RETURN:  btnAlterar.Click;
  End;
end;

procedure TfrmDigGNRE.edtForCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtForCli, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigGNRE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qryConsulta.Active Then
  Begin
    if (fMensagem('ATENÇÃO', 'Deseja Cancelar ?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      pLimpaDados;
      Abort;
    End
    Else
     Abort;
  end;
  inherited;
end;

procedure TfrmDigGNRE.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstGNRE);
  FreeAndNil(qryConsulta);
end;

procedure TfrmDigGNRE.FormPaint(Sender: TObject);
begin
  inherited;
  If blnNaoAbrir Then
    Close;
end;

procedure TfrmDigGNRE.FormShow(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamNumDoc;
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;
  pSetFocus(edtNumDoc);

  if blnEdicao Then
  Begin
    btnIncluir.Caption := '&Editar';

    btnAlterar.Visible := False;
    btnExcluir.Visible := False;
  End;

  blnEhDARE := fEhEmpresaDARE;

  Self.Caption := fTrocaNomeGNRE(blnEhDARE, Self.Caption);
end;

function TfrmDigGNRE.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtForCli) Then
    Begin
      edtNomFor.Text := fRetNomFornecedor(edtForCli.Text);
      if fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Código do Fornecedor não Encontrado!', ['&OK']);
        Result := False;
      End;

      If Result Then
      Begin
        With qryConsulta Do
        Begin
          Close;
          ParamByName('NUMDOC').AsString := edtNumDoc.Text;
          ParamByName('ESPDOC').AsString := edtEspDoc.Text;
          ParamByName('SERIE_').AsString := edtSerie.Text;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('FORCLI').AsString := edtForCli.Text;

          Open;

          blnComNfe := False;

          if IsEmpty Then
          Begin
            fMensagem('ATENÇÃO', 'Documento não Encontrado!', ['&OK']);
            Result := False;
          End Else
          Begin
            lstGNRE.TipoChamada := TipoChamada;
            Result := lstGNRE.fValidaDocumento(edtNumDoc.Text,
                                               edtEspDoc.Text,
                                               edtSerie.Text,
                                               VS_strCodEmp,
                                               edtForCli.Text,
                                               blnComNfe,
                                               False);

            If (Not Result) Then
            Begin

              lstGNRE.TipoChamada := tcGnreTributado;
              Result := lstGNRE.fValidaDocumento(edtNumDoc.Text,
                                                 edtEspDoc.Text,
                                                 edtSerie.Text,
                                                 VS_strCodEmp,
                                                 edtForCli.Text,
                                                 blnComNfe,
                                                 False);
              lstGNRE.TipoChamada := TipoChamada;
            End;

            If (Not Result) Then
            Begin
              If TipoChamada in [tcTCIF, tcTS] Then
                pMensagemOk('Não há itens cadastrados para a cobrança dessa taxa para essa nota!')
              Else
              Begin
                If blnComNFE Then
                  pMensagemOk('Não há itens cadastrados com substituição tributária no estado da' + #13#10 +
                              'empresa que estejam tributados (CST X00 ou X20) ou tenham substituição' + #13#10 +
                              'tributária na nota eletrônica (XML)!')
                Else
                  pMensagemOk('Não há itens cadastrados com substituição tributária no estado da' + #13#10 +
                              'empresa para essa nota!')
              End;
            End;
          End;

          If Result Then
          Begin
            lstGNRE.pCarregaListaGnre(qryConsulta.FieldByName('AUTOINCREM').AsString);
            btnIncluir.Enabled := True;
            btnExcluir.Enabled := True;
            btnAlterar.Enabled := True;

            blnMudarFoco := False;
            pSetFocus(btnIncluir);
            pnlGeral.Enabled := False;
          End;


        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDigGNRE.pInciaDados;
begin
    If Assigned(fFindColumnByName(Self.dbgGnre, 'GNR_ORIGEM')) Then
      fFindColumnByName(Self.dbgGnre, 'GNR_ORIGEM').Visible := fCfgSis('ATUADB') = 'D';
    Self.lstGNRE                := TListGNRE.Create(Self, Self.TipoChamada);
    Self.lstGNRE.OnChangeQtdIns := Self.pLiberarConfirmar;
    Self.blnNaoAbrir            := Self.lstGNRE.blnDeuErro;
    Self.dbgGnre.DataSource     := Self.lstGNRE.dtsDados;
    Self.qryConsulta            := fCriaQuery(Self);
    With Self.qryConsulta, SQL Do
    Begin
      Add( 'SELECT SQL_NO_CACHE               ');
      Add( '  F.FIS_NUMDOC,                   ');
      Add( '  F.FIS_NUMDO2,                   ');
      Add( '  F.FIS_CLFSC1,                   ');
      Add( '  F.FIS_ESPDOC,                   ');
      Add( '  F.FIS_CODEMP,                   ');
      Add( '  F.FIS_SERIE_,                   ');
      Add( '  (IFNULL(F.FIS_VLCON1, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON2, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON3, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON4, 0) +               ');
      Add( '   IFNULL(F.FIS_VLCON5, 0)) AS FIS_VALOR_, ');
      Add( '  F.FIS_ACESSO,                   ');
      Add( '  F.FIS_ENTSAI,                   ');
      Add( '  F.FIS_TIP_FC,                   ');
      Add( '  F.FIS_FORCLI,                   ');
      Add( '  FR.FOR_NOMFOR AS FIS_NOME__,    ');
      Add( '  F.FIS_DTAENT,                   ');
      Add( '  F.FIS_DTADOC,                   ');
      Add( '  F.FIS_HISTOR,                   ');
      Add( '  F.FIS_NUMCOO,                   ');
      Add( '  F.FIS_NUMSER,                   ');
      Add( '  F.AUTOINCREM                    ');
      Add( 'FROM                              ');
      Add( '  CADFIS F                        ');
      Add( '  LEFT JOIN CADFOR FR             ');
      Add( '  ON FR.FOR_CODFOR = F.FIS_FORCLI ');
      Add( '  AND F.FIS_TIP_FC = "F"          ');
      Add( 'WHERE FIS_NUMDOC = :NUMDOC        ');
      Add( '  AND FIS_ESPDOC = :ESPDOC        ');
      Add( '  AND IFNULL(FIS_SERIE_,"") = IFNULL(:SERIE_,"")        ');
      Add( '  AND FIS_CODEMP = :CODEMP        ');
      Add( '  AND FIS_FORCLI = :FORCLI        ');
      Add( '  AND LEFT(FIS_CLFSC1,1) < 5      ');

    End;

    Self.dtsConsulta.DataSet    := Self.qryConsulta;


end;

procedure TfrmDigGNRE.pLiberarConfirmar(Sender: TObject);
begin
  btnConfirma.Enabled := (lstGNRE.intQtdInsert > 0);
end;

procedure TfrmDigGNRE.pLimpaDados;
begin
  btnIncluir.Enabled := False;
  btnExcluir.Enabled := False;
  btnAlterar.Enabled := False;

  lstGNRE.pLimpaLista;
  qryConsulta.Close;

  edtForCli.Clear;
  edtSerie.Clear;
  edtNumDoc.Clear;
  edtNomFor.Clear;

  pnlGeral.Enabled := True;
  pSetFocus(edtNumDoc);

end;

end.





