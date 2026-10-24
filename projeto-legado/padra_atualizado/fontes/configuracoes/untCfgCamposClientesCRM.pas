unit untCfgCamposClientesCRM;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, UniDataSetProvider, UniClientDataSet, cxCheckBox, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess,
  Provider, StdCtrls, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

Type
  TCliCampos = Record
    strCampo: String;
    strDescricao: String;
End;

type
  TfrmCfgCamposClientesCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    dbgConfDBTableView1: TcxGridDBTableView;
    dbgConfLevel1: TcxGridLevel;
    dbgConf: TcxGrid;
    dtsClientes: TDataSource;
    cdsClientes: TUniClientDataSet;
    dspClientes: TUniDataSetProvider;
    qryClientes: TUniQuery;
    qryClientesCRM_TIP_FC: TStringField;
    qryClientesCRM_NOMCAM: TStringField;
    qryClientesCRM_EXIBIR: TStringField;
    qryClientesCRM_DESCAM: TStringField;
    qryClientesCRM_CODEMP: TStringField;
    cdsClientesCRM_TIP_FC: TStringField;
    cdsClientesCRM_NOMCAM: TStringField;
    cdsClientesCRM_EXIBIR: TStringField;
    cdsClientesCRM_DESCAM: TStringField;
    cdsClientesCRM_CODEMP: TStringField;
    dbgConfDBTableView1CRM_TIP_FC: TcxGridDBColumn;
    dbgConfDBTableView1CRM_NOMCAM: TcxGridDBColumn;
    dbgConfDBTableView1CRM_EXIBIR: TcxGridDBColumn;
    dbgConfDBTableView1CRM_DESCAM: TcxGridDBColumn;
    dbgConfDBTableView1CRM_CODEMP: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
  private
    { Private declarations }
    arrClientes: Array Of TCliCampos;

    procedure pCamposArrayClientes;
    procedure pVerifiCamposExistentes;
    procedure pAdicionaTodasAsConfiguracoes;
    procedure pInsereCliCrm(strNomCam, strDesCam: String);
    procedure pAdicionaAsNaoExistentes(qrySel: TUniQuery);
    procedure pAbrirDataSet;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgCamposClientesCRM }

procedure TfrmCfgCamposClientesCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  cdsClientes.Edit;
  cdsClientes.Post;
  cdsClientes.ApplyUpdates(0);
end;

procedure TfrmCfgCamposClientesCRM.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  Try
    cdsClientes.DisableControls;
    cdsClientes.First;
    While Not cdsClientes.Eof Do
    Begin
      cdsClientes.Edit;
      cdsClientesCRM_EXIBIR.AsString := 'N';
      cdsClientes.Post;
      
      cdsClientes.Next;
    End;
    cdsClientes.First;
  Finally
    cdsClientes.EnableControls;
  End;
end;

procedure TfrmCfgCamposClientesCRM.btnMarcarClick(Sender: TObject);
begin
  inherited;
  Try
    cdsClientes.DisableControls;
    cdsClientes.First;
    While Not cdsClientes.Eof Do
    Begin
      cdsClientes.Edit;
      cdsClientesCRM_EXIBIR.AsString := 'S';
      cdsClientes.Post;

      cdsClientes.Next;
    End;
    cdsClientes.First;
  Finally
    cdsClientes.EnableControls;
  End;
end;

procedure TfrmCfgCamposClientesCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cdsClientes.EmptyDataSet;
  cdsClientes.Close;
  qryClientes.Close;
  inherited;
end;

procedure TfrmCfgCamposClientesCRM.FormCreate(Sender: TObject);
begin
  inherited;
  pCamposArrayClientes;
end;

procedure TfrmCfgCamposClientesCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
    VK_F9 :btnDesmarcar.Click;
    VK_F8 :btnMarcar.Click;
  End;
end;

procedure TfrmCfgCamposClientesCRM.FormShow(Sender: TObject);
begin
  inherited;
  pVerifiCamposExistentes;
  pAbrirDataSet;
  pSetFocus(btnConfirma);
end;

