{***************************************}
{* GERAÇÃO DE DESCOB PARA DOCUMENTOS   *}
{* COM A ESPECIE CH                    *}
{*                                     *}
{* AUTOR: ALEXANDRE FERRI              *}
{* DATA : 25/02/2015                   *}
{* REQ  : 30057                        *}
{*                                     *}
{************************************AF*}
unit untCtrGeracaoDesCobCheques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, EditFocus, Vcl.Mask, MaskEditFocus, cxCheckBox,
  Datasnap.Provider, UniDataSetProvider, UniClientDataSet, MemDS, DBAccess, Uni,
  untTypesSistema, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TTipMarDes = (tipNormal, tipMarTodos, tipDesTodos);

  TfrmCtrGeracaoDesCobCheques = class(TfrmPai)
    pnlTopo: TPanel;
    cxDadosView: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    Label5: TLabel;
    Label1: TLabel;
    cxDtaCadIni: TcxDateEdit;
    cxDtaCadFin: TcxDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    cxDtaVenIni: TcxDateEdit;
    cxDtaVenFin: TcxDateEdit;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label20: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    chkSomSemDesCob: TcxCheckBox;
    dtsDados: TDataSource;
    colDuplic: TcxGridDBColumn;
    colClient: TcxGridDBColumn;
    colCodVen: TcxGridDBColumn;
    colDtaCad: TcxGridDBColumn;
    colDtaVen: TcxGridDBColumn;
    colValDup: TcxGridDBColumn;
    colDesCob: TcxGridDBColumn;
    colPreDcb: TcxGridDBColumn;
    qryDados: TUniQuery;
    cdsDados: TUniClientDataSet;
    pvdDados: TUniDataSetProvider;
    btnConfirma: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    colMarDes: TcxGridDBColumn;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxDadosViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure cxDadosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxDadosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    arrClientes: TConsultasArray;
    arrEmp     : TConsultasArray;
    
    procedure pCarregaDados;
    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pMarcarDuplicata(tipMardes: TTipMarDes);
    procedure pConfirmaDados;
    procedure pLimparDados;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, StrUtils, untPesqAux, untConsultas, untFuncoesConsulta,
  untModulo;

procedure TfrmCtrGeracaoDesCobCheques.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsDados.Active And (Not cdsDados.IsEmpty) Then
    pConfirmaDados;
end;

procedure TfrmCtrGeracaoDesCobCheques.pConfirmaDados;
  Var
    qryAux: TUniQuery;

    procedure pExecuta(strAutInc, strTabela: String; fltValor: Double);
    Begin

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE ');
        SQL.Add(strTabela);
        SQL.Add(' SET CTR_DESCOB = ' + AnsiReplaceStr(FloatToStrF(fltValor, ffFixed, 12, 2),',','.'));
        SQL.Add(' WHERE ');
        SQL.Add('   AUTOINCREM = ' + strAutInc);
        ExecSQL;
      End;
    
    End;
    
begin

  If (Not cdsDados.Active) Or (cdsDados.IsEmpty) Then
    Exit;

  Try
    cdsDados.DisableControls;
    cdsDados.Filter := 'MARDES = ' + QuotedStr('M');
    cdsDados.Filtered := True;

    If cdsDados.RecordCount = 0 Then
    Begin
      pMensagemOk('Favor selecionar um registro!');
      cdsDados.Filtered := False;
      cdsDados.EnableControls;
      Exit;
    End
    Else
    Begin

      If fMensagem('','Confirma alteração?',['','']) = 2 Then
      Begin
        cdsDados.Filtered := False;
        cdsDados.EnableControls;
        Exit;
      End;

    End;

    qryAux := fCriaQuery;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pExecuta(cdsDados.FieldByName('AUTOINCREM').AsString,
               cdsDados.FieldByName('TABELA').AsString,
               cdsDados.FieldByName('PREDCB').AsFloat);
      cdsDados.Next;
    End;

    pMensagemOk('Dados atualizados com sucesso!');

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  cdsDados.Filtered := False;
  cdsDados.EnableControls;

  pLimparDados;

  FreeAndNil(qryAux);
end;

procedure TfrmCtrGeracaoDesCobCheques.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDuplicata(tipDesTodos);
end;

procedure TfrmCtrGeracaoDesCobCheques.btnMarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDuplicata(tipMarTodos);
end;

procedure TfrmCtrGeracaoDesCobCheques.cxDadosViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMarcarDuplicata(tipNormal);
end;

procedure TfrmCtrGeracaoDesCobCheques.cxDadosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
begin
  inherited;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  colMarDes.Index]);
  If (cdsDados.IsEmpty) Or fEmptyStr(strMarDes) Then
    Exit;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;

end;

procedure TfrmCtrGeracaoDesCobCheques.cxDadosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: pMarcarDuplicata(tipNormal);
  End;

