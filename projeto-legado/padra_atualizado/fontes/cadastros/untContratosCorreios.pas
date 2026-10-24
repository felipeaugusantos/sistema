(*  CADASTRO DE CONTRATOS JUNTO AO CORREIOS PARA UTILIZAÇÃO DO SIGEP-WEB
    SÓ É POSSÍVEL UM CONTRATO ATIVO POR EMPRESA

    AUTOR : GUILHERME BORGES.
    DATA  : 07/12/2016

*)

unit untContratosCorreios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untZClient,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni, Data.DB, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmContratosCorreios = class(TfrmPaiConfirma)
    dbeNumCon: TDBEditFocus;
    Label1: TLabel;
    dbeNumCar: TDBEditFocus;
    Label2: TLabel;
    dbeNumAdm: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeNomUsu: TDBEditFocus;
    dbeSenha_: TDBEditFocus;
    Label5: TLabel;
    dbcHomolo: TDBCheckBox;
    btnServicos: TBitBtnLocked;
    cxgServicosLevel: TcxGridLevel;
    cxgServicosTableView: TcxGridDBTableViewCitel;
    cxgServicos: TcxGridCitel;
    cxgServicosTableViewIDSERV: TcxGridDBColumn;
    cxgServicosTableViewCODIGO: TcxGridDBColumn;
    cxgServicosTableViewDESCRI: TcxGridDBColumn;
    cxgServicosTableViewCODSER: TcxGridDBColumn;
    cxgServicosTableViewLAY_DESCRI: TcxGridDBColumn;
    dbcStatus: TDBCheckBox;
    btnCarregarContrato: TBitBtnLocked;
    btnNovoContrato: TBitBtnLocked;
    btnSelecionaLayout: TBitBtnLocked;
    lblCodAce: TLabel;
    dbeCodAce: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoContratoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnServicosClick(Sender: TObject);
    procedure btnSelecionaLayoutClick(Sender: TObject);
    procedure btnCarregarContratoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    qryCorCfg : TZClient;
    qryCorSer : TZClient;
    blnCarregandoServicos: Boolean;

    function fIncluiContrato : Boolean;
    procedure pEnabled(blnEnabled : Boolean);
  public
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCorreiosMain, Correios.Types, untTypesSistema,
  untConsultas;

procedure TfrmContratosCorreios.btnServicosClick(Sender: TObject);
  Var
    objServi : TDadosServico;
    objServCli: TServicosCliente;
begin
  inherited;

  If (qryCorCfg.IsEmpty) or (not qryCorCfg.Active) Then
    Exit;

  If fCfgSis('USIGEP') = 'A' Then
    If qryCorCfg.FieldByName('CFG_STATUS').AsString <> 'A' Then
    Begin
      //a nova api necessita ler/gravar o token de acesso, que é vinculado ao contrato ativo através da libCorreios.dll
      pMensagemOk('Operação permitida somente para contratos ativos!');
      Exit;
    End;

  Try
    blnCarregandoServicos := True;

    //a lib lê os dados diretamente da CORCFG, por isso as informações precisam ser salvas antes
    If (fCfgSis('USIGEP') = 'A') And (qryCorCfg.State In dsEditModes) Then
      btnConfirma.Click;

    qryCorSer.DisableControls;
    With qryCorSer Do
    Begin

      objServCli := fBuscaCliente(qryCorCfg.FieldByName('CFG_NUMCON').AsString,
                                  qryCorCfg.FieldByName('CFG_NUMCAR').AsString,
                                  qryCorCfg.FieldByName('CFG_HOMOLO').AsString = 'S');

      If Not Assigned(objServCli) Then
        Exit;

      For objServi In objServCli Do
      Begin
        If not qryCorSer.Locate('CSE_IDSERV;CSE_CODSER', varArrayOf([IntToStr(objServi.id), objServi.codigo]), [] ) Then
        Begin
          Append;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORSER', VS_strCodEmp);
          FieldByName('CSE_CODIGO').AsString := fAtualizaProCod('CORSER', 'CSE_CODIGO');
          FieldByName('CSE_IDSERV').AsString := IntToStr(objServi.id);
          FieldByName('CSE_CODSER').AsString := objServi.codigo;
          FieldByName('CSE_DESCRI').AsString := objServi.descricao;
          FieldByName('CSE_SEQCFG').AsString := qryCorCfg.FieldByName('AUTOINCREM').AsString;
          FieldByName('LAY_DESCRI').AsString := 'Layout Não Selecionado - (Será Utilizado o Padrão)';
          Post;
        End;
      End;

    End;
  Finally
    blnCarregandoServicos := False;
    qryCorSer.EnableControls;
  End