procedure TfrmCfgCamposClientesCRM.pAbrirDataSet;
begin
  With qryClientes Do
  Begin
    cdsClientes.Close;
    Close;
    SQL.Clear;
    SQL.Add(' SELECT CRM_TIP_FC, ');
    SQL.Add('        CRM_NOMCAM, ');
    SQL.Add('        CRM_EXIBIR, ');
    SQL.Add('        CRM_DESCAM, ');
    SQL.Add('        CRM_CODEMP  ');
    SQL.Add('   FROM CLICRM      ');
    SQL.Add('  WHERE CRM_CODEMP = :CODEMP ');
    SQL.Add('    AND CRM_TIP_FC = "C" ');
    SQL.Add('  ORDER BY CRM_DESCAM ');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    cdsClientes.Open;
  End;
end;

procedure TfrmCfgCamposClientesCRM.pAdicionaAsNaoExistentes(qrySel: TUniQuery);
var
  intCont: Integer;
begin
  With qrySel Do
  Begin
    For intCont := 0 To Length(arrClientes) - 1 Do
    Begin
      If Not Locate('CRM_NOMCAM',arrClientes[intCont].strCampo,[])  Then
        pInsereCliCrm(arrClientes[intCont].strCampo, arrClientes[intCont].strDescricao);
    End;
  End;
end;

procedure TfrmCfgCamposClientesCRM.pAdicionaTodasAsConfiguracoes;
var
  intCont: Integer;
begin
  For intCont := 0 To Length(arrClientes) - 1 Do
    pInsereCliCrm(arrClientes[IntCont].strCampo, arrClientes[IntCont].strDescricao);
end;

procedure TfrmCfgCamposClientesCRM.pCamposArrayClientes;
var
  intPosCli: Integer;

  function fSoma(Var intVal: Integer; intSoma: Integer = 1): Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;
begin
  intPosCli := 0;
  SetLength(arrClientes,1);

  arrClientes[intPosCli].strCampo     := 'CLI_FANSOB';
  arrClientes[intPosCli].strDescricao := 'Nome Fantasia';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMCID';
  arrClientes[intPosCli].strDescricao := 'Cidade';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_C_E_P_';
  arrClientes[intPosCli].strDescricao := 'Cep';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_ENDERE';
  arrClientes[intPosCli].strDescricao := 'Endereço';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_ENDNUM';
  arrClientes[intPosCli].strDescricao := 'Número';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_ENDCOM';
  arrClientes[intPosCli].strDescricao := 'Complemento';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_BAIRRO';
  arrClientes[intPosCli].strDescricao := 'Bairro';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_C_G_C_';
  arrClientes[intPosCli].strDescricao := 'Cnpj / Cpf';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NUMR_G';
  arrClientes[intPosCli].strDescricao := 'Rg';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_I_E_S_';
  arrClientes[intPosCli].strDescricao := 'Inscr. Estadual';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_I_M_P_';
  arrClientes[intPosCli].strDescricao := 'Inscr. Municipal';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NASCIM';
  arrClientes[intPosCli].strDescricao := 'Fundação/Nascimento';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_CAIPOS';
  arrClientes[intPosCli].strDescricao := 'Caixa Postal';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_FONE01';
  arrClientes[intPosCli].strDescricao := 'Telefone 1';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_RAMAL1';
  arrClientes[intPosCli].strDescricao := 'Ramal 1';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_FONE02';
  arrClientes[intPosCli].strDescricao := 'Telefone 2';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_RAMAL2';
  arrClientes[intPosCli].strDescricao := 'Ramal 2';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_F_A_X_';
  arrClientes[intPosCli].strDescricao := 'Fax';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_RAMAL3';
  arrClientes[intPosCli].strDescricao := 'Ramal 3';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_CELULA';
  arrClientes[intPosCli].strDescricao := 'Celular';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NEXTEL';
  arrClientes[intPosCli].strDescricao := 'Nextel';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_EMAIL_';
  arrClientes[intPosCli].strDescricao := 'E-mail';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_CONTAT';
  arrClientes[intPosCli].strDescricao := 'Contato';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_EMAIL2';
  arrClientes[intPosCli].strDescricao := 'E-mail 2';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_EMAIL3';
  arrClientes[intPosCli].strDescricao := 'E-mail Nfe';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_CONSUM';
  arrClientes[intPosCli].strDescricao := 'Consumidor Final';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_HOMEPA';
  arrClientes[intPosCli].strDescricao := 'Home Page';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMVEN';
  arrClientes[intPosCli].strDescricao := 'Vendedor';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMREP';
  arrClientes[intPosCli].strDescricao := 'Representante';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMSGE';
  arrClientes[intPosCli].strDescricao := 'Supervisor Geral';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMSRE';
  arrClientes[intPosCli].strDescricao := 'Supervisor Regional';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_DESATI';
  arrClientes[intPosCli].strDescricao := 'Atividade';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_TABPRE';
  arrClientes[intPosCli].strDescricao := 'Tabela de Preço';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_LIMCRE';
  arrClientes[intPosCli].strDescricao := 'Limite de Crédito';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_DESFPG';
  arrClientes[intPosCli].strDescricao := 'Forma Pagamento';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_DESTCL';
  arrClientes[intPosCli].strDescricao := 'Tipo de Cliente';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_DESPOR';
  arrClientes[intPosCli].strDescricao := 'Portador';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_DESCON';
  arrClientes[intPosCli].strDescricao := 'Desc. para Profissionais';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_PERCOM';
  arrClientes[intPosCli].strDescricao := 'Comissão';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_PEREMP';
  arrClientes[intPosCli].strDescricao := 'Permite Emprestimo';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_DESREG';
  arrClientes[intPosCli].strDescricao := 'Região';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMDIV';
  arrClientes[intPosCli].strDescricao := 'Profissional';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMRED';
  arrClientes[intPosCli].strDescricao := 'Rede de Lojas';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMCAC';
  arrClientes[intPosCli].strDescricao := 'Canal de Acesso';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_ATRMAX';
  arrClientes[intPosCli].strDescricao := 'Atraso Máximo Dias';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_PERMFF';
  arrClientes[intPosCli].strDescricao := 'Permite FF (A Prazo)';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMFXA';
  arrClientes[intPosCli].strDescricao := 'Faixa Condiçao Pgto';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_NOMERC';
  arrClientes[intPosCli].strDescricao := 'Emp. Confirmação Docto.';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_REGTRI';
  arrClientes[intPosCli].strDescricao := 'Regime Tributário';
  SetLength(arrClientes, fSoma(intPosCli));

  arrClientes[intPosCli].strCampo     := 'CLI_PERMFV';
  arrClientes[intPosCli].strDescricao := 'Permite FF (À Vista)';