end;

procedure TfrmCtrGeracaoDesCobCheques.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmCtrGeracaoDesCobCheques.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmCtrGeracaoDesCobCheques.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa');
end;

procedure TfrmCtrGeracaoDesCobCheques.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

{***************************************}
{* RESPONSÁVEL POR MARCAR UMA OU MAIS  *}
{* DUPLICATAS DEFINIDO PELO PARAMETRO  *}
{*25/02/2015*REQ:30057***************AF*}
procedure TfrmCtrGeracaoDesCobCheques.pMarcarDuplicata(tipMardes: TTipMarDes);
  Var
    intRecNo: Integer;
begin
  If (Not cdsDados.Active) Or (cdsDados.IsEmpty) Then
    Exit;

  Try
    cdsDados.DisableControls;

    Case tipMardes Of

      tipNormal: Begin
                   cdsDados.Edit;
                   If cdsDados.FieldByName('MARDES').AsString = 'M' Then cdsDados.FieldByName('MARDES').AsString := 'D'
                   Else cdsDados.FieldByName('MARDES').AsString := 'M';
                   cdsDados.Post;
                 End;

      tipMarTodos,
      tipDesTodos: Begin
                     intRecNo := cdsDados.RecNo;

                     cdsDados.First;
                     While Not cdsDados.Eof Do
                     Begin
                       cdsDados.Edit;
                       cdsDados.FieldByName('MARDES').AsString := IIF(tipMardes = tipMarTodos, 'M', 'D');
                       cdsDados.Post;

                       cdsDados.Next;
                     End;

                     cdsDados.RecNo := intRecNo;
                   End;

    End;

  Finally
    cdsDados.EnableControls;
  End;
end;

procedure TfrmCtrGeracaoDesCobCheques.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxDtaCadIni);
end;

procedure TfrmCtrGeracaoDesCobCheques.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of

    VK_ESCAPE: Begin

                 If cdsDados.Active Then
                   pLimparDados
                 Else
                   inherited;

               End;

    VK_F10: btnConfirma.Click;
    VK_F5: btnMarTodos.Click;
    VK_F6: btnDesmarTodos.Click;

    Else inherited;

  End;
end;

procedure TfrmCtrGeracaoDesCobCheques.pLimparDados;
begin
  cdsDados.Close;
  pSetFocus(cxDtaCadIni);
end;

function TfrmCtrGeracaoDesCobCheques.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = cxDtaCadIni) Or (Sender = cxDtaCadFin) Then
  Begin

    {***************************************}
    {* VALIDAÇÃO DA DATA INICIAL E FINAL DE*}
    {* CADASTRO                            *}
    {*25/02/2015*REQ:30057***************AF*}
    If (Not fEmptyStr(cxDtaCadIni.Text)) And (Not fEmptyStr(cxDtaCadFin.Text)) Then
    Begin

      If cxDtaCadFin.Date < cxDtaCadIni.Date Then
      Begin
        pMensagemOk('A data de cadastro inicial deve ser menor ou igual a data de cadastro final.');
        Result := False;
      End;

    End

    Else If (fEmptyStr(cxDtaCadIni.Text)) And (Not fEmptyStr(cxDtaCadFin.Text)) Then
    Begin
      pMensagemOk('A data de cadastro inicial deve ser preenchida.');
      Result := False;
      Sender := cxDtaCadIni;
    End

    Else If (Not fEmptyStr(cxDtaCadIni.Text)) And (fEmptyStr(cxDtaCadFin.Text)) And (Not blnBuscaPorChave) Then
    Begin
      cxDtaCadIni.Clear;
    End;

  End

  {***************************************}
  {* VALIDAÇÃO DAS DATAS DE VENCIMENTO   *}
  {* INICIAL E FINAL                     *}
  {*25/02/2015*REQ:30057***************AF*}
  Else If (Sender = cxDtaVenIni) Or (Sender = cxDtaVenFin) Then
  Begin

    If (Not fEmptyStr(cxDtaVenIni.Text)) And (Not fEmptyStr(cxDtaVenFin.Text)) Then
    Begin

      If cxDtaVenFin.Date < cxDtaVenIni.Date Then
      Begin
        pMensagemOk('A data de vencimento inicial deve ser menor ou igual a data de vencimento final.');
        Result := False;
      End;

    End

    Else If (fEmptyStr(cxDtaVenIni.Text)) And (Not fEmptyStr(cxDtaVenFin.Text)) Then
    Begin
      pMensagemOk('A data de vencimento inicial deve ser preenchida.');
      Result := False;
      Sender := cxDtaCadIni;
    End

    Else If (Not fEmptyStr(cxDtaVenIni.Text)) And (fEmptyStr(cxDtaVenFin.Text)) And (Not blnBuscaPorChave) Then
    Begin
      cxDtaVenIni.Clear;
    End;

  End

  {***************************************}
  {* VALIDA CLIENTE                      *}
  {*25/02/2015*REQ:30057***************AF*}
  Else If (Sender = edtCodCli) Then
  Begin

    If (Not fEmptyStr(edtCodCli.Text)) Then
    Begin
      pCarregaCliente;
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        pMensagemOk('Esse Cliente não está cadastrado!');
        Result := False;
      End;
    End
    Else
      edtNomCli.Clear;

  End

  {***************************************}
  {* VALIDA EMPRESA                      *}
  {*25/02/2015*REQ:30057***************AF*}
  Else If (Sender = edtCodEmp) Then
  Begin

    If fEmptyStr(edtCodEmp.Text) Then
      edtNomEmp.Clear

    Else
    Begin

      pCarregaEmpresa;
      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        pMensagemOk('Essa empresa não está cadastrada!');
        Result := False;
      End
      Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        pMensagemOk('Usuário sem permissão de acesso a esta empresa!');
        Result := False;
      End;      

    End;

    If Result Then
    Begin
      pCarregaDados;
      blnMudarFoco := False;
    End;
      
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCtrGeracaoDesCobCheques.pCarregaCliente;
begin

  If Not fEmptyStr(edtCodCli.Text) Then
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text)
  Else
    edtNomCli.Clear;