end;

procedure TfrmContratosCorreios.btnSairClick(Sender: TObject);
begin
  If qryCorCfg.Active and ((qryCorCfg.RecordCount > 0 ) Or (qryCorCfg.State in DsEditModes)) Then
  Begin
    qryCorCfg.qryQuery.Params[0].AsString := '';
    qryCorCfg.fAbreClient(True, 'TfrmContratosCorreios.FormCreate');

    qryCorSer.qryQuery.Params[0].AsString := '';
    qryCorSer.fAbreClient(True, 'TfrmContratosCorreios.FormCreate');

    pEnabled(False);
  End
  Else
    inherited;
end;

procedure TfrmContratosCorreios.btnSelecionaLayoutClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
    qryConsulta : TUniQuery;
begin
  inherited;
  If (qryCorCfg.IsEmpty) or (not qryCorCfg.Active) Or (qryCorSer.IsEmpty) Or (Not qryCorSer.Active) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    chrKey := '/';
    If fPesqLayoutEtiquetaDespacho(Self, Nil, Nil, qryConsulta, chrKey, arrSel) Then
    Begin
      qryCorSer.Edit;
      qryCorSer.FieldByName('CSE_CODLAY').AsString := qryConsulta.FieldByName('LAY_CODLAY').AsString;
      qryCorSer.FieldByName('LAY_DESCRI').AsString := qryConsulta.FieldByName('LAY_DESCRI').AsString;
      qryCorSer.Post;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmContratosCorreios.btnCarregarContratoClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryConsulta : TUniQuery;
begin
  inherited;
  Try
    qryConsulta := fCriaQuery;
    chrKey := '/';
    If fPesqContratoCorreio(Self, Nil, Nil, qryConsulta, chrKey, arrSel) Then
    Begin
      If qryConsulta.RecordCount > 0 Then
      Begin
        qryCorCfg.qryQuery.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
        qryCorCfg.fAbreClient(True, 'TfrmContratosCorreios.btnCarregarContratoClick');

        qryCorSer.qryQuery.ParamByName('SEQCFG').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
        qryCorSer.fAbreClient(True, 'TfrmContratosCorreios.btnCarregarContratoClick');
        pEnabled(True);
      End;
    End
    Else
      pEnabled(qryCorCfg.RecordCount > 0);

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmContratosCorreios.btnConfirmaClick(Sender: TObject);
  Var
    qryInsert : TUniQuery;
    blnGravou : Boolean;