//  SetLength(arrClientes, fSoma(intPosCli));
end;

procedure TfrmCfgCamposClientesCRM.pInsereCliCrm(strNomCam, strDesCam: String);
var
  qryIns: TUniQuery;
begin
  Try
    qryIns := fCriaQuery(Nil);
    With qryIns Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO CLICRM ');
      SQL.Add(' (                  ');
      SQL.Add('    CRM_TIP_FC,     ');
      SQL.Add('    CRM_NOMCAM,     ');
      SQL.Add('    CRM_EXIBIR,     ');
      SQL.Add('    CRM_DESCAM,     ');
      SQL.Add('    CRM_CODEMP      ');
      SQL.Add(' )                  ');
      SQL.Add('      VALUES        ');
      SQL.Add(' (                  ');
      SQL.Add('     :TIP_FC,       ');
      SQL.Add('     :NOMCAM,       ');
      SQL.Add('     :EXIBIR,       ');
      SQL.Add('     :DESCAM,       ');
      SQL.Add('     :CODEMP        ');
      SQL.Add(' )                  ');
      ParamByName('TIP_FC').AsString := 'C';
      ParamByName('NOMCAM').AsString := strNomCam;
      ParamByName('EXIBIR').AsString := 'S';
      ParamByName('DESCAM').AsString := strDesCam;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCfgCamposClientesCRM.pVerifiCamposExistentes;
var
  qryCons: TUniQuery;
begin
  Try
    qryCons := fCriaQuery(Nil);
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CRM_TIP_FC, ');
      SQL.Add('        CRM_NOMCAM, ');
      SQL.Add('        CRM_EXIBIR, ');
      SQL.Add('        CRM_DESCAM, ');
      SQL.Add('        CRM_CODEMP  ');
      SQL.Add('  FROM CLICRM       ');
      SQL.Add(' WHERE CRM_CODEMP = :CODEMP ');
      SQL.Add('   AND CRM_TIP_FC = "C"     ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If IsEmpty Then
        pAdicionaTodasAsConfiguracoes
      Else
        pAdicionaAsNaoExistentes(qryCons);
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

end.