end;

procedure TfrmCtrGeracaoDesCobCheques.pCarregaEmpresa;
begin

  If Not fEmptyStr(edtCodEmp.Text) Then
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text)
  Else
    edtNomEmp.Clear;

end;

procedure TfrmCtrGeracaoDesCobCheques.pCarregaDados;
  Var
    strSQL: String;
    strPerDesCob: String;
    strValDesCob: String;
begin

  cdsDados.Close;

  strPerDesCob := AnsiReplaceStr(FloatToStrF(fCfgSis('PERDCB', varDouble), ffFixed, 12, 2),',','.');
  strValDesCob := AnsiReplaceStr(FloatToStrF(fCfgSis('VALDCB', varDouble), ffFixed, 12, 2),',','.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  R.AUTOINCREM, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL, "-", CTR_ESPDOC, "-", CTR_CODEMP) AS DUPLIC, ';
  strSQL := strSQL + '  CONCAT(CTR_CODCLI, "-", CLI_NOMCLI) AS CLIENT, ';
  strSQL := strSQL + '  CTR_CODVEN, CTR_DTACAD, CTR_DTAVEN, CTR_VALDUP, CTR_DESCOB, ';
  strSQL := strSQL + '  (((CTR_VALDUP * ' + strPerDesCob + ')/100) + ' + strValDesCob + ') AS PREDCB, ';
  strSQL := strSQL + '  "CADREC" AS TABELA, ';
  strSQL := strSQL + '  "D" AS MARDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_ESPDOC = "CH" AND ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';
  strSQL := strSQL + '  CTR_CODPOR = "' + fCfgSis('PORDCB') + '" ';

  If Not fEmptyStr(cxDtaCadIni.Text) Then
    strSQL := strSQL + '  AND CTR_DTACAD BETWEEN :DTCINI AND :DTCFIN ';

  If Not fEmptyStr(cxDtaVenIni.Text) Then
    strSQL := strSQL + '  AND CTR_DTAVEN BETWEEN :DTVINI AND :DTVFIN ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
  Else
    strSQL := strSQL + '  AND LOCATE(CTR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If chkSomSemDesCob.Checked Then
    strSQL := strSQL + '  AND IFNULL(CTR_DESCOB,0) <= 0 ';

  With qryDados Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(cxDtaCadIni.Text) Then
    Begin
      ParamByName('DTCINI').AsDate := cxDtaCadIni.Date;
      ParamByName('DTCFIN').AsDate := cxDtaCadFin.Date;
    End;

    If Not fEmptyStr(cxDtaVenIni.Text) Then
    Begin
      ParamByName('DTVINI').AsDate := cxDtaVenIni.Date;
      ParamByName('DTVFIN').AsDate := cxDtaVenFin.Date;
    End;

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    Open;
  End;

  If qryDados.Fields[0].ReadOnly <> False Then
    pSetaClient(qryDados);

  pvdDados.DataSet := qryDados;
  cdsDados.SetProvider(pvdDados);
  cdsDados.Open;

  TFloatField(cdsDados.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDados.FieldByName('CTR_DESCOB')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDados.FieldByName('PREDCB')).DisplayFormat := '#,##0.00';

  If cdsDados.IsEmpty Then
  Begin
    pMensagemOk('Não há dados para serem exibidos!');
    pSetFocus(cxDtaCadIni);
  End
  Else
    pSetFocus(cxDados);

end;

end.