begin
  blnGravou := False;
  Try
    fStartTransaction;
    qryCorSer.DisableControls;
    qryCorSer.First;
    qryInsert := fCriaQuery(Self);

    Try
      With qryInsert, SQL Do
      Begin
        If qryCorCfg.FieldByName('CFG_STATUS').AsString = 'A' Then
        Begin
          Close;
          Clear;
          Add(' UPDATE CORCFG SET CFG_STATUS = "I" ');
          Add(' WHERE CFG_CODEMP = :CODEMP         ');
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ExecSQL;
        End;

        Close;
        Clear;
        If fCampoTabela('AUTOINCREM', 'CORCFG', ['AUTOINCREM'], [qryCorCfg.FieldByName('AUTOINCREM').AsString]) = '' Then
        Begin
          Add( ' INSERT INTO CORCFG ( CFG_CODEMP, ');
          Add( '                      CFG_NUMCON, ');
          Add( '                      CFG_NUMCAR, ');
          Add( '                      CFG_NUMADM, ');
          Add( '                      CFG_NOMUSU, ');
          Add( '                      CFG_SENHA_, ');
          Add( '                      AUTOINCREM, ');
          Add( '                      CFG_STATUS, ');
          Add( '                      CFG_HOMOLO, ');
          Add( '                      CFG_CODACE) ');
          Add( '               VALUES(:CODEMP,    ');
          Add( '                      :NUMCON,    ');
          Add( '                      :NUMCAR,    ');
          Add( '                      :NUMADM,    ');
          Add( '                      :NOMUSU,    ');
          Add( '                      :SENHA_,    ');
          Add( '                      :INCREM,    ');
          Add( '                      :STATUS,    ');
          Add( '                      :HOMOLO,    ');
          Add( '                      :CODACE)    ');

          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('NUMCON').AsString := qryCorCfg.FieldByName('CFG_NUMCON').AsString;
          ParamByName('NUMCAR').AsString := qryCorCfg.FieldByName('CFG_NUMCAR').AsString;
          ParamByName('NUMADM').AsString := qryCorCfg.FieldByName('CFG_NUMADM').AsString;
          ParamByName('NOMUSU').AsString := qryCorCfg.FieldByName('CFG_NOMUSU').AsString;
          ParamByName('SENHA_').AsString := qryCorCfg.FieldByName('CFG_SENHA_').AsString;
          ParamByName('INCREM').AsString := qryCorCfg.FieldByName('AUTOINCREM').AsString;
          ParamByName('STATUS').AsString := qryCorCfg.FieldByName('CFG_STATUS').AsString;
          ParamByName('HOMOLO').AsString := qryCorCfg.FieldByName('CFG_HOMOLO').AsString;
          ParamByName('CODACE').AsString := qryCorCfg.FieldByName('CFG_CODACE').AsString;

          ExecSQL;
        End
        Else
        Begin
          Add( ' UPDATE CORCFG SET CFG_NUMCON = :NUMCON, ');
          Add( '                   CFG_NUMCAR = :NUMCAR, ');
          Add( '                   CFG_NUMADM = :NUMADM, ');
          Add( '                   CFG_NOMUSU = :NOMUSU, ');
          Add( '                   CFG_SENHA_ = :SENHA_, ');
          Add( '                   CFG_STATUS = :STATUS, ');
          Add( '                   CFG_HOMOLO = :HOMOLO, ');
          Add( '                   CFG_CODACE = :CODACE  ');
          Add( ' WHERE AUTOINCREM = :AUTINC              ');

          ParamByName('AUTINC').AsString := qryCorCfg.FieldByName('AUTOINCREM').AsString;
          ParamByName('NUMCON').AsString := qryCorCfg.FieldByName('CFG_NUMCON').AsString;
          ParamByName('NUMCAR').AsString := qryCorCfg.FieldByName('CFG_NUMCAR').AsString;
          ParamByName('NUMADM').AsString := qryCorCfg.FieldByName('CFG_NUMADM').AsString;
          ParamByName('NOMUSU').AsString := qryCorCfg.FieldByName('CFG_NOMUSU').AsString;
          ParamByName('SENHA_').AsString := qryCorCfg.FieldByName('CFG_SENHA_').AsString;
          ParamByName('STATUS').AsString := qryCorCfg.FieldByName('CFG_STATUS').AsString;
          ParamByName('HOMOLO').AsString := qryCorCfg.FieldByName('CFG_HOMOLO').AsString;
          ParamByName('CODACE').AsString := qryCorCfg.FieldByName('CFG_CODACE').AsString;

          ExecSQL;
        End;

        While Not qryCorSer.Eof Do
        Begin
          If fCampoTabela('AUTOINCREM', 'CORSER', ['AUTOINCREM'], [qryCorSer.FieldByName('AUTOINCREM').AsString]) = '' Then
          Begin
            Close;
            Clear;
            Add(' INSERT INTO CORSER ( AUTOINCREM, ');
            Add('                      CSE_IDSERV, ');
            Add('                      CSE_CODSER, ');
            Add('                      CSE_CODIGO, ');
            Add('                      CSE_DESCRI, ');
            Add('                      CSE_SEQCFG, ');
            Add('                      CSE_CODLAY) ');
            Add('               VALUES(:INCREM,    ');
            Add('                      :IDSERV,    ');
            Add('                      :CODSER,    ');
            Add('                      :CODIGO,    ');
            Add('                      :DESCRI,    ');
            Add('                      :SEQCFG,    ');
            Add('                      :CODLAY)    ');

            ParamByName('INCREM').AsString := qryCorSer.FieldByName('AUTOINCREM').AsString;
            ParamByName('IDSERV').AsString := qryCorSer.FieldByName('CSE_IDSERV').AsString;
            ParamByName('CODSER').AsString := qryCorSer.FieldByName('CSE_CODSER').AsString;
            ParamByName('CODIGO').AsString := qryCorSer.FieldByName('CSE_CODIGO').AsString;
            ParamByName('DESCRI').AsString := qryCorSer.FieldByName('CSE_DESCRI').AsString;
            ParamByName('SEQCFG').AsString := qryCorSer.FieldByName('CSE_SEQCFG').AsString;
            ParamByName('CODLAY').AsString := qryCorSer.FieldByName('CSE_CODLAY').AsString;
            ExecSQL;
          End
          Else
          Begin
            Close;
            Clear;
            Add(' UPDATE CORSER SET CSE_CODLAY = :CODLAY WHERE AUTOINCREM = :AUTINC ');
            ParamByName('AUTINC').AsString := qryCorSer.FieldByName('AUTOINCREM').AsString;
            ParamByName('CODLAY').AsString := qryCorSer.FieldByName('CSE_CODLAY').AsString;
            ExecSQL;
          End;

          qryCorSer.Next;
        End;
      End;

      blnGravou := True;
    Except
      On E : Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    if blnGravou Then
      fCommit;
    FreeAndNil(qryInsert);
    qryCorSer.First;
    qryCorSer.EnableControls;
  End;

  if blnGravou Then
  Begin
    If Not blnCarregandoServicos Then
    Begin
      pEnabled(Not blnGravou);

      fMensagem('','Contrato Salvo com Sucesso!', ['&OK']);

      qryCorCfg.qryQuery.Params[0].AsString := '';
      qryCorCfg.fAbreClient(True, 'TfrmContratosCorreios.FormCreate');

      qryCorSer.qryQuery.Params[0].AsString := '';
      qryCorSer.fAbreClient(True, 'TfrmContratosCorreios.FormCreate');
    End;
  End;
