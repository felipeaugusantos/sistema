unit untCfgCamposFornecedoresCRM;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, UniDataSetProvider, UniClientDataSet, cxCheckBox, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider,
  StdCtrls, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

Type
  TForCampos = Record
    strCampo: String;
    strDescricao: String;
End;

type
  TfrmCfgCamposFornecedoresCRM = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    dbgConfDBTableView1: TcxGridDBTableView;
    dbgConfLevel1: TcxGridLevel;
    dbgConf: TcxGrid;
    dtsFornecedores: TDataSource;
    cdsFornecedores: TUniClientDataSet;
    dspFornecedores: TUniDataSetProvider;
    qryFornecedores: TUniQuery;
    qryFornecedoresCRM_TIP_FC: TStringField;
    qryFornecedoresCRM_NOMCAM: TStringField;
    qryFornecedoresCRM_EXIBIR: TStringField;
    qryFornecedoresCRM_DESCAM: TStringField;
    qryFornecedoresCRM_CODEMP: TStringField;
    cdsFornecedoresCRM_TIP_FC: TStringField;
    cdsFornecedoresCRM_NOMCAM: TStringField;
    cdsFornecedoresCRM_EXIBIR: TStringField;
    cdsFornecedoresCRM_DESCAM: TStringField;
    cdsFornecedoresCRM_CODEMP: TStringField;
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
    arrFornecedores: Array Of TForCampos;

    procedure pCamposArrayFornecedores;
    procedure pVerifiCamposExistentes;
    procedure pAdicionaTodasAsConfiguracoes;
    procedure pInsereForCrm(strNomCam, strDesCam: String);
    procedure pAdicionaAsNaoExistentes(qrySel: TUniQuery);
    procedure pAbrirDataSet;

  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgCamposFornecedoresCRM }

procedure TfrmCfgCamposFornecedoresCRM.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  cdsFornecedores.Edit;
  cdsFornecedores.Post;
  cdsFornecedores.ApplyUpdates(0);
end;

procedure TfrmCfgCamposFornecedoresCRM.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  Try
    cdsFornecedores.DisableControls;
    cdsFornecedores.First;
    While Not cdsFornecedores.Eof Do
    Begin
      cdsFornecedores.Edit;
      cdsFornecedoresCRM_EXIBIR.AsString := 'N';
      cdsFornecedores.Post;
      
      cdsFornecedores.Next;
    End;
    cdsFornecedores.First;
  Finally
    cdsFornecedores.EnableControls;
  End;
end;

procedure TfrmCfgCamposFornecedoresCRM.btnMarcarClick(Sender: TObject);
begin
  inherited;
  Try
    cdsFornecedores.DisableControls;
    cdsFornecedores.First;
    While Not cdsFornecedores.Eof Do
    Begin
      cdsFornecedores.Edit;
      cdsFornecedoresCRM_EXIBIR.AsString := 'S';
      cdsFornecedores.Post;

      cdsFornecedores.Next;
    End;
    cdsFornecedores.First;
  Finally
    cdsFornecedores.EnableControls;
  End;
end;

procedure TfrmCfgCamposFornecedoresCRM.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cdsFornecedores.EmptyDataSet;
  cdsFornecedores.Close;
  qryFornecedores.Close;
  inherited;
end;

procedure TfrmCfgCamposFornecedoresCRM.FormCreate(Sender: TObject);
begin
  inherited;
  pCamposArrayFornecedores;
end;

procedure TfrmCfgCamposFornecedoresCRM.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
    VK_F9 :btnDesmarcar.Click;
    VK_F8 :btnMarcar.Click;
  End;
end;

procedure TfrmCfgCamposFornecedoresCRM.FormShow(Sender: TObject);
begin
  inherited;
  pVerifiCamposExistentes;
  pAbrirDataSet;
  pSetFocus(btnConfirma);
end;

procedure TfrmCfgCamposFornecedoresCRM.pAbrirDataSet;
begin
  With qryFornecedores Do
  Begin
    cdsFornecedores.Close;
    Close;
    SQL.Clear;
    SQL.Add(' SELECT CRM_TIP_FC, ');
    SQL.Add('        CRM_NOMCAM, ');
    SQL.Add('        CRM_EXIBIR, ');
    SQL.Add('        CRM_DESCAM, ');
    SQL.Add('        CRM_CODEMP  ');
    SQL.Add('   FROM CLICRM      ');
    SQL.Add('  WHERE CRM_CODEMP = :CODEMP ');
    SQL.Add('    AND CRM_TIP_FC = "F" ');
    SQL.Add('  ORDER BY CRM_DESCAM ');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    cdsFornecedores.Open;
  End;
end;

procedure TfrmCfgCamposFornecedoresCRM.pAdicionaAsNaoExistentes(qrySel: TUniQuery);
var
  intCont: Integer;
begin
  With qrySel Do
  Begin
    For intCont := 0 To Length(arrFornecedores) - 1 Do
    Begin
      If Not Locate('CRM_NOMCAM',arrFornecedores[intCont].strCampo,[])  Then
        pInsereForCrm(arrFornecedores[intCont].strCampo, arrFornecedores[intCont].strDescricao);
    End;
  End;
