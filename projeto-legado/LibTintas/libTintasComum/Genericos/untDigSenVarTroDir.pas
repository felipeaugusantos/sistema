unit untDigSenVarTroDir;

interface

Uses
  Uni, SysUtils, Data.DB;

Type
  TDigSenVarTroDir = Class

  public
    constructor Create;
    destructor Destroy; override;


    function fDigSenVarTroDir(strNomeCli, strCpfCnpj, strCliCid, strVendedor, strIdepro,
      strDescTinta, strUnidade, strBaseAtual, strBaseNova, strDescAdicional: String) : Boolean;


  End;

implementation

uses untLiberacaoCliente, untFuncoesSimples;

{ TValidarBaseItemAmarracao }

constructor TDigSenVarTroDir.Create;
begin

end;

destructor TDigSenVarTroDir.Destroy;
begin

  inherited;
end;



function TDigSenVarTroDir.fDigSenVarTroDir(strNomeCli, strCpfCnpj, strCliCid, strVendedor, strIdepro,
                                           strDescTinta, strUnidade, strBaseAtual, strBaseNova, strDescAdicional: String) : Boolean;
begin

  Try
    VS_blnResult := true;




    frmLiberacaoCliente := TfrmLiberacaoCliente.Create(Nil);

    Try
      With frmLiberacaoCliente Do
      Begin

        MemObs.Lines.Add('Troca de Base de Tinta Imobiliária.');
        MemObs.Lines.Add('----------------------------------------------------------------------------------------------------');
        MemObs.Lines.Add('Cliente.: ' + strNomeCli);
        MemObs.Lines.Add('CPF/CNPJ: ' + strCpfCnpj +' - Cidade: '+ strCliCid);
        MemObs.Lines.Add('----------------------------------------------------------------------------------------------------');
        MemObs.Lines.Add('Vendedor: ' + strVendedor );
        MemObs.Lines.Add('----------------------------------------------------------------------------------------------------');
        MemObs.Lines.Add('IDEPRO.: ' + strIdepro);
        MemObs.Lines.Add('Tinta..: ' + strDescTinta + ' - ' + ' Unidade: '+ strUnidade);
        MemObs.Lines.Add('----------------------------------------------------------------------------------------------------');
        MemObs.Lines.Add('Base Atual.: ' + strBaseAtual);
        MemObs.Lines.Add('Nova Base..: ' + strBaseNova);
        MemObs.Lines.Add('----------------------------------------------------------------------------------------------------');
        MemObs.Lines.Add('Descrição Adicional.:' + strDescAdicional);
        MemObs.Lines.Add('----------------------------------------------------------------------------------------------------');

        frmLiberacaoCliente.strTagLiberacao  := 'TRODIR';
        frmLiberacaoCliente.strMessageHeader := 'A T E N Ç Ã O - LIBERAÇÃO DE ACESSO PARA TROCA DE BASE';

        ShowModal;

        {if (VS_blnResult) Then
        begin
          qryLogTin := fCriaQuery();

          Try
            qryLogTin.Close;
            qryLogTin.SQl.Text := 'SELECT * FROM LOGTIN WHERE FALSE';
            qryLogTin.Open;

            qryLogTin.Insert;
            qryLogTin.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGTIN', VS_strCodEmp);
            qryLogTin.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
            qryLogTin.FieldByName('LOG_HORALT').AsDateTime := fTime();
            qryLogTin.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
            qryLogTin.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
            qryLogTin.FieldByName('LOG_EMPCFG').AsString   := VS_strCodEmp;
            qryLogTin.FieldByName('LOG_CODCFG').AsString   := 'BASITE';
            qryLogTin.FieldByName('LOG_IDEPRO').AsString   := strIdePro;
            qryLogTin.FieldByName('LOG_VALANT').AsString   := strValAnt;
            qryLogTin.FieldByName('LOG_VALATU').AsString   := strValAtu;
            qryLogTin.Post;
          Finally
            FreeAndNil(qryLogTin);
          end;
        end;
        }
      end;

    Finally
      If Assigned(frmLiberacaoCliente) Then FreeAndNil(frmLiberacaoCliente);
    End;

  Finally
    Result := VS_blnResult;
  End;

end;

end.