//  inherited;
end;

procedure TfrmContratosCorreios.btnNovoContratoClick(Sender: TObject);
begin
  inherited;
  If fIncluiContrato Then
  Begin
    pEnabled(True);
    pSetFocus(dbeNumCon);
  End;
end;

function TfrmContratosCorreios.fIncluiContrato: Boolean;
begin
  Result := True;
  Try
    With qryCorCfg Do
    Begin
      Append;
      FieldByName('CFG_CODEMP').AsString := VS_strCodEmp;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORCFG', VS_strCodEmp);
      FieldByName('CFG_STATUS').AsString := 'A';
      FieldByName('CFG_HOMOLO').AsString := 'N';

      qryCorSer.qryQuery.ParamByName('SEQCFG').AsString := qryCorCfg.FieldByName('AUTOINCREM').AsString;
      qryCorSer.fAbreClient(True, 'TfrmContratosCorreios.btnCarregarContratoClick');
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmContratosCorreios.FormCreate(Sender: TObject);
begin
  inherited;
  blnCarregandoServicos := False;

  qryCorCfg := TZClient.Create(Self, ' SELECT * FROM CORCFG WHERE AUTOINCREM = :AUTINC ');

  qryCorSer := TZClient.Create(Self);
  With qryCorSer, qryQuery.SQL Do
  Begin
    Close;
    Clear;
    Add(' SELECT CORSER.*,                            ');
    Add('        IFNULL(LAY_DESCRI, "Layout Não Selecionado - (Será Utilizado o Padrão)") AS LAY_DESCRI ');
    Add(' FROM CORSER                                 ');
    Add(' LEFT JOIN LAYETI ON LAY_CODLAY = CSE_CODLAY AND LAY_TIPLAY IN (35, 36) ');
    Add(' WHERE CSE_SEQCFG = :SEQCFG                  ');
    Add(' ORDER BY CSE_DESCRI                         ');
  End;

  dbeCodAce.Visible := fCfgSis('USIGEP') = 'A';
  lblCodAce.Visible := dbeCodAce.Visible;

  cxgServicosTableViewIDSERV.Visible := Not dbeCodAce.Visible;

  dbeNumCon.DataSource := qryCorCfg.dtsSource;
  dbeNumCar.DataSource := qryCorCfg.dtsSource;
  dbeNumAdm.DataSource := qryCorCfg.dtsSource;
  dbeNomUsu.DataSource := qryCorCfg.dtsSource;
  dbeSenha_.DataSource := qryCorCfg.dtsSource;
  dbcHomolo.DataSource := qryCorCfg.dtsSource;
  dbcStatus.DataSource := qryCorCfg.dtsSource;
  dbeCodAce.DataSource := qryCorCfg.dtsSource;

  cxgServicosTableView.DataController.DataSource := qryCorSer.dtsSource;

  qryCorCfg.fAbreClient(True, 'TfrmContratosCorreios.FormCreate');
  qryCorSer.fAbreClient(True, 'TfrmContratosCorreios.FormCreate');

  pEnabled(False);
end;

procedure TfrmContratosCorreios.pEnabled(blnEnabled: Boolean);
begin
  dbeNumCon.Enabled          := blnEnabled;
  dbeNumCar.Enabled          := blnEnabled;
  dbeNumAdm.Enabled          := blnEnabled;
  dbeNomUsu.Enabled          := blnEnabled;
  dbeSenha_.Enabled          := blnEnabled;
  btnServicos.Enabled        := blnEnabled;
  cxgServicos.Enabled        := blnEnabled;
  dbcStatus.Enabled          := blnEnabled;
  dbcHomolo.Enabled          := blnEnabled;
  dbeCodAce.Enabled          := blnEnabled;

  btnConfirma.Enabled        := blnEnabled;
  btnSelecionaLayout.Enabled := blnEnabled;

end;

end.