end;

procedure TfrmCfgCamposFornecedoresCRM.pAdicionaTodasAsConfiguracoes;
var
  intCont: Integer;
begin
  For intCont := 0 To Length(arrFornecedores) - 1 Do
    pInsereForCrm(arrFornecedores[IntCont].strCampo, arrFornecedores[IntCont].strDescricao);
end;

procedure TfrmCfgCamposFornecedoresCRM.pCamposArrayFornecedores;
var
  intPosCli: Integer;

  function fSoma(Var intVal: Integer; intSoma: Integer = 1): Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;
begin
  intPosCli := 0;
  SetLength(arrFornecedores,1);

  arrFornecedores[intPosCli].strCampo     := 'FOR_C_G_C_';
  arrFornecedores[intPosCli].strDescricao := 'Cnpj/Cpf';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CAIPOS';
  arrFornecedores[intPosCli].strDescricao := 'Caixa Postal';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_I_E_S_';
  arrFornecedores[intPosCli].strDescricao := 'Inscrição Estadual';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CONCON';
  arrFornecedores[intPosCli].strDescricao := 'Conta Contábil';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_SIMPAU';
  arrFornecedores[intPosCli].strDescricao := 'Simple Paulista';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_PERFCX';
  arrFornecedores[intPosCli].strDescricao := 'Frete Fluxo Caixa';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_MATREV';
  arrFornecedores[intPosCli].strDescricao := 'Tipo Fornec.';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CENTCD';
  arrFornecedores[intPosCli].strDescricao := 'Plano de Contas Diário';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CNDPAG';
  arrFornecedores[intPosCli].strDescricao := 'Condição de Pagamento';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_EMAPED';
  arrFornecedores[intPosCli].strDescricao := 'Email Pedido';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CENTCC';
  arrFornecedores[intPosCli].strDescricao := 'Plano de Contas Compras';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_VLRED2';
  arrFornecedores[intPosCli].strDescricao := 'Arred. Valor a partir 2º parcela';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CARPAG';
  arrFornecedores[intPosCli].strDescricao := 'Carrência para pagamento pedido compra';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_DESVIS';
  arrFornecedores[intPosCli].strDescricao := 'Desconto pagamento a vista';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NOMFOR';
  arrFornecedores[intPosCli].strDescricao := 'Fornecedor';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NOMFAN';
  arrFornecedores[intPosCli].strDescricao := 'Nome Fantasia';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NOMCID';
  arrFornecedores[intPosCli].strDescricao := 'Cidade';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_DESATI';
  arrFornecedores[intPosCli].strDescricao := 'Atividade';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NOMTRA';
  arrFornecedores[intPosCli].strDescricao := 'Transportadora';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NOMOPE';
  arrFornecedores[intPosCli].strDescricao := 'Operador';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_FONE01';
  arrFornecedores[intPosCli].strDescricao := 'Telefone 1';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_FONE02';
  arrFornecedores[intPosCli].strDescricao := 'Telefone 2';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_F_A_X_';
  arrFornecedores[intPosCli].strDescricao := 'FAX';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_0800__';
  arrFornecedores[intPosCli].strDescricao := '0800';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_ENDERE';
  arrFornecedores[intPosCli].strDescricao := 'Endereço';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_ENDCOM';
  arrFornecedores[intPosCli].strDescricao := 'Complemento';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_C_E_P_';
  arrFornecedores[intPosCli].strDescricao := 'CEP';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_BAIRRO';
  arrFornecedores[intPosCli].strDescricao := 'Bairro';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_ENDNUM';
  arrFornecedores[intPosCli].strDescricao := 'Número';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NUMCEL';
  arrFornecedores[intPosCli].strDescricao := 'Celular';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_CONTAT';
  arrFornecedores[intPosCli].strDescricao := 'Contato';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_EMAIL_';
  arrFornecedores[intPosCli].strDescricao := 'E-mail';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_EMAIL2';
  arrFornecedores[intPosCli].strDescricao := 'E-mail 2';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_HOMEPA';
  arrFornecedores[intPosCli].strDescricao := 'Home Page';
  SetLength(arrFornecedores, fSoma(intPosCli));

  arrFornecedores[intPosCli].strCampo     := 'FOR_NUMRG_';
  arrFornecedores[intPosCli].strDescricao := 'RG';
//  SetLength(arrFornecedores, fSoma(intPosCli));
end;

procedure TfrmCfgCamposFornecedoresCRM.pInsereForCrm(strNomCam, strDesCam: String);
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
      ParamByName('TIP_FC').AsString := 'F';
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

procedure TfrmCfgCamposFornecedoresCRM.pVerifiCamposExistentes;
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
      SQL.Add('   FROM CLICRM      ');
      SQL.Add('  WHERE CRM_CODEMP = :CODEMP ');
      SQL.Add('    AND CRM_TIP_FC = "F" ');
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
